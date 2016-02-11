//
//  StatisticsTableViewController.m
//  WatchPad
//
//  Created by Sven Schiffer on 11.2.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "StatisticsTableViewController.h"

@implementation StatisticsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.seriesManager = [[SeriesManager alloc] init];
}

- (void) viewWillAppear:(BOOL)animated {
    self.series = [self.seriesManager loadData];
    
    [self calculate];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    // case order depends on the tablecells in the IB
    switch(cell.tag) {
        case 101: // series count
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", self.seriesCounter];
            break;
            
        case 102: // episode count
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", self.episodesCounter];
            break;
            
        case 103: // episode watched count
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", self.episodesWatchedCounter];
            break;
            
        case 201: // total runtime
            cell.detailTextLabel.text = [self minutesAsFormatString:self.totalRuntime];
            break;
        
        case 202: // watched time
            cell.detailTextLabel.text = [self minutesAsFormatString:self.totalWatchtime];
            break;
            
        case 203: // duration this month
            cell.detailTextLabel.text = @"-";
            break;
    }
    
    return cell;
}

- (void) calculate {
    int counter = 0;
    int watched = 0;
    int runtime = 0;
    int watchtime = 0;
    
    NSMutableArray *season_episodes;
    NSArray *season_keys;
    Series *cur_series;
    
    for (int i = 0; i < self.series.count; i++) {
        cur_series = self.series[i];
                      
        counter += (int) [cur_series episodesCount];
        watched += (int) [cur_series episodesWatched];
        
        // loop seasons and episodes
        season_keys = [cur_series.seasons allKeys];
        season_episodes = [cur_series.seasons objectForKey:season_keys[i]];

        for (int i = 0; i < season_keys.count; i++) {
            season_episodes = [cur_series.seasons objectForKey:season_keys[i]];
            
            for (int j = 0; j < season_episodes.count; j++) {
                if([season_episodes[j] watched]) {
                    watchtime += [[season_episodes[j] runtime] longValue];
                }
                
                runtime += [[season_episodes[j] runtime] longValue];
            }
        }
    }
    
    self.seriesCounter = [self.series count];
    self.episodesCounter = counter;
    self.episodesWatchedCounter = watched;
    self.totalRuntime = runtime;
    self.totalWatchtime = watchtime;
}

- (NSString *) minutesAsFormatString:(long) minutes {
    if(minutes < 1) {
        return @"0 min";
    }
    
    // Display minutes
    if(minutes < 60) {
        return [NSString stringWithFormat: @"%ld min", minutes];
    }
    // Display hours
    else if (minutes < 60*24) {
        return [NSString stringWithFormat: @"%ld h", minutes/60];
    }
    // Display days
    else if(minutes >= (60*24)) {
        return [NSString stringWithFormat: @"%ld days", minutes/60/24];
    }
    else {
        return [NSString stringWithFormat: @"%ld min", minutes];
    }
}



@end
