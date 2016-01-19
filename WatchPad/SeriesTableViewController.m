//
//  SeriesTableViewController
//  WatchPad
//
//  Created by Sven Schiffer on 12.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "SeriesTableViewController.h"

@interface SeriesTableViewController ()

@property (strong, nonatomic) NSArray *data;

@end

@implementation SeriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //contentList = [[NSMutableArray alloc] init];
    contentList = [[NSMutableArray alloc] initWithObjects:@"iPhone", @"iPod", @"iPod touch", @"iMac", @"Mac Pro", @"iBook",@"MacBook", @"MacBook Pro", @"PowerBook", nil];
    
    seriesSearchResultsList = [[NSMutableArray alloc] init];
    
    //self.clearsSelectionOnViewWillAppear = YES;
    //self.data = [NSArray arrayWithObjects: [[Series alloc] init], [[Series alloc] init]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(isSearching) {
        return (NSInteger)[seriesSearchResultsList count];
    }
    else {
        return (NSInteger)[contentList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    /*NSString *name = [self.data[indexPath.row] name];
    NSString *summary = [self.data[indexPath.row] summary];
    NSString *imageurl = [self.data[indexPath.row] imageurl];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SeriesTableViewCell" forIndexPath:indexPath];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *summaryLabel = (UILabel *)[cell viewWithTag:2];
    UIImage *coverImage = (UIImage *)[cell viewWithTag:3];
    
    nameLabel.text = name;
    summaryLabel.text = summary;
    coverImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: imageurl]]];
    
    return cell;*/
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    if (isSearching) {
        cell.textLabel.text = [seriesSearchResultsList objectAtIndex:indexPath.row];
    }
    else {
        cell.textLabel.text = [contentList objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)searchSeries {
    NSString *searchString = self.searchBar.text;
    
    for(NSString *tmp in contentList) {
        NSComparisonResult result = [tmp compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (result == NSOrderedSame) {
            [seriesSearchResultsList addObject:tmp];
        }
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = YES;
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Text change - %d", isSearching);
    
    //Remove all objects first.
    [seriesSearchResultsList removeAllObjects];
    
    if([searchText length] != 0) {
        isSearching = YES;
        [self searchSeries]; // trigger new search
    }
    else {
        isSearching = NO;
    }
    // [self.tblContentList reloadData];
}

- (void)searchBarTextDidEndEditing {
    isSearching = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Cancel clicked");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self seriesSearchResultsList];
}

@end
