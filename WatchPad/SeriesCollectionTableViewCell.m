//
//  SeriesCollectionTableViewCell.m
//  WatchPad
//
//  Created by Sven Schiffer on 27.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "SeriesCollectionTableViewCell.h"

@implementation SeriesCollectionTableViewCell

@synthesize title_label = _title_label;
@synthesize summary_label = _summary_label;
@synthesize cover_image = _cover_image;
@synthesize watch_progress = _watch_progress;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
