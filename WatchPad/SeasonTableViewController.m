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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
