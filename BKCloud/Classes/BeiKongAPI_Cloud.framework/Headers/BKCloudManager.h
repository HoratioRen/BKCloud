//
//  BKCloudManager.h
//  BeiKongAPI_Cloud
//
//  Created by BKSX CN on 2019/12/4.
//  Copyright © 2019 bksx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BKCloudType.h"
NS_ASSUME_NONNULL_BEGIN


@interface BKCloudManager : NSObject

+ (void)setupAppkey:(NSString *)key;

/**
 打开某模块的日志，默认不打印日志
 debug时，建议打开，有利于调试程序；release时建议关闭
 @param enable 是否开启日志打印
 */
+ (void)logEnable:(BOOL)enable module:(BKCloudModule)module;;


@end

NS_ASSUME_NONNULL_END
