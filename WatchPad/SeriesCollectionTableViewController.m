//
//  SeriesCollectionTableViewController.m
//  WatchPad
//
//  Created by Sven Schiffer on 19.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "SeriesCollectionTableViewController.h"
#import "Series.h"
#import "SeriesCollectionTableViewCell.h"
#import "SeasonTableViewController.h"

NSString *const akCellIdentifier = @"seriesCollectionTableCell";
NSString *const akTableCellNibName = @"SeriesCollectionTableCell";

@implementation SeriesCollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // we use a nib which contains the cell's view and this class as the files owner
    [self.tableView registerNib:[UINib nibWithNibName:akTableCellNibName bundle:nil] forCellReuseIdentifier:akCellIdentifier];
    
    self.seriesManager = [[SeriesManager alloc] init];
}

- (void) viewWillAppear:(BOOL)animated {
    // Reload the series
    self.series = [self.seriesManager reloadData];
    
    Series *tmp = self.series[0];
    NSLog(@"number of seasons for %@: %d", tmp.title, [tmp seasonsCount]);
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.series.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 115;
}

- (SeriesCollectionTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SeriesCollectionTableViewCell *cell = (SeriesCollectionTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:akCellIdentifier];
    
    Series *series = self.series[indexPath.row];
    [self configureCell:cell forSeries:series];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Series *selectedSeries = self.series[indexPath.row];
    
    SeasonTableViewController *seasonViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SeasonTableViewController"];
    seasonViewController.title = selectedSeries.title;
    seasonViewController.seasons = selectedSeries.seasons; // hand off the current series' episodes to the season controller
    
    [self.navigationController pushViewController:seasonViewController animated:YES];
    
    // note: should not be necessary but current iOS 8.0 bug (seed 4) requires it
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (void)configureCell:(SeriesCollectionTableViewCell *)cell forSeries:(Series *)series {
    cell.title_label.text = series.title;
    cell.summary_label.text = series.summary;
    cell.watch_progress.progress = 0;
    cell.cover_image.image = series.cover;
}

@end