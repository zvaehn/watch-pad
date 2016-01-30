//
//  SeasonTableViewController.m
//  WatchPad
//
//  Created by Sven Schiffer on 13.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "SeasonTableViewController.h"
#import "EpisodesTableViewController.h"
#import "Episode.h"

@implementation SeasonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.seasons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sortedKeys = [[self.seasons allKeys] sortedArrayUsingSelector: @selector(compare:)];
    NSString *season_name = [NSString stringWithFormat:@"Season %@", sortedKeys[indexPath.row]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SeasonsTableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = season_name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sortedKeys = [[self.seasons allKeys] sortedArrayUsingSelector: @selector(compare:)];
    NSNumber *season_number = [sortedKeys objectAtIndex:indexPath.row];
    NSString *season_name = [NSString stringWithFormat:@"Season %@", season_number];
    
    EpisodesTableViewController *episodesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EpisodesTableViewController"];
    episodesViewController.title = season_name;
    episodesViewController.episodes = [self.seasons objectForKey:season_number] ; // hand off the current season's episodes to the episodes controller
    
    [self.navigationController pushViewController:episodesViewController animated:YES];
    
    // note: should not be necessary but current iOS 8.0 bug (seed 4) requires it
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}




@end
