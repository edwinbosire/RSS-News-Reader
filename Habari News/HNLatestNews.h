//
//  HNFirstViewController.h
//  Habari News
//
//  Created by Denis on 13/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNDataDownloader.h"

@class NewsItem;
@class webViewController;

@interface HNLatestNews : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    UITableView *tableView;
    NewsItem *newsItem;
    NSArray *items;
    webViewController *webView;
}

- (void)refreshData:(id)sender;
- (void)retrieveData;
@end
