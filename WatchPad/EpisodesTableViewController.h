//
//  EpisodesTableViewController
//  WatchPad
//
//  Created by Sven Schiffer on 12.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeriesManager.h"

@interface EpisodesTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *episodes;
@property (nonatomic, strong) SeriesManager *seriesManager;

@end

