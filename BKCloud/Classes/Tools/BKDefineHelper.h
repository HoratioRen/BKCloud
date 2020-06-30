//
//  BKDefineHelper.h
//  BKCloudAPI
//
//  Created by BKSX CN on 2020/6/22.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BKDefineHelper : NSObject

/// 状态栏高度
+ (CGFloat)bk_statusBarHeight;
/// 导航栏边距
+ (CGFloat)bk_navigationMargin;


//快速生成model属性的方法 (字典或数组)
+ (void)bk_logPropertyWithObject:(id)obj;

//当前展示VC
+ (UIViewController *)bk_topViewController;

@end

NS_ASSUME_NONNULL_END
