//
//  SeriesCollectionTableViewController.m
//  WatchPad
//
//  Created by Sven Schiffer on 19.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "SeriesCollectionTableViewController.h"
#import "Series.h"

NSString *const akCellIdentifier = @"seriesCollectionTableCell";
NSString *const akTableCellNibName = @"SeriesCollectionTableCell";

@implementation SeriesCollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // we use a nib which contains the cell's view and this class as the files owner
    [self.tableView registerNib:[UINib nibWithNibName:akTableCellNibName bundle:nil] forCellReuseIdentifier:akCellIdentifier];
    
    
    self.series = @[[Series seriesWithName:@"Family Guy"
                                       summary:@"Family guy is the best comedy series on public tv ever made!"
                                     avgRating:@4.5],
                        [Series seriesWithName:@"Breaking Bad"
                                       summary:@"Breaking bad is the best action thriller..."
                                     avgRating:@5]];
}

- (void)configureCell:(UITableViewCell *)cell forSeries:(Series *)series {
    
    UILabel *title = [self.view viewWithTag:0];
    UILabel *summary = [self.view viewWithTag:1];

    
    title.text = series.name;
    summary.text = series.summary;
    
/*    cell.textLabel.text = series.name;
    cell.detailTextLabel.text = series.summary;*/
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.series.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:akCellIdentifier];
    
    Series *series = self.series[indexPath.row];
    [self configureCell:cell forSeries:series];
    
    return cell;
}

@end