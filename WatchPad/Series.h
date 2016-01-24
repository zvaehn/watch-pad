//
//  Series.h
//  WatchPad
//
//  Created by Sven Schiffer on 12.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Series : NSObject <NSCoding>

@property (nonatomic, copy) NSNumber *series_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSNumber *avgRating;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *imageurl;
@property (nonatomic, copy) NSString *network;
@property (nonatomic, copy) NSNumber *updated;
@property (nonatomic, copy) NSString *cover_url;
@property (nonatomic, copy) NSMutableArray *seasons;
//@property (strong, nonatomic) UIImage *image;

+ (Series *)seriesWithId:(NSNumber *)series_id title:(NSString *)title;

@end