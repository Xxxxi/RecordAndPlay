//
//  XxiTextView.m
//  BaseUI
//
//  Created by XXxxi on 2018/4/13.
//  Copyright © 2018年 Chomp. All rights reserved.
//
#define TColorFromRGB(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define systemAlerGaryColor TColorFromRGB(0xA8A8A8,1.0)
#import "XxiTextView.h"
#import "XxiLabel.h"

@interface XxiTextView()
@property (nonatomic, strong) XxiLabel *placeholderLab;
@end

@implementation XxiTextView
- (instancetype)init{
    self = [super init];
    self.clipsToBounds = YES;
    return self;
}

- (XxiTextView *)labFont:(UIFont *)font text:(NSString *)text placeholder:(NSString *)placeholder textAlignment:(NSTextAlignment)alignement{
    self.font = font;
    self.text = text;
    self.textAlignment = alignement;
    self.placeholderLab = [[[[XxiLabel alloc] init] labFont:font text:placeholder textAlignment:0] backgroundColor:nil textColor:systemAlerGaryColor];
    [self addSubview:self.placeholderLab];
    [self setValue:self.placeholderLab forKey:@"_placeholderLabel"];
    return self;
}

- (XxiTextView *)backgroundColor:(UIColor *)color textColor:(UIColor *)tColor tinColor:(UIColor *)tinColor{
    self.backgroundColor = color ? color:[UIColor clearColor];
    self.textColor = tColor ? tColor:[UIColor blackColor];
    self.tintColor = tinColor ? tinColor:self.tintColor;
    return self;
}

- (XxiTextView *)layerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color{
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = width;
    self.layer.cornerRadius = radius;
    self.layer.borderColor = color ? color.CGColor:[UIColor clearColor].CGColor;
    return self;
}

- (XxiTextView *(^)(BOOL enable))scroEnabled{
    return ^XxiTextView *(BOOL enable){
        self.scrollEnabled = enable;
        return self;
    };
}

- (XxiTextView *(^)(BOOL enable))selectEnabled{
    return ^XxiTextView *(BOOL enable){
        self.selectable = enable;
        self.editable = enable;
        return self;
    };
}

- (XxiTextView *(^)(UILayoutPriority priority))setVerticalCompressionResistancePriority{
    return ^XxiTextView *(UILayoutPriority priority){
        [self setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisVertical];
        return self;
    };
}

- (XxiTextView *(^)(UILayoutPriority priority))setHorizontalCompressionResistancePriority{
    return ^XxiTextView *(UILayoutPriority priority){
        [self setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        return self;
    };
}

- (XxiTextView *(^)(UILayoutPriority priority))setVerticalHuggingPriority{
    return ^XxiTextView *(UILayoutPriority priority){
        [self setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisVertical];
        return self;
    };
}

- (XxiTextView *(^)(UILayoutPriority priority))setHorizontalHuggingPriority{
    return ^XxiTextView *(UILayoutPriority priority){
        [self setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        return self;
    };
}

@end
