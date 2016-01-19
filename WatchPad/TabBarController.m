//
//  TabBarController.m
//  WatchPad
//
//  Created by Sven Schiffer on 12.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@property(nonatomic, assign) UITabBarItem *selectedItem;
@property(nonatomic, copy) NSArray <UITabBarItem *> *items;

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedIndex = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
