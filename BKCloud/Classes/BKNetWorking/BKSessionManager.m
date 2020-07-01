//
//  BKSessionManager.m
//  BeiKongAPI_Cloud
//
//  Created by BKSX CN on 2019/12/9.
//  Copyright © 2019 BKSX CN. All rights reserved.
//

#import "BKSessionManager.h"
#import <CoreLocation/CoreLocation.h>

#import "UIDevice+BKUI.h"
#import "NSString+BKUI.h"
#import "UIAlertController+BKUI.h"

#import "BKJSONRequestSerializer.h"


#define BKCloudURL @"http://cloud.beikongyun.com/services/logserver/api/logserver-kafka/log"

//#define BKCloudURL @"http://192.168.130.61:8080/services/logserver/api/logserver-kafka/log"

@interface BKSessionManagerRequestBody : NSObject
// 设备参数
@property(copy, nonatomic) NSString * device_brand;//设备厂商
@property(copy, nonatomic) NSString * device_model;//设备型号
@property(copy, nonatomic) NSString * device_version;//设备系统版本
@property(copy, nonatomic) NSString * device_imei;//设备唯一IMEI
// app参数
@property(copy, nonatomic) NSString * app_name;//当前应用名
@property(copy, nonatomic) NSString * app_version_code;//应用版本号
@property(copy, nonatomic) NSString * app_version_name;//应用版本名
//@property(copy, nonatomic) NSString * app_package_name;//应用包名,ios不传

@property(copy, nonatomic) NSString * app_bundleID;//bundleID

@property(copy, nonatomic) NSString * device_time;//设备时间
@property(copy, nonatomic) NSString * device_longitude;//设备经度
@property(copy, nonatomic) NSString * device_latitude;//设备纬度

@property(copy, nonatomic) NSString * app_class_name;//应用当前类名
@property(copy, nonatomic) NSString * app_post_url;//应用请求服务地址

/// 实时获取log信息
-(NSDictionary *)getAppInfoDictionary;

@end


@interface BKSessionManager ()<CLLocationManagerDelegate>

@property(strong, nonatomic) CLLocationManager * locationManager ;// 获取定位
@property(strong, nonatomic) BKSessionManagerRequestBody * requestBody ;
@property(copy, nonatomic) NSString * appkey ;
@property(strong, nonatomic) NSNumber * logEnable;

@end

@implementation BKSessionManager
static BKSessionManager * manager = nil;
+(BKSessionManager *)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [BKSessionManager manager];
        manager.requestSerializer = [BKJSONRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = 10;
        manager.requestBody = [[BKSessionManagerRequestBody alloc] init];
        [manager.locationManager requestWhenInUseAuthorization];
        manager.logEnable = @1;// 默认打印
    });
    return manager;
}


/// 从北控云认证
/// @param URLString 应用请求服务地址
/// @param result 结果回调
- (void)requestCloudPermissionsWithURLString:(NSString *)URLString
                                     result:(void (^)(BOOL granted))result{
    
    // url 需要做字符处理
    self.requestBody.app_post_url = URLString;
    
    NSArray *syms = [NSThread  callStackSymbols];
    NSString *string = [[[syms objectAtIndex:2] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"[]"]] objectAtIndex:1];
    NSArray * arr = [string componentsSeparatedByString:@" "];
    if (arr.count>0) {
        self.requestBody.app_class_name = arr.firstObject;
        if (self.logEnable) {
            NSLog(@"调用云认证类名：%@",self.requestBody.app_class_name);
        }
    }else{
        self.requestBody.app_class_name = @"";
    }
    /*
       body
    */
    NSMutableDictionary * bodyDic = [NSMutableDictionary dictionaryWithDictionary:[self.requestBody getAppInfoDictionary]];
    
    /*
        header
     */
    // key+bundleid+时间戳
    NSString * signature = [NSString stringWithFormat:@"%@%@%@",manager.appkey,self.requestBody.app_bundleID,self.requestBody.device_time];
    // sha1加密算法
    [self.requestSerializer setValue:signature.bk_sha1 forHTTPHeaderField:@"signature"];
    [self.requestSerializer setValue:self.appkey forHTTPHeaderField:@"key"];
    [self.requestSerializer setValue:self.requestBody.device_time forHTTPHeaderField:@"timestamp"];
    /*
       POST
    */
    [[BKSessionManager sharedManager] POST:BKCloudURL parameters:bodyDic headers:nil  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *successStr = [[ NSString alloc ] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (self.logEnable) {
            if ([successStr boolValue]) {
                NSLog(@"北控云认证成功---%@",successStr);
            }else{
                NSLog(@"北控云认证失败---%@",successStr);
            }
        }
        if (result) {
            result([successStr boolValue]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
        NSString *errorStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (self.logEnable) {
            NSLog(@"北控云认证失败");
            NSLog(@"failure---%@",error);
            NSLog(@"failureData---%@",errorStr);
        }
        
        if (result) {
            result([errorStr boolValue]);
        }
        
    }];
    
}

#pragma mark -  定位
-(CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //        自动停顿位置更新
        _locationManager.pausesLocationUpdatesAutomatically = NO;
    }
    return _locationManager;
}

-(void)loactionUpdate{
    /** 开始定位 */
    if ([CLLocationManager locationServicesEnabled]){
        [self.locationManager startUpdatingLocation];
    }else{

        [UIAlertController showAlertWithTitle:@"北控云定位提示" message:@"北控云服务需要获取您的位置信息,请在设置中打开定位" confirmTitle:@"去设置" cancelTitle:@"取消" confirmHandler:^{
            if (@available(iOS 10.0, *)) {
                    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }else{
                    //1、方法启用告警
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];//这里写的URL地址是该app在app store里面的下载链接地址，其中ID是该app在app store对应的唯一的ID编号。
            #pragma clang diagnostic pop
            }
        } cancelHandler:^{
            
        }];
    }
    
}
#pragma mark -  定位代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocationCoordinate2D coordinate = [locations lastObject].coordinate;
    self.requestBody.device_longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
    self.requestBody.device_latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
}

@end

#pragma mark - BKSessionManagerRequestBody
@implementation BKSessionManagerRequestBody

-(instancetype)init{
    if (self = [super init]) {
        // app参数
        NSDictionary * infoDictionary = [[NSBundle mainBundle] infoDictionary];
        self.app_name = [infoDictionary objectForKey:@"CFBundleName"];
        self.app_version_code = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        self.app_version_name = [infoDictionary objectForKey:@"CFBundleVersion"];
        self.app_bundleID = [infoDictionary objectForKey:@"CFBundleIdentifier"];
        
        // 设备参数
        UIDevice * device = [UIDevice currentDevice];
        self.device_brand = @"Apple";
        self.device_model = device.bk_releaseName;
        self.device_imei = device.bk_uuid;
        self.device_version = [NSString stringWithFormat:@"%@%@",device.systemName,device.systemVersion];
        
        // 默认app启动时间
        NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
        [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
        self.device_time = [dateFormater stringFromDate:[NSDate date]];
        // 默认
        self.device_longitude = @"0.00000";
        self.device_latitude = @"0.00000";
        
        self.app_class_name = @"";
        self.app_post_url = @"";
    }
    return self;
}

/// 实时获取Body信息
-(NSDictionary *)getAppInfoDictionary{
    // body时间戳
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
    self.device_time = [dateFormater stringFromDate:[NSDate date]];
    
    NSMutableDictionary * dic = [NSMutableDictionary new];
    [dic setValue:self.device_brand forKey:@"device_brand"];
    [dic setValue:self.device_model forKey:@"device_model"];
    [dic setValue:self.device_version forKey:@"device_version"];
    [dic setValue:self.device_imei forKey:@"device_imei"];
    [dic setValue:self.app_name forKey:@"app_name"];
    [dic setValue:self.app_version_code forKey:@"app_version_code"];
    [dic setValue:self.app_version_name forKey:@"app_version_name"];
    [dic setValue:self.device_time forKey:@"device_time"];
    [dic setValue:self.device_longitude forKey:@"device_longitude"];
    [dic setValue:self.device_latitude forKey:@"device_latitude"];
    [dic setValue:self.app_post_url forKey:@"app_post_url"];
    [dic setValue:self.app_class_name forKey:@"app_class_name"];
    
    return [dic copy];
}


@end
