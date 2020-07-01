//
//  BKNetWorkManager.m
//  BeiKongAPI_Cloud
//
//  Created by BKSX CN on 2019/12/5.
//  Copyright © 2019 bksx. All rights reserved.
//

#import "BKNetWorkManager.h"
#import "BKSessionManager.h"

@implementation BKNetWorkManager
static BKNetWorkManager * netWorkManager = nil;
+(BKNetWorkManager *)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorkManager = [BKNetWorkManager manager];
        netWorkManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        netWorkManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        netWorkManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"image/jpeg",@"multipart/form-data",@"text/javascript",@"text/xml",@"image/*", @"application/octet-stream",@"application/zip",nil];
        netWorkManager.requestSerializer.timeoutInterval = 30;
    });
    return netWorkManager;
}

+ (void)GET:(NSString *)URLString
  parameters:(nullable id)parameters
showHudBlock:(void (^_Nullable)(void))showHudBlock
hidenHudBlock:(void (^_Nullable)(void))hidenHudBlock
resultBlock:(void (^)(AFReturnModel *))resultBlock
{
    
    if (showHudBlock) {
        showHudBlock();
    }
    [[BKSessionManager sharedManager] requestCloudPermissionsWithURLString:URLString result:^(BOOL granted) {
        
        if (!granted) {
            if (showHudBlock && hidenHudBlock) {
                // 如果有HUD 则移除HUD
                hidenHudBlock();
            }
            return ;
        }
        
        [[BKNetWorkManager sharedManager] GET:URLString parameters:parameters headers:nil  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (showHudBlock && hidenHudBlock) {
                hidenHudBlock();
            }
            // 调用请求成功回调
            [self requestSucceedResponseObject:responseObject resultBlock:resultBlock];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (showHudBlock && hidenHudBlock) {
                hidenHudBlock();
            }
            // 调用请求失败回调
            [self requestFailureError:error resultBlock:resultBlock];
        }];
        
    }];
}

+ (void)POST:(NSString *)URLString
  parameters:(nullable id)parameters
    showHudBlock:(void (^_Nullable)(void))showHudBlock
    hidenHudBlock:(void (^_Nullable)(void))hidenHudBlock
 resultBlock:(void (^)(AFReturnModel *))resultBlock
{
    if (showHudBlock) {
        showHudBlock();
    }
    
    [[BKSessionManager sharedManager] requestCloudPermissionsWithURLString:URLString result:^(BOOL granted) {
        if (!granted) {
            if (showHudBlock && hidenHudBlock) {
                // 如果有HUD 则移除HUD
                hidenHudBlock();
            }
            return ;
        }
        
        [[BKNetWorkManager sharedManager] POST:URLString parameters:parameters headers:nil  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (showHudBlock && hidenHudBlock) {
                hidenHudBlock();
            }
            // 调用请求成功回调
            [self requestSucceedResponseObject:responseObject resultBlock:resultBlock];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (showHudBlock && hidenHudBlock) {
                hidenHudBlock();
            }
            // 调用请求失败回调
            [self requestFailureError:error resultBlock:resultBlock];
        }];
        
        
    }];
}

+ (void)POST:(NSString *)URLString
  parameters:(nullable id)parameters
        name:(NSString *)name
   fileArray:(NSArray <BKFileModel *>*)fileArray
      showHudBlock:(void (^_Nullable)(void))showHudBlock
      hidenHudBlock:(void (^_Nullable)(void))hidenHudBlock
      resultBlock:(void (^)(AFReturnModel *))resultBlock
{
    
    if (showHudBlock) {
        showHudBlock();
    }
    
    [[BKSessionManager sharedManager] requestCloudPermissionsWithURLString:URLString result:^(BOOL granted) {
        
        if (!granted) {
            if (showHudBlock && hidenHudBlock) {
                hidenHudBlock();
            }
            return ;
        }
        
        [[BKNetWorkManager sharedManager] POST:URLString parameters:parameters headers:nil  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [fileArray enumerateObjectsUsingBlock:^(BKFileModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [formData appendPartWithFileData:obj.data name:name fileName:obj.fileName mimeType:obj.fileType];
            }];
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (showHudBlock && hidenHudBlock) {
                hidenHudBlock();
            }
            // 调用请求成功回调
            [self requestSucceedResponseObject:responseObject resultBlock:resultBlock];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (showHudBlock && hidenHudBlock) {
                hidenHudBlock();
            }
            // 调用请求失败回调
            [self requestFailureError:error resultBlock:resultBlock];
        }];
        
    }];
}

/**
 请求成功的回调
 
 @param responseObject 请求返回的Obj
 @param resultBlock        成功block
 */
+ (void)requestSucceedResponseObject:(id _Nullable) responseObject
                         resultBlock:(void (^)(AFReturnModel *))resultBlock
{
    NSDictionary *dataDic = [NSDictionary new];
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        dataDic = (NSDictionary *)responseObject;
    }else{
        dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:nil];
    }
    AFReturnModel *result = [AFReturnModel new];
    if (dataDic) {
        [result setValuesForKeysWithDictionary:dataDic];
        if (result.code != 200) {
            NSLog(@"请求错误-code：%ld , message:%@",(long)result.code,result.returnMsg);
        }
    }else{
        result.code = -1014;
        result.returnMsg = @"返回数据为空";
        NSLog(@"请求错误-code：%ld , message:%@",(long)result.code,result.returnMsg);
    }
    if (resultBlock) {
        resultBlock(result);
    }
}

/**
 请求失败的回调
 
 @param error 请求返回的Obj
 @param resultBlock        block
 */
+ (void)requestFailureError:(NSError * )error
                resultBlock:(void (^)(AFReturnModel *))resultBlock{
    AFReturnModel *result = [AFReturnModel new];
    result.code = error.code;
    result.returnMsg = error.localizedDescription;
    if (resultBlock) {
        resultBlock(result);
    }
    NSLog(@"请求错误详情：%@",error);
    NSLog(@"请求错误-code：%ld , message:%@",(long)result.code,result.returnMsg);
}

@end


@implementation AFReturnModel
-(instancetype)init{
    if (self = [super init]) {
        _pageCount = @"1";
        _rowsCount = @"1";
        _startNum = @"1";
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"returnCode"]) {
        if ([value isKindOfClass:[NSNumber class]]) {
            self.code = [(NSNumber *)value integerValue];
        }else if([value isKindOfClass:[NSString class]]) {
            self.code = [(NSString *)value integerValue];
        }
    }else{
        NSLog(@"AFReturnModel未发现属性：%@",key);
    }
}
@end

@implementation BKFileModel
@end
