//
//  NSString+BKUI.m
//  BKCloudAPI
//
//  Created by BKSX CN on 2020/5/13.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#import "NSString+BKUI.h"
#import<CommonCrypto/CommonDigest.h>

@implementation NSString (BKUI)

#pragma mark -进行base64编码
-(NSString *)base64Encode{
    NSData *data =[self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}
#pragma mark -进行base64解码
-(NSString *)base64Decode{
    //注意：该字符串是base64编码后的字符串
    NSData *data=[[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark -sha1加密方式 <CommonCrypto/CommonDigest.h>
- (NSString *)bk_sha1{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}
#pragma mark -MD5加密方式
- (NSString *)bk_md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSMutableString *saveResult = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%02x", result[i]];
    }
    return [saveResult lowercaseString];
}

/// 获取字符串的字符长度
- (NSUInteger)bk_lengthWhenNSStringEncoding{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [self dataUsingEncoding:enc];
    return [da length];
}
/// 按字母一个字符，中文两个字符计算字符长度
- (NSUInteger)bk_lengthWhenCountingNonASCIICharacterAsTwo {
    NSUInteger length = 0;
    for (NSUInteger i = 0, l = self.length; i < l; i++) {
        unichar character = [self characterAtIndex:i];
        if (isascii(character)) {
            length += 1;
        } else {
            length += 2;
        }
    }
    return length;
}

-(CGFloat)bk_getTextWidthForFont:(UIFont *)font{
    CGSize size = CGSizeMake(500 , 44);
    //    获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    //ios7方法，获取文本需要的size，限制宽度
    CGSize actualsize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    return actualsize.width;
}

@end

@implementation NSString (Date)

/** 时间转换 */
//date转时间    "yyyy.MM.dd HH.mm.ss"
+ (NSString *)bk_dateToString:(NSDate *)date format:(NSString *)format{
    NSDateFormatter *selectDateFormater = [[NSDateFormatter alloc] init];
    [selectDateFormater setDateFormat:format];
    NSString *selectDataString = [selectDateFormater stringFromDate:date];
    return selectDataString;
}
+ (NSDate*)bk_stringToDate:(NSString*)dateString format:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:format];
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

- (NSString *)bk_dateConvertionFormFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat {
    NSDate * date = [NSString bk_stringToDate:self format:fromFormat];
    NSString * string = [NSString bk_dateToString:date format:toFormat];
    return string;;
}

@end

@implementation NSString (Validate)

/* 非法字符验证 */
- (BOOL)bk_containsTheillegalCharacter{
    
    NSString *str = @"^[\\w\\u4E00-\\u9FA5\\uF900-\\uFA2D\\x00-\\xff,。，。？！：‘、-【】·！_——=:;；<>《》‘’“”!#~➋➌➍➎➏➐➑➒]*$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    return ![emailTest evaluateWithObject:self];
}
/* 邮箱验证 */
- (BOOL)bk_isEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/*手机号码验证 */
- (BOOL) bk_isPhoneNumber
{
    NSString *phoneRegex = @"^(1[0-9])\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}


/*汉字验证*/
-(BOOL)bk_isChinese
{
    NSString *emailRegex = @"(^[\u4e00-\u9fa5]{1,5}+$)";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/*人名验证*/
- (BOOL) bk_isPeopleName
{
    NSString * phoneRegex = @"[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
/*身份证验证*/
- (BOOL) bk_isIDCard{
    NSString * phoneRegex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
/*验证码校验 6位*/
- (BOOL) bk_isValidateCode
{
    NSString * phoneRegex = @"^\\d{6}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
/*密码校验 6-30位字母数字*/
- (BOOL) bk_isPassWord
{
    NSString * phoneRegex = @"^[a-zA-Z0-9]{6,30}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}


@end
