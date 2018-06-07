//
//  XxiBaseImage.h
//  BaseUI
//
//  Created by XXxxi on 2018/4/13.
//  Copyright © 2018年 Chomp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XxiBaseImage;
typedef XxiBaseImage *(^imageNorBlock)(id value);
typedef XxiBaseImage *(^imageContentModeBlock)(UIViewContentMode mode);
@interface XxiBaseImage : UIImageView
- (XxiBaseImage *)setIme:(UIImage *)image;
- (XxiBaseImage *)backgroundColor:(UIColor *)color;
- (XxiBaseImage *)layerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color;
- (XxiBaseImage *)imageTouchedBlock:(void (^)(XxiBaseImage *imageView)) success;
- (imageContentModeBlock)setImagecontentMode;
- (XxiBaseImage *(^)(UILayoutPriority priority))setVerticalCompressionResistancePriority;
- (XxiBaseImage *(^)(UILayoutPriority priority))setHorizontalCompressionResistancePriority;
- (XxiBaseImage *(^)(UILayoutPriority priority))setVerticalHuggingPriority;
- (XxiBaseImage *(^)(UILayoutPriority priority))setHorizontalHuggingPriority;

@end
