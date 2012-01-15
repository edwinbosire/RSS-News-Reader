//
//  HNDataDownloader.h
//  Habari News
//
//  Created by Denis on 13/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIHTTPRequest;

@interface HNDataDownloader : NSObject {
   __block ASIHTTPRequest *request;
   __block NSMutableArray *news;
}
+ (HNDataDownloader *)sharedHNDataDownloader;

- (void)downloadNewsWithUrl:(NSURL*)url;
- (void)parseXMLstring:(NSString *)xml;
- (NSArray*)retrieveNewsItems;

@end
