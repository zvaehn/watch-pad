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
    [[NSUserDefaults standardUserDefaults] synchronize]; // may be a lag of performance
    
    NSLog(@"series commit.");
}

- (NSMutableArray *) loadData {
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

- (void) updateData:(NSMutableArray *)seriesArray {
    self.seriesArray = seriesArray;
    [self commit];
}

- (NSMutableDictionary *) seasonsForSeries:(NSNumber *)series_id {
    return [[self.seriesArray objectAtIndex: [series_id integerValue]] seasons];
}

- (NSMutableArray *) episodesForSeries:(NSNumber *)series_id inSeason:(NSNumber *)season {
    NSMutableDictionary *seasons = [self seasonsForSeries:series_id];
    
    //NSArray *sortedKeys = [[seasons allKeys] sortedArrayUsingSelector: @selector(compare:)];
    //    NSNumber *season_number = [sortedKeys objectAtIndex: season];
    
    return [seasons objectForKey:season];
}

@end
