//
//  EpisodesTableViewController
//  WatchPad
//
//  Created by Sven Schiffer on 12.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "EpisodesTableViewController.h"
#import "Episode.h"

@import Foundation;

@interface EpisodesTableViewController ()

@end

@implementation EpisodesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.seriesManager = [[SeriesManager alloc] init];
    
    UIBarButtonItem *mark_all_button = [[UIBarButtonItem alloc] init];
    mark_all_button.title = @"Watched";
    self.navigationItem.rightBarButtonItem = mark_all_button;
    
    [mark_all_button setTarget:self];
    [mark_all_button setAction:@selector(markAllasWatched)];
    //self.clearsSelectionOnViewWillAppear = YES;
}

- (void)markAllasWatched {
    for (int i = 0; i < [self.episodes count]; i++) {
        [[self.episodes objectAtIndex:i] setWatched:YES];
    }
    
    [self.seriesManager commit];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Episode *episode = [self.episodes objectAtIndex: indexPath.row];
    episode.watched = !episode.watched;
    
    [self.seriesManager commit];

    if(episode.watched) {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }
    
    // note: should not be necessary but current iOS 8.0 bug (seed 4) requires it
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.episodes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Episode *episode = [self.episodes objectAtIndex: indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EpisodesTableViewCell" forIndexPath:indexPath]; 
    cell.textLabel.text = [NSString stringWithFormat: @"Episode %@: %@", episode.number, episode.title];
    
    if(episode.watched) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

@end
