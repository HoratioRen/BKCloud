//
//  BKNetWorkManager.h
//  BeiKongAPI_Cloud
//
//  Created by BKSX CN on 2019/12/5.
//  Copyright © 2019 bksx. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface BKNetWorkManager : AFHTTPSessionManager

+ (BKNetWorkManager *)sharedManager;

+ (void)GET:(NSString *)URLString
  parameters:(nullable id)parameters
showHudBlock:(void (^_Nullable)(void))showHudBlock
hidenHudBlock:(void (^_Nullable)(void))hidenHudBlock
      success:(void (^)(id _Nullable responseObject))success
    failure:(void (^)(NSError *))failure;

+ (void)POST:(NSString *)URLString
  parameters:(nullable id)parameters
    showHudBlock:(void (^_Nullable)(void))showHudBlock
    hidenHudBlock:(void (^_Nullable)(void))hidenHudBlock
          success:(void (^)(id _Nullable responseObject))success
        failure:(void (^)(NSError *))failure;

+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> _Nonnull))block
    showHudBlock:(void (^_Nullable)(void))showHudBlock
    hidenHudBlock:(void (^_Nullable)(void))hidenHudBlock
          success:(void (^)(id _Nullable responseObject))success
        failure:(void (^)(NSError *))failure;


@end

NS_ASSUME_NONNULL_END
