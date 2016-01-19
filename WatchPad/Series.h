//
//  Series.h
//  WatchPad
//
//  Created by Sven Schiffer on 12.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Series : NSMutableData

@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) NSArray *episodes;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *avgRating;
@property (strong, nonatomic) NSString *summary;
//@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *imageurl;

@end
