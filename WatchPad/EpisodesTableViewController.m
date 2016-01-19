//
//  EpisodesTableViewController
//  WatchPad
//
//  Created by Sven Schiffer on 12.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "EpisodesTableViewController.h"
@import Foundation;

@interface EpisodesTableViewController ()

@property (strong, nonatomic) NSMutableArray *episodes;
@property (strong, nonatomic) NSMutableData* receivedData;

@end

@implementation EpisodesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = YES;
    
    self.episodes = @[@"Episode 1", @"Episode 2", @"Episode 3", @"Episode 4", @"Episode 5", @"Episode 6", @"Episode 7"];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse object.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [_receivedData setLength:0];
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
    NSString *name = self.episodes[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EpisodesTableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = name;
    
    return cell;
}

@end
