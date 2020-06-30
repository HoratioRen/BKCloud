//
//  UIAlertController+BKUI.m
//  BKCloudAPI
//
//  Created by BKSX CN on 2020/5/13.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#import "UIAlertController+BKUI.h"
#import "BKDefine.h"
@implementation UIAlertController (BKUI)

/**
 *  返回一个view存在于视图阶层上的controller(如无特殊情况, 一般返回最顶层root Controller), 用于呈现AlertViewController, 兼容iOS7以上版本
 */
+ (UIViewController *)controllerInViewHierarchy {
    UIViewController *mostTopController = BK_KeyWindow.rootViewController;
    while (mostTopController.presentedViewController) {
        mostTopController = mostTopController.presentedViewController;
    }
    return mostTopController;
}

+ (void)showTextAlertWithTitle:(NSString *)title
                       message:(NSString *)message
             confirmTitletitle:(NSString *)confirmTitle
                       handler:(void (^)(void))confirmHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the action.
    UIAlertAction * action = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (confirmHandler) {
            confirmHandler();
        }
    }];
    // Add the action.
    [alertController addAction:action];
    UIViewController *viewController = [self controllerInViewHierarchy];
    if (viewController) {
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
}


+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              confirmTitle:(NSString *)confirmTitle
               cancelTitle:(NSString *)cancelTitle
            confirmHandler:(void (^)(void))confirmHandler
             cancelHandler:(void (^)(void))cancelHandler{
    [self showAlertInController:nil withTitle:title message:message confirmTitle:confirmTitle cancelTitle:cancelTitle confirmHandler:confirmHandler cancelHandler:cancelHandler];
}

+ (void)showAlertInController:(UIViewController *)vc
                    withTitle:(NSString *)title
                      message:(NSString *)message
                 confirmTitle:(NSString *)confirmTitle
                  cancelTitle:(NSString *)cancelTitle
               confirmHandler:(void (^)(void))confirmHandler
                cancelHandler:(void (^)(void))cancelHandler{
    
    NSString *cancelTitleStr = cancelTitle?:@"取消";
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the action.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitleStr style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (cancelHandler) {
            cancelHandler();
        }
    }];
    // Add the action.
    [alertController addAction:cancelAction];
    
    if (confirmTitle) {
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (confirmHandler) {
                confirmHandler();
            }
        }];
        [alertController addAction:otherAction];
    }
    
    UIViewController *viewController = vc?vc:[self controllerInViewHierarchy];
    if (viewController) {
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
}

+ (void)showSheetWithTitle:(NSString *)title
                   message:(NSString *)message
              selectTitles:(NSArray *)selectTitles
               cancelTitle:(NSString *)cancelTitle
            confirmHandler:(void (^)(NSInteger index))confirmHandler
             cancelHandler:(void (^)(void))cancelHandler{
    [self showSheetInController:nil withTitle:title message:message selectTitles:selectTitles cancelTitle:cancelTitle confirmHandler:confirmHandler cancelHandler:cancelHandler];
}


+ (void)showSheetInController:(UIViewController *)vc
                    withTitle:(NSString *)title
                      message:(NSString *)message
                 selectTitles:(NSArray *)selectTitles
                  cancelTitle:(NSString *)cancelTitle
               confirmHandler:(void (^)(NSInteger index))confirmHandler
                cancelHandler:(void (^)(void))cancelHandler{
    
    NSString *cancelTitleStr = cancelTitle?:@"取消";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitleStr style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (cancelHandler) {
            cancelHandler();
        }
    }];
    [alertController addAction:cancelAction];
    
    for (NSInteger i = 0; i<selectTitles.count; i++) {
        UIAlertAction * titleAction = [UIAlertAction actionWithTitle:selectTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (confirmHandler) {
                confirmHandler(i);
            }
        }];
        [alertController addAction:titleAction];
    }
    UIViewController *viewController = vc?vc:[self controllerInViewHierarchy];
    if (viewController) {
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
}


@end
