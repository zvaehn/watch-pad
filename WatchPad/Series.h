//
//  Series.h
//  WatchPad
//
//  Created by Sven Schiffer on 12.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Series : NSObject <NSCoding>

@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSArray *episodes;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *avgRating;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *imageurl;
//@property (strong, nonatomic) UIImage *image;

+ (Series *)seriesWithName:(NSString *)name summary:(NSString *)summary avgRating:(NSNumber *)avgRating;

@end