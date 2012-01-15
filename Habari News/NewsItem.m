//
//  NewsItem.m
//  Habari News
//
//  Created by Denis on 13/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsItem.h"

@implementation NewsItem

@synthesize title;
@synthesize link;
@synthesize description;


- (void) dealloc{
    
    [title release];
    [link release];
    [description release];
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end
