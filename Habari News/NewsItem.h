//
//  NewsItem.h
//  Habari News
//
//  Created by Denis on 13/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject{
    
    NSString *title;
    NSString *link;
    NSString *description;
    
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *description;


- (id)init;
@end
