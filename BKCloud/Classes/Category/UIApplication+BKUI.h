//
//  UIApplication+BKUI.h
//  BKCloudAPI
//
//  Created by BKSX CN on 2020/5/14.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (BKUI)

-(void)bk_openURL:(NSString*)urlString;

- (UIWindow *)bk_keyWindow;

@end

NS_ASSUME_NONNULL_END
