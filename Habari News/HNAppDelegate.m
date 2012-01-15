//
//  HNAppDelegate.m
//  Habari News
//
//  Created by Denis on 13/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HNAppDelegate.h"
#import "HNLatestNews.h"
#import "HNVideos.h"
#import "HNSportsNews.h"
#import "HNInfo.h"


@implementation HNAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    UIViewController *latestNews= [[[HNLatestNews alloc] initWithNibName:@"HNLatestNews" bundle:nil] autorelease];
    UINavigationController *latestNav = [[UINavigationController alloc] initWithRootViewController:latestNews];
    
    UIViewController *businessNews = [[[HNVideos alloc] initWithNibName:@"HNBusinessNews" bundle:nil] autorelease];
    UINavigationController *businessNav = [[UINavigationController alloc] initWithRootViewController:businessNews];
    
    UIViewController *sportsNews = [[[HNSportsNews alloc] initWithNibName:@"HNSportsNews" bundle:nil] autorelease];
    UINavigationController *sportsNav = [[UINavigationController alloc] initWithRootViewController:sportsNews];
    
    UIViewController *info = [[[HNInfo alloc] initWithNibName:@"HNInfo" bundle:nil] autorelease];
    UINavigationController *infoNav = [[UINavigationController alloc] initWithRootViewController:info];
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:latestNav, businessNav, sportsNav, infoNav, nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
