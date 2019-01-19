//
//  AppDelegate.h
//  GrandKit
//
//  Created by Evan Fang on 2019/1/18.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKNavigationController.h"
#import "GKMainViewController.h"

@interface GKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) GKNavigationController *navigationController;
@property (strong, nonatomic) GKMainViewController *mainViewController;

@end

