//
//  Series.h
//  WatchPad
//
//  Created by Sven Schiffer on 12.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Episode.h"

@interface Series : NSObject <NSCoding> {
    NSNumber *series_id;
    NSString *title;
    NSNumber *avgRating;
    NSString *summary;
    NSString *imageurl;
    NSString *network;
    NSNumber *updated;
    NSString *cover_url;
    UIImage *cover;
    NSMutableDictionary *seasons;
}

@property (nonatomic, copy) NSNumber *series_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSNumber *avgRating;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *imageurl;
@property (nonatomic, copy) NSString *network;
@property (nonatomic, copy) NSNumber *updated;
@property (nonatomic, copy) UIImage *cover;
@property (nonatomic, copy) NSString *cover_url;
@property (nonatomic, readwrite) NSMutableDictionary *seasons;

+ (Series *)seriesWithId:(NSNumber *)series_id title:(NSString *)title;
- (void)addSeasonWithEpisodes:(NSNumber *)season_id episodes:(NSMutableArray *)episodes;
- (int)seasonsCount;
- (NSMutableArray *)episodesInSeason:(NSNumber *)season_id;

//- (Episode *)seriesWithId:(NSNumber *)series_id title:(NSString *)title;


@end