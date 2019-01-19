//
//  AppDelegate.h
//  GrandKit
//
//  Created by Evan Fang on 2019/1/18.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKMainViewController.h"

@interface GKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) GKMainViewController *mainViewController;

@end

