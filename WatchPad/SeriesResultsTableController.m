//
//  SeriesResultsTableController.m
//  WatchPad
//
//  Created by Sven Schiffer on 24.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "SeriesResultsTableController.h"
#import "Series.h"

@implementation SeriesResultsTableController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredSeries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    Series *series = self.filteredSeries[indexPath.row];
    [self configureCell:cell forSeries:series];
    
    return cell;
}

@end
