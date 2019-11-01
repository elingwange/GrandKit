//
//  UILabelViewController.m
//  GrandKit
//
//  Created by Evan on 2019/11/1.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "UILabelViewController.h"

@interface UILabelViewController ()

@property (nonatomic, strong) UILabel *lbLimitedMultiLine;

@end

@implementation UILabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UILabel";
    
    float lineSpace = Size(5);
    
    _lbLimitedMultiLine = [[UILabel alloc] initWithFrame:CGRectMake(Size(16), 100, Width - Size(32), 0)];
    _lbLimitedMultiLine.numberOfLines = 0;
    _lbLimitedMultiLine.backgroundColor = [UIColor greenColor];
    _lbLimitedMultiLine.textColor = [UIColor blackColor];
    [self.view addSubview:_lbLimitedMultiLine];
    
    UIFont * font = [UIFont systemFontOfSize:Size(13)];
    NSString *str = @"文字高度超过三行，截取三行的高度，否则有多少显示多少.文字高度超过三行，截取三行的高度，否则有多少显示多少.文字高度超过三行，截取三行的高度，否则有多少显示多少";
    //获取文字内容的高度
    CGFloat textHeight = [self boundingRectWithWidth:Width - Size(32) withTextFont:font withLineSpacing:lineSpace text:str].height;

    //文字高度超过三行，截取三行的高度，否则有多少显示多少
    if (textHeight > font.lineHeight*2 + 2*lineSpace) {
        textHeight = font.lineHeight*2 + 2*lineSpace;
    }
    
    //设置label的富文本
    _lbLimitedMultiLine.attributedText = [self attributedStringFromStingWithFont:font withLineSpacing:lineSpace text:str];
    
}


/**
 *  根据文字内容动态计算UILabel宽高
 *  @param maxWidth label宽度
 *  @param font  字体
 *  @param lineSpacing  行间距
 *  @param text  内容
 */
- (CGSize)boundingRectWithWidth:(CGFloat)maxWidth
                   withTextFont:(UIFont *)font
                withLineSpacing:(CGFloat)lineSpacing
                           text:(NSString *)text{
    CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    //段落样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //设置行间距
    [paragraphStyle setLineSpacing:lineSpacing];
    //#warning 此处设置NSLineBreakByTruncatingTail会导致计算文字高度方法失效
    //    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    
    //计算文字尺寸
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    return size;
}

/**
 *  NSString转换成NSMutableAttributedString
 *  @param font  字体
 *  @param lineSpacing  行间距
 *  @param text  内容
 */
- (NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                withLineSpacing:(CGFloat)lineSpacing
                                                           text:(NSString *)text{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:font}];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail]; //截断方式，"abcd..."
    [attributedStr addAttribute:NSParagraphStyleAttributeName
                          value:paragraphStyle
                          range:NSMakeRange(0, [text length])];
    return attributedStr;
}


@end
