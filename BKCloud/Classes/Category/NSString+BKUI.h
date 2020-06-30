//
//  NSString+BKUI.h
//  BKCloudAPI
//
//  Created by BKSX CN on 2020/5/13.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (BKUI)

/// SHA1编码加密方式
@property(readonly, copy) NSString *bk_sha1;
/// MD5加密方式
@property(readonly, copy) NSString *bk_md5;

// base64编码
-(NSString *)base64Encode;
// base64解码
-(NSString *)base64Decode;

/// 获取字符串的字符长度
- (NSUInteger)bk_lengthWhenNSStringEncoding;
/// 按字母一个字符，中文两个字符计算字符长度
- (NSUInteger)bk_lengthWhenCountingNonASCIICharacterAsTwo;

/// 计算文本宽度
-(CGFloat)bk_getTextWidthForFont:(UIFont *)font;


@end

#pragma mark -时间转换
@interface NSString (Date)

/// 时间格式转换    "yyyy.MM.dd HH.mm.ss"
+ (NSString *)bk_dateToString:(NSDate *)selectDate format:(NSString *)format;
+ (NSDate*)bk_stringToDate:(NSString*)dateString format:(NSString *)format;
- (NSString *)bk_dateConvertionFormFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat ;

@end
#pragma mark -正则校验 // 满足条件返回yes
@interface NSString (Validate)

/* 非法字符验证 */
- (BOOL)bk_containsTheillegalCharacter;// 含非法字符返回yes
/* 邮箱验证 */
- (BOOL)bk_isEmail;
/*手机号码验证 */
- (BOOL) bk_isPhoneNumber;
/*汉字验证*/
-(BOOL)bk_isChinese;
/*人名验证*/
- (BOOL) bk_isPeopleName;
/*身份证验证*/
- (BOOL) bk_isIDCard;
/*验证码校验 6位*/
- (BOOL) bk_isValidateCode;
/*密码校验 6-30位字母数字*/
- (BOOL) bk_isPassWord;
@end



NS_ASSUME_NONNULL_END
