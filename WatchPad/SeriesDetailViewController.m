//
//  SeriesDetailViewController.m
//  WatchPad
//
//  Created by Sven Schiffer on 24.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "SeriesDetailViewController.h"
#import "SeriesCollectionTableViewController.h"
#import "Series.h"
#import "Episode.h"
#import "SeriesManager.h"
#import "AFURLSessionManager.h"

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
    
    SeriesManager *seriesManager = [[SeriesManager alloc] init];
    NSArray *seriesCollection = [seriesManager loadData];
    
    // Check if Series already exists in collection
    for (Series *series in seriesCollection) {
        if(self.series.series_id == series.series_id) {
            add_button.enabled = NO;
        }
    }
    
    [add_button setTarget:self];
    [add_button setAction:@selector(addSeriesToCollection)];
    
    self.title = self.series.title;
    self.title_label.text = self.series.title;
    self.id_label.text = [NSString stringWithFormat:@"%@", self.series.series_id];
    self.network_label.text = self.series.network;
    self.rating_label.text = [NSString stringWithFormat:@"%.1f", [self.series.avgRating doubleValue]];
    self.updated_label.text = [formatter stringFromDate:updated];
    self.summary_label.text = self.series.summary;
    self.cover.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.series.cover_url]]];
    
    self.series.seasons = [[NSMutableDictionary alloc] init];
    self.series.cover = self.cover.image;
    
    // Collect Episode information
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *urlString = [NSString stringWithFormat: @"http://api.tvmaze.com/shows/%@/episodes", self.series.series_id];
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlString parameters:nil error:nil];
    
    NSURLSessionDataTask *episodesTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }
        else {
            NSDictionary *responseCode = responseObject;
            
            if([responseObject valueForKey:@"status"] == nil) {
                NSLog(@"an error occured: %@", [responseObject valueForKey:@"message"]);
            }
            else {
                NSArray *responseItems = responseObject;
                NSMutableDictionary *seasons = [[NSMutableDictionary alloc] init];
                
                for (NSDictionary *episode in responseItems) {
                    
                    NSNumber *episode_id = [episode objectForKey:@"id"];
                    NSNumber *season = [episode objectForKey:@"season"];
                    NSNumber *number = [episode objectForKey:@"number"];
                    NSString *title = [episode objectForKey:@"name"];
                    NSString *summary = [episode objectForKey:@"summary"];
                        
                    // Remove HTML Tags
                    NSRange range;
                    NSString *summary_string = summary;
                    while ((range = [summary_string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound) {
                        summary_string = [summary_string stringByReplacingCharactersInRange:range withString:@""];
                    }
                    
                    Episode *currentEpisode = [Episode episodeWithId:episode_id title:title];
                    currentEpisode.season = season;
                    currentEpisode.number = number;
                    currentEpisode.summary = summary_string;
                    
                    if ([seasons objectForKey:season] == nil) {
                        //NSLog(@"season %@ #1 time", season);
                        // Array to store all episodes for one season
                        NSMutableArray *episodesForSeason = [[NSMutableArray alloc] init];
                        [episodesForSeason addObject:currentEpisode];
                        
                        // Add the episodes array to the seasons dictionary episode_number = array_of_episodes
                        [seasons setObject:episodesForSeason forKey:season];
                    }
                    else {
                        //NSLog(@"season %@ already exists", season);
                        NSMutableArray *currentSeason = [seasons objectForKey:currentEpisode.season];
                        [currentSeason addObject:currentEpisode];
                    }
                }
                
                // Add seasons (and it's episodes to the current series)
                for(NSNumber *season_number in seasons) {
                    //unsigned long episode_count = [[seasons objectForKey:season_number] count];
                    //NSLog(@"season: %@ has %lu episodes", season_number, episode_count);
            
                    NSMutableArray *current_season = [seasons objectForKey:season_number];
                    [self.series addSeasonWithEpisodes:season_number episodes:current_season];
                }
            }
        }
    }];
    
    [episodesTask resume];
}

- (void) addSeriesToCollection {
    SeriesManager *seriesManager = [[SeriesManager alloc] init];
    [seriesManager addSeries:self.series];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.navigationController.tabBarController.selectedIndex = 1;
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
