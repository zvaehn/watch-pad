//
//  SeriesBaseTableViewController.n
//  WatchPad
//
//  Created by Sven Schiffer on 19.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "SeriesBaseTableViewController.h"
#import "Series.h"

NSString *const kCellIdentifier = @"seriesCollectionTableCell";
NSString *const kTableCellNibName = @"SeriesCollectionTableCell";

@implementation SeriesBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // we use a nib which contains the cell's view and this class as the files owner
    [self.tableView registerNib:[UINib nibWithNibName:kTableCellNibName bundle:nil] forCellReuseIdentifier:kCellIdentifier];
}

- (void)configureCell:(UITableViewCell *)cell forSeries:(Series *)series {
    cell.textLabel.text = series.title;
    cell.detailTextLabel.text = series.summary;

    
/*  UILabel *title = [self.view viewWithTag:0];
    UILabel *summary = [self.view viewWithTag:1];
    
    title.text = series.name;
    summary.text = series.summary;*/
}

@end