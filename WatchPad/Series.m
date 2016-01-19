//
//  Series.m
//  WatchPad
//
//  Created by Sven Schiffer on 12.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "Series.h"

@implementation Series

- (instancetype)init
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
}

/*
 NSString *dataUrl = @"http://api.tvmaze.com/search/shows?q=family";
 NSURL *url = [NSURL URLWithString:dataUrl];
 
 NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
 NSString *res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
 NSLog(@"%@", res);
 }];
 
 [downloadTask resume];

 */

@end
