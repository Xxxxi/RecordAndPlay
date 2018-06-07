//
//  XxiTextField.h
//  BaseUI
//
//  Created by XXxxi on 2018/4/13.
//  Copyright © 2018年 Chomp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XxiTextField : UITextField
- (XxiTextField *)labFont:(UIFont *)font text:(NSString *)text placeholder:(NSString *)placeholder;
- (XxiTextField *)backgroundColor:(UIColor *)color textColor:(UIColor *)tColor;
- (XxiTextField *)layerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color;
- (XxiTextField *(^)(UILayoutPriority priority))setVerticalCompressionResistancePriority;
- (XxiTextField *(^)(UILayoutPriority priority))setHorizontalCompressionResistancePriority;
- (XxiTextField *(^)(UILayoutPriority priority))setVerticalHuggingPriority;
- (XxiTextField *(^)(UILayoutPriority priority))setHorizontalHuggingPriority;

@end
