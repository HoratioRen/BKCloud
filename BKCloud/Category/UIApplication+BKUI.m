//
//  UIApplication+BKUI.m
//  BKCloudAPI
//
//  Created by BKSX CN on 2020/5/14.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#import "UIApplication+BKUI.h"

@implementation UIApplication (BKUI)

-(void)bk_openURL:(NSString*)urlString{
    if (@available(iOS 10.0, *)) {
        NSURL * url = [NSURL URLWithString:urlString];
        [UIApplication.sharedApplication openURL:url options:@{} completionHandler:nil];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [UIApplication.sharedApplication openURL:[NSURL URLWithString:urlString]];
#pragma clang diagnostic pop
    }
}

-(UIWindow *)bk_keyWindow{
    if (@available(iOS 13.0, *)) {
        return UIApplication.sharedApplication.windows.firstObject;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return UIApplication.sharedApplication.keyWindow;
#pragma clang diagnostic pop
    }
}



@end
