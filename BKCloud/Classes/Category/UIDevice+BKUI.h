//
//  UIDevice+BKUI.h
//  BKCloudAPI
//
//  Created by BKSX CN on 2020/5/13.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (BKUI)

/// 设备发布名称 eg. iPhone8
@property (nonatomic, copy ,readonly) NSString * bk_releaseName;
/// 获取UUID
@property (nonatomic, copy ,readonly) NSString * bk_uuid;

@end

NS_ASSUME_NONNULL_END
