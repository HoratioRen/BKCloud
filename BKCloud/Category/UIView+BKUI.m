//
//  UIView+BKUI.m
//  BKCloudAPI
//
//  Created by BKSX CN on 2020/5/14.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#import "UIView+BKUI.h"

@implementation UIView (BKUI)

-(CGPoint)ssOrigin{
    return self.frame.origin;
}
-(void)setSsOrigin:(CGPoint)ssOrigin{
    CGRect newframe = self.frame;
    newframe.origin = ssOrigin;
    self.frame = newframe;
}
- (CGSize)ssSize
{
    return self.frame.size;
}
- (void)setSsSize:(CGSize)rsSize
{
    CGRect newframe = self.frame;
    newframe.size = rsSize;
    self.frame = newframe;
}

- (CGPoint)ssBottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)ssBottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)ssTopRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}
- (CGPoint)ssTopLeft
{
    CGFloat x = self.frame.origin.x ;//+ self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

- (CGFloat)ssHeight
{
    return self.frame.size.height;
}
- (void)setSsHeight:(CGFloat)ssHeight
{
    CGRect newframe = self.frame;
    newframe.size.height = ssHeight;
    self.frame = newframe;
}

- (CGFloat)ssWidth
{
    return self.frame.size.width;
}

- (void)setSsWidth:(CGFloat)ssWidth
{
    CGRect newframe = self.frame;
    newframe.size.width = ssWidth;
    self.frame = newframe;
}

- (CGFloat)ssTop
{
    return self.frame.origin.y;
}

- (void)setSsTop:(CGFloat)ssTop
{
    CGRect newframe = self.frame;
    newframe.origin.y = ssTop;
    self.frame = newframe;
}

- (CGFloat)ssLeft
{
    return self.frame.origin.x;
}

- (void)setSsLeft:(CGFloat)ssLeft
{
    CGRect newframe = self.frame;
    newframe.origin.x = ssLeft;
    self.frame = newframe;
}

- (CGFloat)ssCenterX
{
    return self.center.x;
}

- (void)setSsCenterX:(CGFloat)ssCenterX
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = ssCenterX- newFrame.size.width/2 ;
    self.frame = newFrame;
}

- (CGFloat)ssCenterY
{
    return self.center.y ;
}

- (void)setSsCenterY:(CGFloat)ssCenterY
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = ssCenterY - newFrame.size.height/2 ;
    self.frame = newFrame;
}

- (CGFloat)ssBottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setSsBottom:(CGFloat)ssBottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = ssBottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)ssRight
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setSsRight:(CGFloat)ssRight
{
    CGFloat delta = ssRight - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}


/// view四周加阴影
/// @param color 阴影颜色
/// @param shadowOpacity 阴影透明度
/// @param shadowRadius 阴影圆角
/// @param shadowWidth 阴影宽度
-(void)bk_addShadowWithColor:(UIColor *)color Opacity:(CGFloat)shadowOpacity Radius:(CGFloat)shadowRadius Width:(float)shadowWidth{
    self.layer.shadowColor = color.CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = shadowOpacity;//阴影透明度，默认0
    self.layer.shadowRadius = shadowRadius;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    float x = self.bounds.origin.x;
    float y = self.bounds.origin.y;
    float addWH = shadowWidth;
    
    CGPoint topLeft      = self.bounds.origin;
    CGPoint topMiddle = CGPointMake(x+(width/2),y-addWH);
    CGPoint topRight     = CGPointMake(x+width,y);
    
    CGPoint rightMiddle = CGPointMake(x+width+addWH,y+(height/2));
    
    CGPoint bottomRight  = CGPointMake(x+width,y+height);
    CGPoint bottomMiddle = CGPointMake(x+(width/2),y+height+addWH);
    CGPoint bottomLeft   = CGPointMake(x,y+height);
    
    
    CGPoint leftMiddle = CGPointMake(x-addWH,y+(height/2));
    
    [path moveToPoint:topLeft];
    //添加四个二元曲线
    [path addQuadCurveToPoint:topRight
                 controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight
                 controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft
                 controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft
                 controlPoint:leftMiddle];
    //设置阴影路径
    self.layer.shadowPath = path.CGPath;
}


/// view四周加虚线边框
/// @param lineLength 虚线段长度
/// @param lineSpacing 虚线间隔
/// @param linewidth 虚线宽度
/// @param lineColor 虚线颜色
- (void)bk_drawDashLineWithLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineWidth:(CGFloat)linewidth lineColor:(UIColor *)lineColor
{
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = (lineColor?:[UIColor lightGrayColor]).CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    border.frame = self.bounds;
    border.lineWidth = linewidth?:1;
    border.lineDashPattern = @[@(lineLength), @(lineSpacing)];
    [self.layer addSublayer:border];
}


#pragma mark - 设置圆角
- (void)setCornerOnTop:(CGFloat) conner {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                           cornerRadii:CGSizeMake(conner, conner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
- (void)setAllCorner:(CGFloat) conner {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                          cornerRadius:conner];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


/// 当前view所在的controller
- (UIViewController *)bk_viewController
{
    UIResponder *nextVC = self.nextResponder ;
    
    while (nextVC) {
        if ([nextVC isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextVC ;
        }
        nextVC = nextVC.nextResponder ;
    }
    return nil ;
}


@end
