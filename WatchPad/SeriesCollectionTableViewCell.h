//
//  SeriesCollectionTableViewCell.h
//  WatchPad
//
//  Created by Sven Schiffer on 27.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeriesCollectionTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *title_label;
@property (strong, nonatomic) IBOutlet UILabel *summary_label;
@property (strong, nonatomic) IBOutlet UIImageView *cover_image;
@property (strong, nonatomic) IBOutlet UIProgressView *watch_progress;

@end
