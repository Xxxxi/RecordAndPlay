//
//  XxiLabel.h
//  BaseUI
//
//  Created by XXxxi on 2018/4/13.
//  Copyright © 2018年 Chomp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XxiLabel : UILabel
- (XxiLabel *)labFont:(UIFont *)font text:(id)text textAlignment:(NSTextAlignment)alignement;
- (XxiLabel *)backgroundColor:(UIColor *)color textColor:(UIColor *)tColor;
- (XxiLabel *)layerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color;
- (XxiLabel *)shadowColor:(UIColor *)Color shadowOffset:(CGSize)offset shadowOpacity:(CGFloat)opacity shadowRadius:(CGFloat)radius;
- (XxiLabel *)labelTouchBlock:(void (^)(XxiLabel *label))callBack;
- (XxiLabel *)setAdjustsFontSizeToFitWidth;
- (XxiLabel *(^)(UILayoutPriority priority))setVerticalCompressionResistancePriority;//也就是视图的“内容压缩阻力优先级”越大，那么该视图中的内容越难被压缩
- (XxiLabel *(^)(UILayoutPriority priority))setHorizontalCompressionResistancePriority;
- (XxiLabel *(^)(UILayoutPriority priority))setVerticalHuggingPriority;//谁的“内容拥抱优先级”高，谁就优先环绕其内容
- (XxiLabel *(^)(UILayoutPriority priority))setHorizontalHuggingPriority;
@end
