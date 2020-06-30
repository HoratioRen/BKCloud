//
//  NSObject+XQKit.h
//  XQBaseProject
//
//  Created by BKSX CN on 2018/8/27.
//  Copyright © 2018年 BKSX CN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (BKUI)
/* 监听对象是否销毁 */
-(void)bk_addDeallocMonitor;

/* 判断为空,既NSNull且长度(字符串)或者count(集合)=0 */
- (BOOL)bk_isEmpty;

//返回当前类的所有属性
- (NSArray *)bk_properties;



@end
