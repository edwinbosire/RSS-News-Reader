//
//  HNDataDownloader.m
//  Habari News
//
//  Created by Denis on 13/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HNDataDownloader.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#import "SMXMLDocument.h"
#import "NewsItem.h"
#import "SynthesizeSingleton.h"


@implementation HNDataDownloader

SYNTHESIZE_SINGLETON_FOR_CLASS(HNDataDownloader);

//- (id)init {
//    self = [super init];
//    if (self) {
//        //init code here
//    }
//    return self;
//}


- (void)downloadNewsWithUrl:(NSURL*)url{
    
    request = [ASIHTTPRequest requestWithURL:url];
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    [request setSecondsToCache:60*60*24*30]; // Cache for 30 days
    [request setDelegate:self]; // A delegate must be specified
    
    [request setCompletionBlock:^{
        // Use when fetching text data
        NSString * responseString = [request responseString];
        
        if (responseString != NULL){
            // NSMutableArray *allNames = [results objectForKey:@"country"];
            [self parseXMLstring:responseString];
        }else {
            NSLog(@"results is empty");
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Error" message:@"Error Downloading News" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
        
    }];
    
    
    
    [request setFailedBlock:^{
        
        UIAlertView *alert1 = [[UIAlertView alloc]
                              initWithTitle:@"Error" message:@"Error No Internet" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert1 show];
        [alert1 release];
        
    }];
    
    [request startAsynchronous];

}

- (void)parseXMLstring:(NSString *)xml{
    
    
    NSData *data = [xml dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
	SMXMLDocument *document = [SMXMLDocument documentWithData:data error:NULL];
    
	//NSLog(@"Document:\n %@", document);
	
	// Pull out the root node
//	SMXMLElement *news = [document.root children];
	
    news = [[NSMutableArray alloc] init];
    
    
	// Look through root for news items
	for (SMXMLElement *item in [document.root children]) {
		NewsItem *newsItem = [[NewsItem alloc] init];
		// demonstrate common cases of extracting XML data
		newsItem.title = [item valueWithPath:@"title"];
		newsItem.link = [item valueWithPath:@"link"];
        newsItem.description = [item valueWithPath:@"description"];
        
        [news addObject:newsItem];
        [newsItem release];
        
//		NSLog(@"entries found \n TITLE: %@ \n LINK: %@ \n DESCSRIPTION: %@ \n",newsItem.title, newsItem.link, newsItem.description);
        
	}
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"XMLParsingFinished" object:nil];

}

- (NSArray*)retrieveNewsItems{
 
    return news;
}
@end
