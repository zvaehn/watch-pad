//
//  SeriesBaseTableViewController.n
//  WatchPad
//
//  Created by Sven Schiffer on 19.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "SeriesBaseTableViewController.h"
#import "Series.h"

NSString *const kCellIdentifier = @"seriesResultsTableCell";
NSString *const kTableCellNibName = @"SeriesResultsTableCell";

@implementation SeriesBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // we use a nib which contains the cell's view and this class as the files owner
    [self.tableView registerNib:[UINib nibWithNibName:kTableCellNibName bundle:nil] forCellReuseIdentifier:kCellIdentifier];
}

- (void)configureCell:(UITableViewCell *)cell forSeries:(Series *)series {
    cell.textLabel.text = series.name;
    cell.detailTextLabel.text = series.summary;
}

@end