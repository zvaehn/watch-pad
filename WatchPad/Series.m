//
//  Series.m
//  WatchPad
//
//  Created by Sven Schiffer on 12.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "Series.h"

@implementation Series

+ (Series *)seriesWithId:(id)series_id title:(id)title {
    Series *newSeries = [[Series alloc] init];
    newSeries.series_id = series_id;
    newSeries.title = title;
    return newSeries;
}

- (void) addSeasonWithEpisodes:(NSNumber *)season_id episodes:(NSMutableArray *)episodes {
    [self.seasons setObject:episodes forKey:season_id];
}

- (NSMutableArray *) episodesInSeason:(NSNumber *)season_id {
    return [self.seasons objectForKey:season_id];
}

- (int) seasonsCount {
    return (int) [[self.seasons allKeys] count];
}

- (int) episodesCount {
    NSArray *season_keys = [self.seasons allKeys];
    NSMutableArray *season_episodes;
    int watched = 0;
    
    for (int i = 0; i < season_keys.count; i++) {
        season_episodes = [self.seasons objectForKey:season_keys[i]];
        watched += season_episodes.count;
    }
    
    return watched;

}

- (int) episodesWatched {
    NSArray *season_keys = [self.seasons allKeys];
    NSMutableArray *season_episodes;
    int watched = 0;
    
    for (int i = 0; i < season_keys.count; i++) {
        season_episodes = [self.seasons objectForKey:season_keys[i]];
        
        for (int j = 0; j < season_episodes.count; j++) {
            if([season_episodes[j] watched]) {
                watched++;
            }
        }
    }

    return watched;
}


#pragma mark - Encoding/Decoding

NSString *const SeriesIdKey = @"SeriesIdKey";
NSString *const SeriesTitleKey = @"SeriesTitleKey";
NSString *const SeriesRatingKey = @"SeriesRatingKey";
NSString *const SeriesSummaryKey = @"SeriesSummaryKey";
NSString *const SeriesNetworkKey = @"SeriesNetworkKey";
NSString *const SeriesUpdatedKey = @"SeriesUpdatedKey";
NSString *const SeriesCoverUrlKey = @"SeriesCoverUrlKey";
NSString *const SeriesCoverKey = @"SeriesCoverKey";
NSString *const SeriesSeasonsKey = @"SeriesSeasonsKey";

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _series_id = [aDecoder decodeObjectForKey:SeriesIdKey];
        _title = [aDecoder decodeObjectForKey:SeriesTitleKey];
        _avgRating = [aDecoder decodeObjectForKey:SeriesRatingKey];
        _summary = [aDecoder decodeObjectForKey:SeriesSummaryKey];
        _network = [aDecoder decodeObjectForKey:SeriesNetworkKey];
        _updated = [aDecoder decodeObjectForKey:SeriesUpdatedKey];
        _cover_url = [aDecoder decodeObjectForKey:SeriesCoverUrlKey];
        _cover = [aDecoder decodeObjectForKey:SeriesCoverKey];
        _seasons = [aDecoder decodeObjectForKey:SeriesSeasonsKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.series_id forKey:SeriesIdKey];
    [aCoder encodeObject:self.title forKey:SeriesTitleKey];
    [aCoder encodeObject:self.avgRating forKey:SeriesRatingKey];
    [aCoder encodeObject:self.summary forKey:SeriesSummaryKey];
    [aCoder encodeObject:self.network forKey:SeriesNetworkKey];
    [aCoder encodeObject:self.updated forKey:SeriesUpdatedKey];
    [aCoder encodeObject:self.cover_url forKey:SeriesCoverUrlKey];
    [aCoder encodeObject:self.cover forKey:SeriesCoverKey];
    [aCoder encodeObject:self.seasons forKey:SeriesSeasonsKey];
}


@end

