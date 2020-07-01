//
//  UIScrollView+BKUI.h
//  BKCloudAPI
//
//  Created by shuai ren on 2020/6/22.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (BKUI)

/// 关闭ScrollViewInset调整
- (void)bk_closeScrollViewInsetAdjustment;

@end

NS_ASSUME_NONNULL_END
