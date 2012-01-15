//
//  webViewController.h
//  Habari News
//
//  Created by Denis on 14/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface webViewController : UIViewController <UIWebViewDelegate>
{
    UIWebView *webView;
    NSString *loadHTML;
    NSURL *url;
}
@property (nonatomic, retain) NSString *loadHTML;
@property (nonatomic, retain) NSURL *url;


- (void)parseHTMLString:(NSString*)html;
- (void)loadHTMLWithContent:(NSString*)content;
@end
