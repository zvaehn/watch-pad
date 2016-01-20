//
//  Series.m
//  WatchPad
//
//  Created by Sven Schiffer on 12.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "Series.h"

@implementation Series

+ (Series *)seriesWithName:(id)name summary:(id)summary avgRating:(id)avgRating {
    Series *newSeries = [[Series alloc] init];
    newSeries.name = name;
    newSeries.summary = summary;
    newSeries.avgRating = avgRating;
    
    return newSeries;
}



#pragma mark - Encoding/Decoding

NSString *const NameKey = @"NameKey";
NSString *const SummaryKey = @"SummaryKey";
NSString *const RatingKey = @"RatingKey";


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:NameKey];
        _summary = [aDecoder decodeObjectForKey:SummaryKey];
        _avgRating = [aDecoder decodeObjectForKey:RatingKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:NameKey];
    [aCoder encodeObject:self.summary forKey:SummaryKey];
    [aCoder encodeObject:self.avgRating forKey:SummaryKey];
}

@end

/*- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"Family Guy";
        self.episodes = @[];
        self.avgRating = 0;
        self.summary = @"The show follows PETER GRIFFIN the endearingly ignorant dad, and his hilariously offbeat family of...";
        self.imageurl = @"http://tvmazecdn.com/uploads/images/medium_portrait/0/641.jpg";
    }
    return self;
}*/

/*
 NSString *dataUrl = @"http://api.tvmaze.com/search/shows?q=family";
 NSURL *url = [NSURL URLWithString:dataUrl];
 
 NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
 NSString *res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
 NSLog(@"%@", res);
 }];
 
 [downloadTask resume];

 */

