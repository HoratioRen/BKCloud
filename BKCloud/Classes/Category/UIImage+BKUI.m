//
//  UIImage+BKUI.m
//  BKCloudAPI
//
//  Created by shuai ren on 2020/6/29.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#import "UIImage+BKUI.h"

@implementation UIImage (BKUI)

/// 生成纯颜色图片
+(UIImage *)bk_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/// 对图片尺寸进行压缩
-(UIImage*)bk_imageScaledToNewSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
