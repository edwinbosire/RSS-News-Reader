//
//  webViewController.m
//  Habari News
//
//  Created by Denis on 14/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "webViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"

@implementation webViewController
@synthesize loadHTML;
@synthesize url;

- (void)dealloc{
    
    [loadHTML release]; loadHTML = nil;
    
    [url release]; url = nil;
    
    [super dealloc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 410)];
    webView.delegate = self;
   // webView.scalesPageToFit=YES;
    
    [self.view addSubview:webView];
    [webView release];
    
}

- (void)setLoadHTML:(NSString *)_loadHTML{
    
    if (loadHTML == _loadHTML) {
        return;
    }
    
    [loadHTML release];
    loadHTML = [_loadHTML retain];
    
    
}
     
- (void)setUrl:(NSURL *)newUrl{
    if (url == newUrl) {
        return;
    }
    __block ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:newUrl];
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    [request setSecondsToCache:60*60*24*30]; // Cache for 30 days

    [request setCompletionBlock:^{
        NSString * responseString = [request responseString];
        
        if (responseString != NULL){
            [self parseHTMLString:responseString];
             
             }else {
                 NSLog(@"results is empty");
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Error" message:@"Error Downloading News" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }

    }];
    
    [request setFailedBlock:^{
        NSLog(@"results is empty");
        UIAlertView *alert1 = [[UIAlertView alloc]
                              initWithTitle:@"Error" message:@"Error Reading News" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert1 show];
        [alert1 release];
    }];
    
    [request startAsynchronous];
    
}

- (void)parseHTMLString:(NSString *)html{
    
    NSString *HEADER =[NSString stringWithFormat:@"<div id=\"articlebody\">"];
    NSString *CONTENT=[[NSString alloc] init];
    NSString *END = [NSString stringWithFormat:@"<div id=\"article_pages\">" ];
    NSScanner *theScanner =[NSScanner scannerWithString:html];
    [theScanner setScanLocation:0];
    while (!(theScanner.isAtEnd)) {
        
        [theScanner scanUpToString:HEADER intoString:nil];
        [theScanner scanString:HEADER intoString:nil];
        [theScanner scanUpToString:END intoString:&CONTENT];
    }
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"style" ofType:@"css"];
    NSString *css = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"styling applied %@", css);
    NSString *cont = [NSString stringWithFormat:@"%@%@",css,CONTENT]; 
   
    [self loadHTMLWithContent:cont];
}
- (void)loadHTMLWithContent:(NSString *)content{
    
    NSLog(@"tidied up html %@\n\n\n\n", content);

    
    [webView loadHTMLString:content baseURL:[NSURL URLWithString:@"http://www.nation.co.ke/"]];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    NSLog(@"uiwebview error %@", error);
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
