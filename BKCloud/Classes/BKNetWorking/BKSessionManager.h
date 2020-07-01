//
//  BKSessionManager.h
//  BeiKongAPI_Cloud
//
//  Created by BKSX CN on 2019/12/9.
//  Copyright © 2019 BKSX CN. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface BKSessionManager : AFHTTPSessionManager

+(BKSessionManager *)sharedManager;

/// 从北控云认证
/// @param URLString 应用请求服务地址
/// @param result 结果回调
- (void)requestCloudPermissionsWithURLString:(NSString *)URLString
                                      result:(void (^)(BOOL granted))result;

/// 开始定位
-(void)loactionUpdate;

@end

NS_ASSUME_NONNULL_END
