//
//  SeriesInterfaceConnection.h
//  WatchPad
//
//  Created by Sven Schiffer on 19.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeriesInterfaceConnection : NSURLSession

@property (nonatomic, copy) NSString *url;

- (NSString *) seriesByName:(NSString *)name;

@end
