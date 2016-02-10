//
//  SeriesManager.h
//  WatchPad
//
//  Created by Sven Schiffer on 27.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Series.h"

@interface SeriesManager : NSObject

@property (retain) NSMutableArray *seriesArray;

- (void) addSeries:(Series *)series;
- (void) commit;
- (void) updateData:(NSMutableArray *)seriesArray;
- (NSMutableArray *) loadData;

- (NSMutableDictionary *) seasonsForSeries:(NSNumber *)series_id;
- (NSMutableArray *) episodesForSeries:(NSNumber *)series_id inSeason:(NSNumber *)season;


/*- (Series *) seriesWithSeriesId:(NSNumber *)series_id;
- (bool) removeSeriesWithSeriesId:(NSNumber *)series_id;
- (void) deleteAllSeries;*/

@end
