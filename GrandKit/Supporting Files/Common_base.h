//
//  Common_base.h
//  GrandKit
//
//  Created by Evan Fang on 2019/1/18.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#ifndef Common_base_h
#define Common_base_h

#import "UILabel+Manage.h"
#import "UIImage+Com.h"
#import "UIFont+Com.h"

#define Size(x) ((x) * [[UIScreen mainScreen] bounds].size.width / 375.f)
#define Width [UIScreen mainScreen].bounds.size.width //屏幕宽
#define Height [UIScreen mainScreen].bounds.size.height //屏幕高

#define NHeight ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 88 : 64) // 导航栏高度

#define Color_FromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif /* Common_base_h */
