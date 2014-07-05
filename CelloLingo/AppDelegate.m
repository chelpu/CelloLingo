//
//  AppDelegate.m
//  CelloLingo
//
//  Created by Chelsea Pugh on 3/4/14.
//  Copyright (c) 2014 Chelsea Pugh. All rights reserved.
//
#import "OpeningViewController.h"
#import "AppDelegate.h"
#import "SCUI.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [SCSoundCloud setClientID:@"c76d3fe9bb6cfee88bb0d1598219eee4"
                       secret:@"66360dbcf98d672fb4af2fbb5a0351c8"
                  redirectURL:[NSURL URLWithString:@"https://api.soundcloud.com/oauth2/token"]];
    [Parse setApplicationId:@"bhDyk8YsZefvMzRFA8l1JmxW9H1ylWG5mp0QqBoa"
                  clientKey:@"kt2DXoyX3jLJkWzhE00OUDBEdEzp2twifLy2JOOJ"];
    UIViewController *vc = [[OpeningViewController alloc] initWithNibName:@"OpeningViewController"
                                                                   bundle:nil];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = nc;
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@1 forKey:@"level"];
    [defaults synchronize];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
