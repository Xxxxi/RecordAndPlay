//
//  XxiView.m
//  BaseUI
//
//  Created by XXxxi on 2018/4/13.
//  Copyright © 2018年 Chomp. All rights reserved.
//

#import "XxiView.h"
typedef void(^ViewTouchBlock)(XxiView *Label);

@interface XxiView()
@property (nonatomic, copy) ViewTouchBlock tapBlock;
@end

@implementation XxiView
- (instancetype)init{
    self = [super init];
    self.clipsToBounds = YES;
    return self;
}

- (XxiView *)backgroundColor:(UIColor *)bColor{
    self.backgroundColor = bColor;
    return self;
}

- (XxiView *)layerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color{
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = width;
    self.layer.cornerRadius = radius;
    self.layer.borderColor = color ? color.CGColor:[UIColor clearColor].CGColor;
    return self;
}

- (XxiView *)shadowColor:(UIColor *)Color shadowOffset:(CGSize)offset shadowOpacity:(CGFloat)opacity shadowRadius:(CGFloat)radius{
    self.clipsToBounds = NO;
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = Color ? Color.CGColor:[UIColor clearColor].CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
    return self;
}

- (XxiView *)viewTouchBlock:(void (^)(XxiView *view))callBack{
    self.tapBlock = callBack;
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

- (XxiView *(^)(UILayoutPriority priority))setVerticalCompressionResistancePriority{
    return ^XxiView *(UILayoutPriority priority){
        [self setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisVertical];
        return self;
    };
}

- (XxiView *(^)(UILayoutPriority priority))setHorizontalCompressionResistancePriority{
    return ^XxiView *(UILayoutPriority priority){
        [self setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        return self;
    };
}

- (XxiView *(^)(UILayoutPriority priority))setVerticalHuggingPriority{
    return ^XxiView *(UILayoutPriority priority){
        [self setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisVertical];
        return self;
    };
}

- (XxiView *(^)(UILayoutPriority priority))setHorizontalHuggingPriority{
    return ^XxiView *(UILayoutPriority priority){
        [self setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        return self;
    };
}

-(void)tapAction:(UITapGestureRecognizer *)tap{
    NSLog(@"XxiView被点击");
    if (self.tapBlock){
        self.tapBlock(self);
    }
}

@end
