//
//  SeriesArchiveTableViewController.m
//  WatchPad
//
//  Created by Sven Schiffer on 10.2.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "SeriesArchiveTableViewController.h"

@implementation SeriesArchiveTableViewController

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Series *series = self.series[indexPath.row];
    
    if([series episodesWatched] == [series episodesCount]) {
        return 115.0f;
    }
    else {
        return 0.0f;
    }
}

- (SeriesCollectionTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SeriesCollectionTableViewCell *cell = (SeriesCollectionTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:akCellIdentifier];
    
    Series *series = self.series[indexPath.row];
    [self configureCell:cell forSeries:series];
    
    if([series episodesWatched] == [series episodesCount]) {
        cell.hidden = NO;
    }
    else {
        cell.hidden = YES;
    }
    
    return cell;
}

@end