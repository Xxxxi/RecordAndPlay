//
//  XxiView.h
//  BaseUI
//
//  Created by XXxxi on 2018/4/13.
//  Copyright © 2018年 Chomp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XxiView : UIView
- (XxiView *)backgroundColor:(UIColor *)bColor;
- (XxiView *)layerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color;
- (XxiView *)shadowColor:(UIColor *)Color shadowOffset:(CGSize)offset shadowOpacity:(CGFloat)opacity shadowRadius:(CGFloat)radius;
- (XxiView *)viewTouchBlock:(void (^)(XxiView *view))callBack;
- (XxiView *(^)(UILayoutPriority priority))setVerticalCompressionResistancePriority;
- (XxiView *(^)(UILayoutPriority priority))setHorizontalCompressionResistancePriority;
- (XxiView *(^)(UILayoutPriority priority))setVerticalHuggingPriority;
- (XxiView *(^)(UILayoutPriority priority))setHorizontalHuggingPriority;

@end
