//
//  UILabel+BKUI.h
//  BKCloudAPI
//
//  Created by shuai ren on 2020/6/29.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (BKUI)

//快速创建label
+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor;

@end

NS_ASSUME_NONNULL_END
