//
//  SeriesTableViewController
//  WatchPad
//
//  Created by Sven Schiffer on 12.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Series.h"

@interface SeriesTableViewController : UIViewController <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating> {

    NSMutableArray *contentList;
    NSMutableArray *seriesSearchResultsList;
    BOOL isSearching;
}

@property (strong, nonatomic) IBOutlet UITableView *seriesSearchResultsList;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchBarDisplayController;


@end

