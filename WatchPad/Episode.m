//
//  Episode.m
//  WatchPad
//
//  Created by Sven Schiffer on 28.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "Episode.h"

@implementation Episode

+ (Episode *)episodeWithId:(id)episode_id title:(id)title {
    Episode *newEpisode = [[Episode alloc] init];
    newEpisode.episode_id = episode_id;
    newEpisode.title = title;
    return newEpisode;
}

#pragma mark - Encoding/Decoding

NSString *const EpisodeIdKey = @"EpisodeIdKey";
NSString *const EpisodeSeasonKey = @"EpisodeSeasonKey";
NSString *const EpisodeNumberKey = @"EpisodeNumberKey";
NSString *const EpisodeTitleKey = @"EpisodeTitleKey";
NSString *const EpisodeSummaryKey = @"EpisodeSummaryKey";
NSString *const EpisodeAirdateKey = @"EpisodeAirdateKey";

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _episode_id = [aDecoder decodeObjectForKey:EpisodeIdKey];
        _season = [aDecoder decodeObjectForKey:EpisodeSeasonKey];
        _number = [aDecoder decodeObjectForKey:EpisodeNumberKey];
        _title = [aDecoder decodeObjectForKey:EpisodeTitleKey];
        _summary = [aDecoder decodeObjectForKey:EpisodeSummaryKey];
        _airdate = [aDecoder decodeObjectForKey:EpisodeAirdateKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.episode_id forKey:EpisodeIdKey];
    [aCoder encodeObject:self.season forKey:EpisodeSeasonKey];
    [aCoder encodeObject:self.number forKey:EpisodeNumberKey];
    [aCoder encodeObject:self.title forKey:EpisodeTitleKey];
    [aCoder encodeObject:self.summary forKey:EpisodeSummaryKey];
    [aCoder encodeObject:self.airdate forKey:EpisodeAirdateKey];
}


@end
