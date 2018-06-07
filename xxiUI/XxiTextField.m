//
//  XxiTextField.m
//  BaseUI
//
//  Created by XXxxi on 2018/4/13.
//  Copyright © 2018年 Chomp. All rights reserved.
//

#import "XxiTextField.h"

@implementation XxiTextField
- (instancetype)init{
    self = [super init];
    self.clipsToBounds = YES;
    return self;
}

- (XxiTextField *)labFont:(UIFont *)font text:(NSString *)text placeholder:(NSString *)placeholder{
    self.font = font;
    self.placeholder = placeholder;
    self.text = text;
    return self;
}

- (XxiTextField *)backgroundColor:(UIColor *)color textColor:(UIColor *)tColor{
    self.backgroundColor = color ? color:[UIColor clearColor];
    self.textColor = tColor ? tColor:[UIColor blackColor];
    return self;
}

- (XxiTextField *)layerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color{
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = width;
    self.layer.cornerRadius = radius;
    self.layer.borderColor = color ? color.CGColor:[UIColor clearColor].CGColor;
    return self;
}

- (XxiTextField *(^)(UILayoutPriority priority))setVerticalCompressionResistancePriority{
    return ^XxiTextField *(UILayoutPriority priority){
        [self setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisVertical];
        return self;
    };
}

- (XxiTextField *(^)(UILayoutPriority priority))setHorizontalCompressionResistancePriority{
    return ^XxiTextField *(UILayoutPriority priority){
        [self setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        return self;
    };
}

- (XxiTextField *(^)(UILayoutPriority priority))setVerticalHuggingPriority{
    return ^XxiTextField *(UILayoutPriority priority){
        [self setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisVertical];
        return self;
    };
}

- (XxiTextField *(^)(UILayoutPriority priority))setHorizontalHuggingPriority{
    return ^XxiTextField *(UILayoutPriority priority){
        [self setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        return self;
    };
}

@end
