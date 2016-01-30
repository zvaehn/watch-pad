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

- (instancetype)init {
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
    [self.seriesArray insertObject:aSeries atIndex:0];
    [self commit];
}

// Persists data
- (void)commit {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.seriesArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:SeriesPreferencesKey];
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
