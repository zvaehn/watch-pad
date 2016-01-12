//
//  SeriesTableViewController
//  WatchPad
//
//  Created by Sven Schiffer on 12.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "SeriesTableViewController.h"

@interface SeriesTableViewController ()

@property (strong, nonatomic) NSArray *data;

@end

@implementation SeriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = @[@"Family Guy", @"Sons of Anarchy", @"Breaking Bad", @"How i met your mother"];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SeriesTableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = name;
    
    return cell;
}

@end
