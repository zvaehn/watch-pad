//
//  SeriesInterfaceConnection.m
//  WatchPad
//
//  Created by Sven Schiffer on 19.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

@import Foundation;

#import "SeriesInterfaceConnection.h"
#import "AFURLSessionManager.h"


@implementation SeriesInterfaceConnection

NSURL *domain;

- (instancetype)init {
    self = [super init];
    
    if (self) {
        domain = [NSURL URLWithString: @"http://api.tvmaze.com"];
    }
    
    return self;
}

- (NSString*)seriesByName:(NSString *)name {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"/search/shows?q=%@", name] relativeToURL:domain];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    
    [dataTask resume];
    
    return @"...";
}

@end
