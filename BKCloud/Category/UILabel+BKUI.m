//
//  UILabel+BKUI.m
//  BKCloudAPI
//
//  Created by shuai ren on 2020/6/29.
//  Copyright © 2020 BKSX CN. All rights reserved.
//

#import "UILabel+BKUI.h"

@implementation UILabel (BKUI)

-(void)autolayoutContent:(NSString *)content
                  origin:(CGPoint)point
                    Font:(UIFont*)tfont
            contentWidth:(CGFloat)contentWidth
                LineSpac:(CGFloat)lineSpace
{
    NSString * tstring = content;
    self.numberOfLines = 0;
    self.font = tfont;
    self.text = tstring ;
    
    //给一个比较大的高度，宽度不变
    CGSize size = CGSizeMake(contentWidth , MAXFLOAT);
    //ios7方法，获取文本需要的size，限制宽度
    CGSize actualsize;
    if (lineSpace) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:lineSpace];
        NSMutableAttributedString *attributedStr01 = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil];
        actualsize = [tstring boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:tdic context:nil].size;
        self.attributedText = attributedStr01;
    }else{
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
        actualsize = [tstring boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    }
    
    self.frame =CGRectMake(point.x, point.y, actualsize.width, actualsize.height);
    
}

-(void)autolayoutContent:(NSString *)content
                  origin:(CGPoint)point
                    Font:(UIFont*)tfont
            contentWidth:(CGFloat)contentWidth
              attributes:(NSDictionary *)dic
{
    NSString * tstring = content;
    self.numberOfLines = 0;
    self.font = tfont;
    self.text = tstring ;
    //给一个比较大的高度，宽度不变
    CGSize size = CGSizeMake(contentWidth , MAXFLOAT);
    //ios7方法，获取文本需要的size，限制宽度
    CGSize actualsize;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f) {
        actualsize = [tstring boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    }
    
    /*
     NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
     paraStyle01.alignment = NSTextAlignmentJustified;  //对齐
     paraStyle01.headIndent = 0.0f;//行首缩进
     CGFloat emptylen = FontHeight(15) * 2;
     paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
     paraStyle01.tailIndent = 0.0f;//行尾缩进
     paraStyle01.lineSpacing = 2.0f;//行间距
     NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:FONT(15),NSFontAttributeName,paraStyle01,NSParagraphStyleAttributeName,nil];
     */
    
    
    if (dic[NSParagraphStyleAttributeName]) {
        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:content attributes:@{NSParagraphStyleAttributeName:dic[NSParagraphStyleAttributeName]}];
        self.attributedText = attrText;
    }
    
    self.frame =CGRectMake(point.x, point.y, contentWidth, actualsize.height);
    
}
/*
 NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
 paragraphStyle.lineSpacing = 10;// 字体的行间距
 paragraphStyle.firstLineHeadIndent = 20.0f;//首行缩进
 paragraphStyle.alignment = NSTextAlignmentJustified;//（两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）
 paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;//结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
 paragraphStyle.headIndent = 20;//整体缩进(首行除外)
 paragraphStyle.tailIndent = 20;//尾部缩进
 paragraphStyle.minimumLineHeight = 10;//最低行高
 paragraphStyle.maximumLineHeight = 20;//最大行高
 paragraphStyle.paragraphSpacing = 15;//段与段之间的间距
 paragraphStyle.paragraphSpacingBefore = 22.0f;//段首行空白空间
paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;//从左到右的书写方向（一共三种）
paragraphStyle.hyphenationFactor = 1;//连字属性 在iOS，唯一支持的值分别为0和1

*/


+(UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor{
    UILabel * label = [[UILabel alloc]init];
    label.font = font;
    label.textColor = textColor;
    return label;
}

@end
