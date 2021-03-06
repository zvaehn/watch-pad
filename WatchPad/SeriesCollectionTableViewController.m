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
    self.series = [self.seriesManager loadData];
    
    NSLog(@"number of seasons in collection: %lu", self.series.count);
}

- (void) viewWillAppear:(BOOL)animated {
    // Reload the series
    self.series = [self.seriesManager loadData];
    
    // hide completed series
    /*[self.series filterUsingPredicate: [NSPredicate predicateWithBlock:^BOOL(Series *series, NSDictionary *bindings) {
        return ([series episodesWatched] < [series episodesCount]);
    }]];*/
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.series.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Series *series = self.series[indexPath.row];
    
    if([series episodesWatched] == [series episodesCount]) {
        return 0.0f;
    }
    else {
        return 115.0f;
    }
}

- (SeriesCollectionTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SeriesCollectionTableViewCell *cell = (SeriesCollectionTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:akCellIdentifier];
    
    Series *series = self.series[indexPath.row];
    [self configureCell:cell forSeries:series];
    
    if([series episodesWatched] == [series episodesCount]) {
        cell.hidden = YES;
    }
    else {
        cell.hidden = NO;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Series *selectedSeries = self.series[indexPath.row];
    
    UIStoryboard *seriesSB = [UIStoryboard storyboardWithName:@"Series" bundle:nil];
    
    SeasonTableViewController *seasonViewController = [seriesSB instantiateViewControllerWithIdentifier:@"SeasonTableViewController"];
    seasonViewController.title = selectedSeries.title;
    seasonViewController.seasons = selectedSeries.seasons; // hand off the current series' episodes to the season controller
    seasonViewController.seriesManager = self.seriesManager;
    
    [self.navigationController pushViewController:seasonViewController animated:YES];
    
    // note: should not be necessary but current iOS 8.0 bug (seed 4) requires it
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)configureCell:(SeriesCollectionTableViewCell *)cell forSeries:(Series *)series {
    int watched = [series episodesWatched];
    int total = [series episodesCount];
    float percentage = (float) watched/total*100;
    
    //NSLog(@"%@ episodes: (%d/%d). Thats %f percent!", series.title, [series episodesWatched], [series episodesCount], percentage);
    
    cell.title_label.text = series.title;
    cell.summary_label.text = series.summary;
    cell.watch_progress.progress = percentage/100;
    cell.cover_image.image = series.cover;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.series removeObjectAtIndex:indexPath.row];
        [self.seriesManager commit];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end