//
//  BKCloudTools.h
//  BeiKongAPI_Cloud
//
//  Created by BKSX CN on 2019/12/5.
//  Copyright © 2019 bksx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BKCloudTools : NSObject


//sha1加密方式 <CommonCrypto/CommonDigest.h>
+ (NSString *) stringToSHA1:(NSString *)input;

// 提示框
+ (void)bkcShowAlertWithTitle:(NSString *)title
                   message:(NSString *)message
        confirmButtonTitle:(NSString *)confirmTitle
         cancelButtonTitle:(NSString *)cancelTitle
            confirmHandler:(void (^)(void))confirmHandler
             cancelHandler:(void (^)(void))cancelHandler;

@end

NS_ASSUME_NONNULL_END
