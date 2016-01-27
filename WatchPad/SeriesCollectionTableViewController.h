//
//  SeriesCollectionTableViewController.h
//  WatchPad
//
//  Created by Sven Schiffer on 19.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

@import UIKit;
#import "SeriesBaseTableViewController.h"
#import "SeriesCollectionTableViewCell.h"
#import "SeriesManager.h"

@class Series;

extern NSString *const akCellIdentifier;

@interface SeriesCollectionTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *series;
@property (nonatomic, strong) SeriesManager *seriesManager;

- (void)configureCell:(SeriesCollectionTableViewCell *)cell forSeries:(Series *)series;

@end
