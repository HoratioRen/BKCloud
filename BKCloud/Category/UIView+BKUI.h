//
//  UIView+BKUI.h
//  BKCloudAPI
//
//  Created by BKSX CN on 2020/5/14.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (BKUI)

@property(assign, nonatomic, readonly) CGPoint ssBottomLeft ;
@property(assign, nonatomic, readonly) CGPoint ssBottomRight ;
@property(assign, nonatomic, readonly) CGPoint ssTopRight ;
@property(assign, nonatomic, readonly) CGPoint ssTopLeft ;

@property (assign, nonatomic) CGFloat ssHeight ;
@property (assign, nonatomic) CGFloat ssWidth ;
@property (assign, nonatomic) CGFloat ssTop ;
@property (assign, nonatomic) CGFloat ssLeft ;
@property (assign, nonatomic) CGFloat ssBottom ;
@property (assign, nonatomic) CGFloat ssRight ;
@property (assign, nonatomic) CGFloat ssCenterX ;
@property (assign, nonatomic) CGFloat ssCenterY ;
@property (assign, nonatomic) CGPoint ssOrigin ;
@property (assign, nonatomic) CGSize  ssSize ;

/// view四周加阴影 [view addShadowWithColor:[UIColor redColor] Opacity:0.8 Radius:3 Width:1];
/// @param color 阴影颜色
/// @param shadowOpacity 阴影透明度
/// @param shadowRadius 阴影圆角
/// @param shadowWidth 阴影宽度
-(void)bk_addShadowWithColor:(UIColor *)color Opacity:(CGFloat)shadowOpacity Radius:(CGFloat)shadowRadius Width:(float)shadowWidth;


/// view四周加虚线边框
/// @param lineLength 虚线段长度
/// @param lineSpacing 虚线间隔
/// @param linewidth 虚线宽度
/// @param lineColor 虚线颜色
- (void)bk_drawDashLineWithLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineWidth:(CGFloat)linewidth lineColor:(UIColor *)lineColor;


//    设置圆角
- (void)setCornerOnTop:(CGFloat) conner;
- (void)setAllCorner:(CGFloat) conner;


/// 获取view所属的VC
- (UIViewController *)bk_viewController;

@end

NS_ASSUME_NONNULL_END
