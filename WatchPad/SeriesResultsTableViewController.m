//
//  SeriesResultsTableViewController.m
//  WatchPad
//
//  Created by Sven Schiffer on 19.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "SeriesResultsTableViewController.h"
#import "Series.h"

NSString *const bkCellIdentifier = @"seriesResultsTableCell";
NSString *const bkTableCellNibName = @"SeriesResultsTableCell";

@implementation SeriesResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // we use a nib which contains the cell's view and this class as the files owner
    [self.tableView registerNib:[UINib nibWithNibName:bkTableCellNibName bundle:nil] forCellReuseIdentifier:bkCellIdentifier];
}

- (void)configureCell:(UITableViewCell *)cell forSeries:(Series *)series {
    cell.textLabel.text = series.title;
    cell.detailTextLabel.text = series.summary;
}

@end