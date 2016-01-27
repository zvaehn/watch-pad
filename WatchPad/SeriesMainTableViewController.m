//
//  SeriesMainTableViewController.m
//  WatchPad
//
//  Created by Sven Schiffer on 19.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "SeriesMainTableViewController.h"
#import "SeriesDetailViewController.h"
#import "SeriesResultsTableController.h"
#import "SeriesInterfaceConnection.h"
#import "Series.h"

#import "AFURLSessionManager.h"

@interface SeriesMainTableViewController () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) SeriesResultsTableController *resultsTableController;
@property (nonatomic, strong) SeriesInterfaceConnection *interfaceConnection;

// for state restoration
@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;

@property NSURLSessionDataTask *seriesFilterTask;

@end

#pragma mark -

@implementation SeriesMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _resultsTableController = [[SeriesResultsTableController alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableController];
    
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    // we want to be the delegate for our filtered table so didSelectRowAtIndexPath is called for both tables
    self.resultsTableController.tableView.delegate = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = YES; // default is YES
    self.searchController.searchBar.delegate = self; // so we can monitor text changes + others
    
    // Search is now just presenting a view controller. As such, normal view controller
    // presentation semantics apply. Namely that presentation will walk up the view controller
    // hierarchy until it finds the root view controller or one that defines a presentation context.
    self.definesPresentationContext = YES;  // know where you want UISearchController to be displayed}
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // restore the searchController's active state
    if (self.searchControllerWasActive) {
        self.searchController.active = self.searchControllerWasActive;
        _searchControllerWasActive = NO;
        
        if (self.searchControllerSearchFieldWasFirstResponder) {
            [self.searchController.searchBar becomeFirstResponder];
            _searchControllerSearchFieldWasFirstResponder = NO;
        }
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}


#pragma mark - UISearchControllerDelegate

// Called after the search controller's search bar has agreed to begin editing or when
// 'active' is set to YES.
// If you choose not to present the controller yourself or do not implement this method,
// a default presentation is performed on your behalf.
//
// Implement this method if the default presentation is not adequate for your purposes.
//
- (void)presentSearchController:(UISearchController *)searchController {
    
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    // do something after the search controller is presented
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    // do something before the search controller is dismissed
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    // do something after the search controller is dismissed
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.series.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    
    Series *series = self.series[indexPath.row];
    [self configureCell:cell forSeries:series];
    
    return cell;
}


// here we are the table view delegate for both our main table and filtered table, so we can
// push from the current navigation controller (resultsTableController's parent view controller
// is not this UINavigationController)
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Series *selectedSeries = (tableView == self.tableView) ?
    self.series[indexPath.row] : self.resultsTableController.filteredSeries[indexPath.row];
    
    SeriesDetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SeriesDetailViewController"];
    detailViewController.title = selectedSeries.title;
    detailViewController.series = selectedSeries; // hand off the current series to the detail view controller
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    // note: should not be necessary but current iOS 8.0 bug (seed 4) requires it
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // update the filtered array based on the search text
    
    NSString *searchText = _searchController.searchBar.text;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    // Create an URLRequest with encoded parameters
    NSDictionary *parameters = @{@"q": searchText};
    NSString *urlString = @"http://api.tvmaze.com/search/shows";
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlString parameters:parameters error:nil];
    
    // Cancel the previous task
    [_seriesFilterTask cancel];
    
    _seriesFilterTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }
        else {
            NSDictionary *responseCode = responseObject;
            SeriesResultsTableController *tableController = (SeriesResultsTableController *)self.searchController.searchResultsController;
            
            [tableController.tableView reloadData];
            
            if([responseObject valueForKey:@"status"] == nil) {
                NSLog(@"an error occured: %@", [responseObject valueForKey:@"message"]);
            }
            else {
                NSArray *responseItems = responseObject;
                
                NSMutableArray *resultsArray = [[NSMutableArray alloc] init];
                
                if([responseItems count] > 0) {
                    for (NSDictionary *item in responseItems) {
                        NSDictionary *seriesData = [item objectForKey:@"show"];
                        
                        NSNumber *id = [seriesData objectForKey:@"id"];
                        NSString *title = [seriesData objectForKey:@"name"];
                        NSString *summary = [seriesData objectForKey:@"summary"];
                        NSNumber *rating = [[seriesData objectForKey:@"rating"] objectForKey:@"average"];
                        NSNumber *updated = [seriesData objectForKey:@"updated"];
                        NSString *network = @"unknown";
                        NSString *image_url = @"http://tvmazecdn.com/images/no-img/no-img-portrait-text.png";
                        
                        // Remove HTML Tags
                        NSRange range;
                        NSString *summary_string = summary;
                        while ((range = [summary_string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound){
                            summary_string = [summary_string stringByReplacingCharactersInRange:range withString:@""];
                        }
                        
                        NSDictionary *images = [seriesData objectForKey:@"image"];
                        NSDictionary *networkdata = [seriesData objectForKey:@"network"];
                        
                        if (![images isKindOfClass:[NSNull class]]) {
                            if (![[images objectForKey:@"medium"] isKindOfClass:[NSNull class]]) {
                                image_url = [images objectForKey:@"medium"]; // check for availability
                            }
                        }
                        
                        if (![networkdata isKindOfClass:[NSNull class]]) {
                            if (![[networkdata objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
                                network = [networkdata objectForKey:@"name"]; 
                            }
                        }
                        
                        Series *currentSeries = [Series seriesWithId:id title:title];
                        currentSeries.network = network;
                        currentSeries.summary = summary_string;
                        currentSeries.avgRating = ([rating isKindOfClass:[NSNull class]]) ? @0 : rating;
                        currentSeries.updated = updated;
                        currentSeries.cover_url = image_url;
                        
                        [resultsArray addObject:currentSeries];
                        tableController.filteredSeries = [NSArray arrayWithArray: resultsArray];
                        [tableController.tableView reloadData];
                    }
                }
                else {
                    tableController.filteredSeries = [[NSArray alloc] init];
                    [tableController.tableView reloadData];
                }
            }
        }
    }];
    
    [_seriesFilterTask resume];
}


#pragma mark - UIStateRestoration

// we restore several items for state restoration:
//  1) Search controller's active state,
//  2) search text,
//  3) first responder

NSString *const ViewControllerTitleKey = @"ViewControllerTitleKey";
NSString *const SearchControllerIsActiveKey = @"SearchControllerIsActiveKey";
NSString *const SearchBarTextKey = @"SearchBarTextKey";
NSString *const SearchBarIsFirstResponderKey = @"SearchBarIsFirstResponderKey";

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    // encode the view state so it can be restored later
    
    // encode the title
    [coder encodeObject:self.title forKey:ViewControllerTitleKey];
    
    UISearchController *searchController = self.searchController;
    
    // encode the search controller's active state
    BOOL searchDisplayControllerIsActive = searchController.isActive;
    [coder encodeBool:searchDisplayControllerIsActive forKey:SearchControllerIsActiveKey];
    
    // encode the first responser status
    if (searchDisplayControllerIsActive) {
        [coder encodeBool:[searchController.searchBar isFirstResponder] forKey:SearchBarIsFirstResponderKey];
    }
    
    // encode the search bar text
    [coder encodeObject:searchController.searchBar.text forKey:SearchBarTextKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    // restore the title
    self.title = [coder decodeObjectForKey:ViewControllerTitleKey];
    
    // restore the active state:
    // we can't make the searchController active here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerWasActive = [coder decodeBoolForKey:SearchControllerIsActiveKey];
    
    // restore the first responder status:
    // we can't make the searchController first responder here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerSearchFieldWasFirstResponder = [coder decodeBoolForKey:SearchBarIsFirstResponderKey];
    
    // restore the text in the search field
    self.searchController.searchBar.text = [coder decodeObjectForKey:SearchBarTextKey];
}

@end
