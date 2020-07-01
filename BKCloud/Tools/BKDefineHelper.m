//
//  BKDefineHelper.m
//  BKCloudAPI
//
//  Created by BKSX CN on 2020/6/22.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#import "BKDefineHelper.h"
#import "BKDefine.h"
#import "UIApplication+BKUI.h"

@implementation BKDefineHelper

+ (CGFloat)bk_statusBarHeight{
    if (@available(iOS 13.0, *)) {
        UIWindow * keyWindow = [UIApplication.sharedApplication bk_keyWindow];
        return keyWindow.windowScene.statusBarManager.statusBarFrame.size.height;
    } else {
        BeginIgnoreDeprecatedWarning
        return UIApplication.sharedApplication.statusBarFrame.size.height;
        EndIgnoreDeprecatedWarning
    }
}

+ (CGFloat)bk_navigationMargin{
    if (BKScreenWidth == 320) {
        return 8;
    }else if (BKScreenWidth == 375){
        return 10;
    }else {
        return 12;
    }
}


/// 快速生成model属性的方法
+ (void)bk_logPropertyWithObject:(id)obj{
#if DEBUG
    NSDictionary *dic = [NSDictionary new];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *tempDic = [(NSDictionary *)obj mutableCopy];
        dic = tempDic;
    } else if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *tempArr = [(NSArray *)obj mutableCopy];
        if (tempArr.count > 0) {
            dic = tempArr[0];
        } else {
            NSLog(@"无法解析为model属性，因为数组为空");
            return;
        }
    } else {
        NSLog(@"无法解析为model属性，因为并非数组或字典");
        return;
    }
    
    if (dic.count == 0) {
        NSLog(@"无法解析为model属性，因为该字典为空");
        return;
    }
    NSMutableString *strM = [NSMutableString string];
    NSArray *nameSortArray = [dic.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        //            字符串大小比较
        /*
         typedef NS_ENUM(NSInteger, NSComparisonResult) {NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending};
         */
        NSComparisonResult result = [obj1 compare:obj2];
        //            字符串不能通过大于或者是小于来比较
        return result;
    }];

    for (NSString * key in nameSortArray) {
        id value = [dic valueForKey:key];
        NSString *className = NSStringFromClass([value class]) ;
        NSLog(@"className:%@/n", className);
        if ([className isEqualToString:@"__NSCFString"] | [className isEqualToString:@"__NSCFConstantString"] | [className isEqualToString:@"NSTaggedPointerString"]) {
            [strM appendFormat:@"@property (nonatomic, copy) NSString *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFArray"] |
                  [className isEqualToString:@"__NSArray0"] |
                  [className isEqualToString:@"__NSArrayI"]){
            [strM appendFormat:@"@property (nonatomic, strong) NSArray *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFDictionary"]){
            [strM appendFormat:@"@property (nonatomic, strong) NSDictionary *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFNumber"]){
            [strM appendFormat:@"@property (nonatomic, copy) NSNumber *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFBoolean"]){
            [strM appendFormat:@"@property (nonatomic, assign) BOOL   %@;\n",key];
        }else if ([className isEqualToString:@"NSDecimalNumber"]){
            [strM appendFormat:@"@property (nonatomic, copy) NSString *%@;\n",[NSString stringWithFormat:@"%@",key]];
        }
        else if ([className isEqualToString:@"NSNull"]){
            [strM appendFormat:@"@property (nonatomic, copy) NSString *%@;\n",[NSString stringWithFormat:@"%@",key]];
        }else if ([className isEqualToString:@"__NSArrayM"]){
            [strM appendFormat:@"@property (nonatomic, strong) NSMutableArray *%@;\n",[NSString stringWithFormat:@"%@",key]];
        }
    }
    NSLog(@"\n%@\n",strM);
#endif
}


+ (UIViewController *)bk_topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication.sharedApplication bk_keyWindow] rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}
+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
