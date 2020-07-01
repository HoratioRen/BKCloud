//
//  UIDevice+BKUI.m
//  BKCloudAPI
//
//  Created by BKSX CN on 2020/5/13.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#import "UIDevice+BKUI.h"
#import <sys/utsname.h>
#import <SAMKeychain/SAMKeychain.h>
@implementation UIDevice (BKUI)

/// 获取UUID
- (NSString *)bk_uuid{
    NSString * bundleID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    NSString * uuid = [SAMKeychain passwordForService:bundleID account:@"BKDeviceUUID"];
    if (!uuid || uuid==nil || [uuid isKindOfClass:[NSNull class]] || uuid.length == 0) {
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
        uuid = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        [SAMKeychain setPassword:uuid forService:bundleID account:@"BKDeviceUUID"];
    }
    return uuid;
}


/// iPhone发布名称
-(NSString *)bk_releaseName{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * string = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([string isEqualToString:@"iPhone6,1"] || [string isEqualToString:@"iPhone6,2"]) {
        return @"iPhone5s";
    }else if ([string isEqualToString:@"iPhone7,2"]){
        return @"iPhone6";
    }else if ([string isEqualToString:@"iPhone7,1"]){
        return @"iPhone6Plus";
    }else if ([string isEqualToString:@"iPhone8,1"]){
        return @"iPhone6s";
    }else if ([string isEqualToString:@"iPhone8,2"]){
        return @"iPhone6sPlus";
    }else if ([string isEqualToString:@"iPhone8,4"]){
        return @"iPhoneSE";
    }else if ([string isEqualToString:@"iPhone9,1"] || [string isEqualToString:@"iPhone9,3"]){
        return @"iPhone7";
    }else if ([string isEqualToString:@"iPhone9,2"] || [string isEqualToString:@"iPhone9,4"]){
        return @"iPhone7Plus";
    }else if ([string isEqualToString:@"iPhone10,1"] || [string isEqualToString:@"iPhone10,4"]){
        return @"iPhone8";
    }else if ([string isEqualToString:@"iPhone10,2"] || [string isEqualToString:@"iPhone10,5"]){
        return @"iPhone8Plus";
    }else if ([string isEqualToString:@"iPhone10,3"] || [string isEqualToString:@"iPhone10,6"]){
        return @"iPhoneX";
    }else if ([string isEqualToString:@"iPhone11,8"]){
        return @"iPhoneXR";
    }else if ([string isEqualToString:@"iPhone11,2"]){
        return @"iPhoneXS";
    }else if ([string isEqualToString:@"iPhone11,6"] || [string isEqualToString:@"iPhone11,4"]){
        return @"iPhoneXSMax";
    }else if ([string isEqualToString:@"iPhone12,1"]){
        return @"iPhone11";
    }else if ([string isEqualToString:@"iPhone12,3"]){
        return @"iPhone11Pro";
    }else if ([string isEqualToString:@"iPhone12,5"]){
        return @"iPhone11ProMax";
    }
    return @"iPhone";
}



@end
