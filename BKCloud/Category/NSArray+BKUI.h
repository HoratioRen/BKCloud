//
//  NSArray+BKUI.h
//  BKCloudAPI
//
//  Created by shuai ren on 2020/6/29.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (BKUI)

/*将一个数组按个数subSize分组拆分*/
- (NSArray *)bk_splitWithSubsize:(int) subSize;

@end

NS_ASSUME_NONNULL_END
