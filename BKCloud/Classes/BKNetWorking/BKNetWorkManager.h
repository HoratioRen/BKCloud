//
//  BKNetWorkManager.h
//  BeiKongAPI_Cloud
//
//  Created by BKSX CN on 2019/12/5.
//  Copyright © 2019 bksx. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFReturnModel : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) id     returnData;
@property (nonatomic, copy) NSString *returnMsg;
@property (nonatomic, copy) NSString *pageCount;
@property (nonatomic, copy) NSString *rowsCount;
@property (nonatomic, copy) NSString *startNum;
@end


@interface BKFileModel : NSObject

@property (nonatomic, strong) NSData *data;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *fileType;
@end


@interface BKNetWorkManager : AFHTTPSessionManager

+ (BKNetWorkManager *)sharedManager;

+  (void)GET:(NSString *)URLString
  parameters:(nullable id)parameters
showHudBlock:(void (^_Nullable)(void))showHudBlock
hidenHudBlock:(void (^_Nullable)(void))hidenHudBlock
resultBlock:(void (^)(AFReturnModel *))resultBlock;

+ (void)POST:(NSString *)URLString
  parameters:(nullable id)parameters
showHudBlock:(void (^_Nullable)(void))showHudBlock
hidenHudBlock:(void (^_Nullable)(void))hidenHudBlock
 resultBlock:(void (^)(AFReturnModel *))resultBlock;

+ (void)POST:(NSString *)URLString
  parameters:(nullable id)parameters
        name:(NSString *)name
   fileArray:(NSArray <BKFileModel *>*)fileArray
showHudBlock:(void (^_Nullable)(void))showHudBlock
hidenHudBlock:(void (^_Nullable)(void))hidenHudBlock
 resultBlock:(void (^)(AFReturnModel *))resultBlock;


@end

NS_ASSUME_NONNULL_END
