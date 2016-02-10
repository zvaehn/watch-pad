//
//  SeasonTableViewController.h
//  WatchPad
//
//  Created by Sven Schiffer on 13.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeriesManager.h"

@interface SeasonTableViewController : UITableViewController

@property (nonatomic, strong) SeriesManager *seriesManager;
@property (strong, nonatomic) NSMutableDictionary *seasons;

@end
