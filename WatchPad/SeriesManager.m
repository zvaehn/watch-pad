//
//  SeriesManager.m
//  WatchPad
//
//  Created by Sven Schiffer on 27.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "SeriesManager.h"

@implementation SeriesManager

NSString *const SeriesPreferencesKey = @"SERIES";

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        NSData *seriesData = [[NSUserDefaults standardUserDefaults] objectForKey:SeriesPreferencesKey];
        NSArray *series = [NSKeyedUnarchiver unarchiveObjectWithData:seriesData];
        
        if(![series count]) {
            self.seriesArray = [[NSMutableArray alloc] init];
        }
        else {
            self.seriesArray = [NSMutableArray arrayWithArray:series];
        }
    }
    
    return self;
}

- (void)addSeries:(Series *)aSeries {
    [self.seriesArray addObject:aSeries];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.seriesArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:SeriesPreferencesKey];
    
    NSLog(@"series collection count: %lu", [self.seriesArray count]);
}

- (NSMutableArray *) reloadData {
    NSData *seriesData = [[NSUserDefaults standardUserDefaults] objectForKey:SeriesPreferencesKey];
    NSArray *series = [NSKeyedUnarchiver unarchiveObjectWithData:seriesData];
    
    if(![series count]) {
        self.seriesArray = [[NSMutableArray alloc] init];
    }
    else {
        self.seriesArray = [NSMutableArray arrayWithArray:series];
    }
    
    return self.seriesArray;
}

@end
