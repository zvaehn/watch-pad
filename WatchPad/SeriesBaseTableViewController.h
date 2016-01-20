//
//  SeriesBaseTableViewController.h
//  WatchPad
//
//  Created by Sven Schiffer on 19.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

@import UIKit;

@class Series;

extern NSString *const kCellIdentifier;

@interface SeriesBaseTableViewController : UITableViewController

- (void)configureCell:(UITableViewCell *)cell forSeries:(Series *)series;

@end
