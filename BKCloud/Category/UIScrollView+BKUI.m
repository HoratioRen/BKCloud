//
//  UIScrollView+BKUI.m
//  BKCloudAPI
//
//  Created by shuai ren on 2020/6/22.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#import "UIScrollView+BKUI.h"
#import "UIView+BKUI.h"
#import "BKDefine.h"

@implementation UIScrollView (BKUI)

- (void)bk_closeScrollViewInsetAdjustment{
    if(@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else if(self.bk_viewController) {
        BeginIgnoreDeprecatedWarning
        self.bk_viewController.automaticallyAdjustsScrollViewInsets = false;
        EndIgnoreDeprecatedWarning
    }
}



@end
