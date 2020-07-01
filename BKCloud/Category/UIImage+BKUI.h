//
//  UIImage+BKUI.h
//  BKCloudAPI
//
//  Created by shuai ren on 2020/6/29.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (BKUI)

/// 生成纯颜色图片
+(UIImage *)bk_imageWithColor:(UIColor *)color;
/// 对图片尺寸进行压缩
-(UIImage*)bk_imageScaledToNewSize:(CGSize)newSize;

@end

NS_ASSUME_NONNULL_END
