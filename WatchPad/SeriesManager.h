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
- (NSMutableArray *) reloadData;
- (void) commit;

/*- (Series *) seriesWithSeriesId:(NSNumber *)series_id;
- (bool) removeSeriesWithSeriesId:(NSNumber *)series_id;
- (void) deleteAllSeries;*/

@end
