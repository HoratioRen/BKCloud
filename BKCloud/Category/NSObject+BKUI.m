//
//  NSObject+XQKit.m
//  XQBaseProject
//
//  Created by BKSX CN on 2018/8/27.
//  Copyright © 2018年 BKSX CN. All rights reserved.
//

#import "NSObject+BKUI.h"
#import <objc/runtime.h>
#import "BKDefine.h"
@interface BKDeallocMonitor : NSObject
@property (nonatomic, copy) NSString * deallocDesc;
@end
@implementation BKDeallocMonitor
@end

@implementation NSObject (BKUI)

/* 监听对象是否销毁 */
-(void)bk_addDeallocMonitor{
#ifdef DEBUG
    BKDeallocMonitor * helper = [[BKDeallocMonitor alloc] init];
    helper.deallocDesc = [NSString stringWithFormat:@"%@ has been deallocated", self];
    static char objKey_DeallocMonitor;
    objc_setAssociatedObject(self, &objKey_DeallocMonitor, helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
#endif
}

/***判断为非空,既非NSNull且长度(字符串)或者count(集合)>0
 */
- (BOOL)bk_isEmpty{
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }else if ([self isKindOfClass:[NSString class]]){
        return [(NSString *)self length]<=0;
    }else if ([self isKindOfClass:[NSData class]]){
        return [(NSData *)self length] <= 0;
    }else if ([self isKindOfClass:[NSArray class]]){
        return [(NSArray *)self count] <= 0;
    }else if ([self isKindOfClass:[NSDictionary class]]){
        return [(NSDictionary *)self count] <= 0;
    }
    return NO;
}

/// 返回当前类的所有属性
- (NSArray *)bk_properties{
    
    // 获取当前类的所有属性
    unsigned int count;// 记录属性个数
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    // 遍历
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        
        // An opaque type that represents an Objective-C declared property.
        // objc_property_t 属性类型
        objc_property_t property = properties[i];
        // 获取属性的名称 C语言字符串
        const char *cName = property_getName(property);
        // 转换为Objective C 字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
    }
    return [mArray copy];
}




@end
