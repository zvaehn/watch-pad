//
//  SeriesSearchDisplayController.m
//  WatchPad
//
//  Created by Sven Schiffer on 13.1.16.
//  Copyright © 2016 Sven Schiffer. All rights reserved.
//

#import "SeriesSearchDisplayController.h"

@interface UITableViewController ()

@property (strong, nonatomic) NSArray *data;

@end


@implementation SeriesSearchDisplayController

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    /*NSString *trimDot = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([trimDot isEqualToString:@"."]) {
        return YES;
    }
    
    if(connection){
        [connection cancel];
    }
    NSString *appendStr;
    if([text length] == 0)
    {
        NSRange rangemak = NSMakeRange(0, [searchbar.text length]-1);
        appendStr = [searchbar.text substringWithRange:rangemak];
    }
    else
    {
        appendStr = [NSString stringWithFormat:@"%@%@",searchbar.text,text];
        
    }
    [self performSelector:@selector(callSearchWebService:) withObject:appendStr];
    
    [activityindicator startAnimating];
    return YES;*/
    
    NSLog(text);
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self performSelector:@selector(callSearchWebService:) withObject:searchBar.text];
    searchBar.showsCancelButton=NO;
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self performSelector:@selector(callSearchWebService:) withObject:searchBar.text];
    [searchBar resignFirstResponder];
}

-(void)callSearchWebService:(NSString*)searchStr
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    NSString *str =@"";
    if ([searchStr length] != 0 ) str = searchStr;
    
    NSString *url = [NSString stringWithFormat:@"http://api.tvmaze.com/search/shows?q=family"];
    [request setURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    

    
    
}

@end
