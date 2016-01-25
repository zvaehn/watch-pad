//
//  SeriesDetailViewController.m
//  WatchPad
//
//  Created by Sven Schiffer on 24.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "SeriesDetailViewController.h"
#import "Series.h"

@interface SeriesDetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *title_label;
@property (strong, nonatomic) IBOutlet UILabel *id_label;
@property (strong, nonatomic) IBOutlet UILabel *network_label;
@property (strong, nonatomic) IBOutlet UILabel *rating_label;
@property (strong, nonatomic) IBOutlet UILabel *updated_label;
@property (strong, nonatomic) IBOutlet UILabel *summary_label;
@property (strong, nonatomic) IBOutlet UIImageView *cover;

@end

#pragma mark -

@implementation SeriesDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    NSDate *updated = [NSDate dateWithTimeIntervalSince1970: [self.series.updated doubleValue]];
    
    UIBarButtonItem *add_button = [[UIBarButtonItem alloc] init];
    add_button.title = @"Add";
    add_button.style = UIBarButtonItemStyleDone;
    self.navigationItem.rightBarButtonItem = add_button;
    
    self.title = self.series.title;

    self.title_label.text = self.series.title;
    self.id_label.text = [NSString stringWithFormat:@"%@", self.series.series_id];
    self.network_label.text = self.series.network;
    self.rating_label.text = [NSString stringWithFormat:@"%.1f", [self.series.avgRating doubleValue]];
    self.updated_label.text = [formatter stringFromDate:updated];
    self.summary_label.text = self.series.summary;
    self.cover.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.series.cover_url]]];
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem {
    self.rightBarButtonItem = rightBarButtonItem;
}

#pragma mark - UIStateRestoration

NSString *const ViewControllerSeriesKey = @"ViewControllerSeriesKey";

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    // encode the series
    [coder encodeObject:self.series forKey:ViewControllerSeriesKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    // restore the product
    self.series = [coder decodeObjectForKey:ViewControllerSeriesKey];
}

@end
