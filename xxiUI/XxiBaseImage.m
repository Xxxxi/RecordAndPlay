//
//  XxiBaseImage.m
//  BaseUI
//
//  Created by XXxxi on 2018/4/13.
//  Copyright © 2018年 Chomp. All rights reserved.
//

#import "XxiBaseImage.h"
typedef void(^ImageTouchBlock)(XxiBaseImage *imageView);

@interface XxiBaseImage()
@property (nonatomic, copy) ImageTouchBlock tapBlock;
@end

@implementation XxiBaseImage
- (instancetype)init{
    self = [super init];
    self.clipsToBounds = YES;
    return self;
}

//UIImageView * setIma(UIImage *ima){
//    return [imag]
//}

- (XxiBaseImage *)setIme:(UIImage *)image{
    self.image = image;
    return self;
}

- (XxiBaseImage *)backgroundColor:(UIColor *)color{
    self.backgroundColor = color;
    return self;
}

- (XxiBaseImage *)layerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color{
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = width;
    self.layer.cornerRadius = radius;
    self.layer.borderColor = color ? color.CGColor:[UIColor clearColor].CGColor;
    return self;
}

- (XxiBaseImage *)imageTouchedBlock:(void (^)(XxiBaseImage *imageView)) success{
    self.tapBlock = success;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    //轻拍次数
    tap.numberOfTapsRequired =1;
    //轻拍手指个数
    tap.numberOfTouchesRequired =1;
    //讲手势添加到指定的视图上
    [self addGestureRecognizer:tap];
    return self;
}

-(void)tapAction:(UITapGestureRecognizer *)tap{
    NSLog(@"XxiBaseImage被点击");
    if (self.tapBlock){
        self.tapBlock(self);
    }
}

- (imageContentModeBlock)setImagecontentMode{
    return ^XxiBaseImage *(UIViewContentMode mode){
        self.contentMode = mode;
        return self;
    };
}

- (XxiBaseImage *(^)(UILayoutPriority priority))setVerticalCompressionResistancePriority{
    return ^XxiBaseImage *(UILayoutPriority priority){
        [self setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisVertical];
        return self;
    };
}

- (XxiBaseImage *(^)(UILayoutPriority priority))setHorizontalCompressionResistancePriority{
    return ^XxiBaseImage *(UILayoutPriority priority){
        [self setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        return self;
    };
}

- (XxiBaseImage *(^)(UILayoutPriority priority))setVerticalHuggingPriority{
    return ^XxiBaseImage *(UILayoutPriority priority){
        [self setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisVertical];
        return self;
    };
}

- (XxiBaseImage *(^)(UILayoutPriority priority))setHorizontalHuggingPriority{
    return ^XxiBaseImage *(UILayoutPriority priority){
        [self setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        return self;
    };
}

@end
