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
    
    self.clearsSelectionOnViewWillAppear = YES;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected row at index: %@", indexPath);
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
    
    return cell;
}

@end
