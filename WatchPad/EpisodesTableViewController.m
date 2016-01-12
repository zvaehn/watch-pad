//
//  EpisodesTableViewController
//  WatchPad
//
//  Created by Sven Schiffer on 12.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "EpisodesTableViewController.h"

@interface EpisodesTableViewController ()

@property (strong, nonatomic) NSArray *data;

@end

@implementation EpisodesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = @[@"Episode 1", @"Episode 2", @"Episode 3", @"Episode 4"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name = self.data[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EpisodesTableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = name;
    
    return cell;
}

@end
