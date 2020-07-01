//
//  BKCloudManager.m
//  BeiKongAPI_Cloud
//
//  Created by BKSX CN on 2019/12/4.
//  Copyright © 2019 bksx. All rights reserved.
//

#import "BKCloudManager.h"
#import "BKSessionManager.h"

@implementation BKCloudManager

+ (void)setupAppkey:(NSString *)key{
    
    
    [[BKSessionManager sharedManager] setValue:key forKeyPath:@"appkey"];
    [[BKSessionManager sharedManager] requestCloudPermissionsWithURLString:@"" result:^(BOOL granted) {
        if (granted) {
            NSLog(@"北控云Appkey设置成功");
            [[BKSessionManager sharedManager] loactionUpdate];
        }else{
            NSLog(@"北控云Appkey设置失败");
        }
        
    }];
}

/**
 打开某模块的日志，默认不打印日志
 debug时，建议打开，有利于调试程序；release时建议关闭
 @param enable 是否开启日志打印
 */
+ (void)logEnable:(BOOL)enable module:(BKCloudModule)module{

    switch (module) {
        case BKCloudModuleNetWork:
            [[BKSessionManager sharedManager] setValue:(enable?@1:@0) forKeyPath:@"logEnable"];
            break;
            
        default:
            break;
    }
    
}

@end
