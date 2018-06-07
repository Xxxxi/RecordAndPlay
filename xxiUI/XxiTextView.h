//
//  XxiTextView.h
//  BaseUI
//
//  Created by XXxxi on 2018/4/13.
//  Copyright © 2018年 Chomp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XxiTextView : UITextView
- (XxiTextView *)labFont:(UIFont *)font text:(NSString *)text placeholder:(NSString *)placeholder textAlignment:(NSTextAlignment)alignement;
- (XxiTextView *)backgroundColor:(UIColor *)color textColor:(UIColor *)tColor tinColor:(UIColor *)tinColor;
- (XxiTextView *)layerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color;
- (XxiTextView *(^)(BOOL enable))scroEnabled;
- (XxiTextView *(^)(BOOL enable))selectEnabled;
- (XxiTextView *(^)(UILayoutPriority priority))setVerticalCompressionResistancePriority;
- (XxiTextView *(^)(UILayoutPriority priority))setHorizontalCompressionResistancePriority;
- (XxiTextView *(^)(UILayoutPriority priority))setVerticalHuggingPriority;
- (XxiTextView *(^)(UILayoutPriority priority))setHorizontalHuggingPriority;

@end
