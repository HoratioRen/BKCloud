//
//  UIAlertController+BKUI.h
//  BKCloudAPI
//
//  Created by BKSX CN on 2020/5/13.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (BKUI)

+ (void)showTextAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         confirmTitletitle:(NSString *)confirmTitle
                   handler:(void (^)(void))confirmHandler;

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              confirmTitle:(NSString *)confirmTitle
               cancelTitle:(NSString *)cancelTitle
            confirmHandler:(void (^)(void))confirmHandler
             cancelHandler:(void (^)(void))cancelHandler;

+ (void)showAlertInController:(UIViewController *)vc
                    withTitle:(NSString *)title
                      message:(NSString *)message
                 confirmTitle:(NSString *)confirmTitle
                  cancelTitle:(NSString *)cancelTitle
               confirmHandler:(void (^)(void))confirmHandler
                cancelHandler:(void (^)(void))cancelHandler;

+ (void)showSheetWithTitle:(NSString *)title
                   message:(NSString *)message
              selectTitles:(NSArray *)selectTitles
               cancelTitle:(NSString *)cancelTitle
            confirmHandler:(void (^)(NSInteger index))confirmHandler
             cancelHandler:(void (^)(void))cancelHandler;


+ (void)showSheetInController:(UIViewController *)vc
                    withTitle:(NSString *)title
                      message:(NSString *)message
                 selectTitles:(NSArray *)selectTitles
                  cancelTitle:(NSString *)cancelTitle
               confirmHandler:(void (^)(NSInteger index))confirmHandler
                cancelHandler:(void (^)(void))cancelHandler;


@end
