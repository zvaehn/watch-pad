//
//  StatisticsTableViewController.h
//  WatchPad
//
//  Created by Sven Schiffer on 11.2.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeriesManager.h"
@class Series;

@interface StatisticsTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *series;
@property (nonatomic, strong) SeriesManager *seriesManager;

@property long seriesCounter;
@property long episodesCounter;
@property long episodesWatchedCounter;

@property long totalRuntime;
@property long totalWatchtime;
@property long totalWatchtime30days;

- (NSString *) minutesAsFormatString:(long) minutes;

@end
