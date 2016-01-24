//
//  SeriesCollectionTableViewController.h
//  WatchPad
//
//  Created by Sven Schiffer on 19.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

@import UIKit;
#import "SeriesBaseTableViewController.h"

@class Series;

extern NSString *const akCellIdentifier;

@interface SeriesCollectionTableViewController : SeriesBaseTableViewController

@property (nonatomic, strong) NSArray *series;

- (void)configureCell:(UITableViewCell *)cell forSeries:(Series *)series;

@end
