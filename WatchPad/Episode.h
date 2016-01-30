//
//  Episode.h
//  WatchPad
//
//  Created by Sven Schiffer on 28.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Episode : NSObject <NSCoding> {
    NSNumber *episode_id;
    NSNumber *season;
    NSNumber *number;
    NSString *title;
    NSString *summary;
    NSString *airdate;
    BOOL watched;
    NSDate *watched_at;
}

@property (nonatomic, copy) NSNumber *episode_id;
@property (nonatomic, copy) NSNumber *season;
@property (nonatomic, copy) NSNumber *number;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *airdate;
@property (nonatomic, readwrite) BOOL watched;
@property (nonatomic, copy) NSDate *watched_at;

+ (Episode *)episodeWithId:(NSNumber *)episode_id title:(NSString *)title;

@end
