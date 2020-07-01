//
//  BKCloudKit.h
//  BKCloudAPI
//
//  Created by BKSX CN on 2020/5/14.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#ifndef BKCloudKit_h
#define BKCloudKit_h

// 问题：项目不能引用分类方法，崩溃-- 在项目中Other Linker flag 加-ObjC


//#import "BKCloudManager.h"
//#import "BKNetworking.h"

#pragma mark - 工具类
#if __has_include("BKDefine.h")
#import "BKDefine.h"
#endif

#if __has_include("BKMethods.h")
#import "BKMethods.h"
#endif

#if __has_include("BKDefineHelper.h")
#import "BKDefineHelper.h"
#endif

#pragma mark - NSObject

#if __has_include("NSArray+BKUI.h")
#import "NSArray+BKUI.h"
#endif

#if __has_include("NSObject+BKUI.h")
#import "NSObject+BKUI.h"
#endif

#if __has_include("NSString+BKUI.h")
#import "NSString+BKUI.h"
#endif


#pragma mark - UIKit

#if __has_include("UIAlertController+BKUI.h")
#import "UIAlertController+BKUI.h"
#endif

#if __has_include("UIApplication+BKUI.h")
#import "UIApplication+BKUI.h"
#endif

#if __has_include("UIDevice+BKUI.h")
#import "UIDevice+BKUI.h"
#endif

#if __has_include("UIImage+BKUI.h")
#import "UIImage+BKUI.h"
#endif

#if __has_include("UILabel+BKUI.h")
#import "UILabel+BKUI.h"
#endif

#if __has_include("UIScrollView+BKUI.h")
#import "UIScrollView+BKUI.h"
#endif

#if __has_include("UIView+BKUI.h")
#import "UIView+BKUI.h"
#endif

#pragma mark - *** KeyWindow ***
#define BK_KeyWindow [UIApplication sharedApplication].bk_keyWindow

#pragma mark - *** 状态栏高度 ***
#define BKStatusBarHeight  [BKDefineHelper bk_statusBarHeight]
#pragma mark - *** 导航栏内距高度 ***
#define BKNavigationMargin  [BKDefineHelper bk_navigationMargin]

#endif /* BKCloudKit_h */
