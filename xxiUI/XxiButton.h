//
//  XxiButton.h
//  BaseUI
//
//  Created by XXxxi on 2018/4/13.
//  Copyright © 2018年 Chomp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XxiButton : UIButton
- (XxiButton *)setTitle:(NSString *)tit font:(UIFont *)font;
- (XxiButton *)setBackImage:(UIImage *)image;
- (XxiButton *)setNorImage:(UIImage *)norIma hightIma:(UIImage *)hightIma;
- (XxiButton *)backgroundColor:(UIColor *)color textColor:(UIColor *)tColor;
- (XxiButton *)layerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color;
- (XxiButton *)setAdjustsFontSizeToFitWidth;
- (XxiButton *)setButContentHorizontalAlignment:(UIControlContentHorizontalAlignment) alignment;
- (XxiButton *)buttonTouchedBlock:(void (^)(XxiButton *button)) callBlack;
- (XxiButton *(^)(UILayoutPriority priority))setVerticalCompressionResistancePriority;
- (XxiButton *(^)(UILayoutPriority priority))setHorizontalCompressionResistancePriority;
- (XxiButton *(^)(UILayoutPriority priority))setVerticalHuggingPriority;
- (XxiButton *(^)(UILayoutPriority priority))setHorizontalHuggingPriority;

    
@property(nonatomic,assign)CGRect eventBounds;
@property(nonatomic,assign)CGFloat px; //用来增大按钮的触控范围
@end
