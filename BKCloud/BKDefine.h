//
//  BKDefine.h
//  BKCloudAPI
//
//  Created by shuai ren on 2020/6/22.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#ifndef BKDefine_h
#define BKDefine_h

#endif /* BKDefine_h */

#pragma mark - **** Clang ****
#define ArgumentToString(macro) #macro
#define ClangWarningConcat(warning_name) ArgumentToString(clang diagnostic ignored warning_name)
// 参数可直接传入 clang 的 warning 名，warning 列表参考：http://fuckingclangwarnings.com/
#define BeginIgnoreClangWarning(warningName) _Pragma("clang diagnostic push") _Pragma(ClangWarningConcat(#warningName))
#define EndIgnoreClangWarning _Pragma("clang diagnostic pop")
// 可用性警告，未使用变量警告
#define BeginIgnoreAvailabilityWarning BeginIgnoreClangWarning(-Wpartial-availability)
#define EndIgnoreAvailabilityWarning EndIgnoreClangWarning
// 弃用警告
#define BeginIgnoreDeprecatedWarning BeginIgnoreClangWarning(-Wdeprecated-declarations)
#define EndIgnoreDeprecatedWarning EndIgnoreClangWarning

#pragma mark - *** 系统版本 ***
#define BKSystemVersion(a) ([UIDevice currentDevice].systemVersion.floatValue >= a)


#pragma mark - *** 调试打印 ***
#define BKLog(fmt, ...)  NSLog((@"\n\n\n函数名:%s\n" "行号:%d \n【输出】" fmt"\n"), __FUNCTION__, __LINE__, ##__VA_ARGS__)

#pragma mark - *** 颜色 ***
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define RandomColor  [UIColor colorWithRed:arc4random_uniform(255.0)/255.0 green:arc4random_uniform(255.0)/255.0 blue:arc4random_uniform(255.0)/255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)




#pragma mark - *** 屏幕宽高 ***
#define BKScreenHeight MAX([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)
#define BKScreenWidth  MIN([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)

#pragma mark - *** 纯代码适配宽高 ***
//iPhoneX / iPhoneXS
#define  BK_isIphoneX_XS        (BKScreenWidth == 375.f && BKScreenHeight == 812.f ? YES : NO)
//iPhoneXR / iPhoneXSMax
#define  BK_isIphoneXR_XSMax    (BKScreenWidth == 414.f && BKScreenHeight == 896.f ? YES : NO)
//异性全面屏
#define  BK_IsFullScreen   (BK_isIphoneX_XS || BK_isIphoneXR_XSMax)
//#define  BK_IsFullScreen   (BK_StatusBarHeight>20)

//纯代码适配齐安全区
#define BK_TabHeight  (BK_IsFullScreen ? (49+34) : 49)
#define BK_NavHeight  (BK_IsFullScreen ? 88 : 64)
//用于iphone6的等比例适配
#define BK_Width(a)   ((BKScreenWidth / 375)*(a))
//全面屏 纯代码的宽高比适配
#define BK_Height(a)   (BK_IsFullScreen ? (BK_isIphoneX_XS?a:(a/667.0f*736.0f)):(a/667.0f*BKScreenHeight))


#pragma mark - *** App Info ***
#define BK_BundleID ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"])
#define BK_APPNAME    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
#define BK_APPVERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])

#pragma mark - *** 持久性目录（沙盒） ***
#define BK_DOCUMENT_DIRECTORY NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject
#define BK_CACHE_DIRECTORY NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject

#pragma mark - *** FMDB路径  ***
#define BK_FMDBPATH [NSString stringWithFormat:@"%@/%@.db", BK_DOCUMENT_DIRECTORY, BK_APPNAME]

//类型转String
#define NSStringFromInteger(a)  [NSString stringWithFormat:@"%ld",(long)a]
#define NSStringFromFloat(a)    [NSString stringWithFormat:@"%f",a]
#define NSStringFromNumber(a)   [NSString stringWithFormat:@"%@",a]
#define NSStringFromBOOL(a)     [NSString stringWithFormat:@"%ld",a?1:0]

//防止循环引用--- 弱引用 & 强引用
#define BKWeakObj(type)  __weak typeof(type) weak##type = type;
#define BKStrongObj(type) __strong typeof(type) type = weak##type;

#define BKWeakSelf  __weak typeof(self) weakSelf = self;
#define BKStrongSelf __strong typeof(self) self = weakSelf;

//控件抗被拉伸优先级最高 1000（优先级越高，越不容易被拉伸）
#define  BKContentHuggingPriorityRequired(name) [name setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
//控件抗被拉伸优先级低 250（优先级越高，越不容易被拉伸）
#define  BKContentHuggingPriorityDefaultLow(name) [name setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];

//控件抗压缩的优先级 1000 （优先级越高，越不容易被压缩）
#define  BKContentCompressionResistancePriorityRequired(name) [name setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

//控件抗压缩的优先级 250 （优先级越高，越不容易被压缩）
#define  BKContentCompressionResistancePriorityDefaultLow(name) [name setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
