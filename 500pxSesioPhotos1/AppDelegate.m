//
//  AppDelegate.m
//  500pxSesioPhotos1
//
//  Created by Sergio Becerril on 11/11/14.
//  Copyright (c) 2014 Sergio Becerril. All rights reserved.
//

#import "AppDelegate.h"
//Importamos el ViewController
#import "ViewController.h"

//Importamos esta clase para utilizar la API de 500px
#import <PXAPI/PXAPI.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


//https://api.500px.com/v1/photos?feature=popular&page=1&consumer_key=Rspv4Pq9q2DzvrBFcQdvisEh5xedohf7pgHZWU3o

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //Establecemos las keys
     [PXRequest setConsumerKey:@"Rspv4Pq9q2DzvrBFcQdvisEh5xedohf7pgHZWU3o" consumerSecret:@"5z012ZZRJ7BrhMNqNGgzbhjLpEkou5M4liGDfgqo"];
    
    //Decimos a nuestro App Delegate la vista principal que debe cargar
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    //[[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
    //[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    navController.navigationBar.translucent = YES;
    
    self.window.rootViewController = navController;
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
