//
//  SeriesArchiveTableViewController.m
//  WatchPad
//
//  Created by Sven Schiffer on 10.2.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "SeriesArchiveTableViewController.h"

@implementation SeriesArchiveTableViewController

- (void) viewWillAppear:(BOOL)animated {
    // Reload the series
    self.series = [self.seriesManager loadData];
    
    [self.series filterUsingPredicate: [NSPredicate predicateWithBlock:^BOOL(Series *series, NSDictionary *bindings) {
        return ([series episodesWatched] == [series episodesCount]);
    }]];
    
    [self.tableView reloadData];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end