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

#pragma mark - Encoding/Decoding

NSString *const SeriesIdKey = @"SeriesIdKey";
NSString *const SeriesTitleKey = @"SeriesTitleKey";
NSString *const SeriesRatingKey = @"SeriesRatingKey";
NSString *const SeriesSummaryKey = @"SeriesSummaryKey";
NSString *const SeriesNetworkKey = @"SeriesNetworkKey";
NSString *const SeriesUpdatedKey = @"SeriesUpdatedKey";
NSString *const SeriesCoverUrlKey = @"SeriesCoverUrlKey";
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
    [aCoder encodeObject:self.seasons forKey:SeriesSeasonsKey];
}

@end

