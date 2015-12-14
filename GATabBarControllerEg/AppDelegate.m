//
//  AppDelegate.m
//  GATabBarControllerEg
//
//  Created by GikkiAres on 12/12/15.
//  Copyright © 2015 GikkiAres. All rights reserved.
//

#import "AppDelegate.h"
#import "GATabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  GATabBarController *tbc = [GATabBarController new];
  UIViewController *vc1 = [UIViewController new];
  vc1.view.backgroundColor = [UIColor orangeColor];
  UIViewController *vc2 = [UIViewController new];
  vc2.view.backgroundColor = [UIColor greenColor];
  UIViewController *vc3 = [UIViewController new];
  vc3.view.backgroundColor = [UIColor blueColor];
  tbc.viewControllers = @[vc1,vc2,vc3];
  NSArray *arrImg = @[[UIImage imageNamed:@"TabBar_Order"],[UIImage imageNamed:@"TabBar_Pay"],[UIImage imageNamed:@"TabBar_Scan"]];
  NSArray *arrSelectedImg = @[[UIImage imageNamed:@"TabBar_OrderT"],[UIImage imageNamed:@"TabBar_PayT"],[UIImage imageNamed:@"TabBar_ScanT"]];
  NSArray *arrTitle = @[@"1",@"2",@"3"];
  [tbc configImgArr:arrImg SelectedImgArr:arrSelectedImg
           TitleArr:arrTitle];
  self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
  self.window.rootViewController = tbc;
  [self.window makeKeyAndVisible];
  
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
