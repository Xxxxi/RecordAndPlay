//
//  XxiLabel.m
//  BaseUI
//
//  Created by XXxxi on 2018/4/13.
//  Copyright © 2018年 Chomp. All rights reserved.
//

#import "XxiLabel.h"
typedef void(^LabelTouchBlock)(XxiLabel *Label);

@interface XxiLabel()
@property (nonatomic, copy) LabelTouchBlock tapBlock;
@end

@implementation XxiLabel
- (instancetype)init{
    self = [super init];
    self.clipsToBounds = YES;
    return self;
}

- (XxiLabel *)labFont:(UIFont *)font text:(id)text textAlignment:(NSTextAlignment)alignement{
    self.font = font ? font:self.font;
    if ([text isKindOfClass:[NSString class]]) {
        self.text = text ? text:@"";
    }else if ([text isKindOfClass:[NSAttributedString class]]){
        self.attributedText = text;
    }
    self.textAlignment = alignement;
    return self;
}

- (XxiLabel *)backgroundColor:(UIColor *)color textColor:(UIColor *)tColor{
    self.backgroundColor = color ? color:[UIColor clearColor];
    self.textColor = tColor ? tColor:[UIColor blackColor];
    return self;
}

- (XxiLabel *)layerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color{
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = width;
    self.layer.cornerRadius = radius;
    self.layer.borderColor = color ? color.CGColor:[UIColor clearColor].CGColor;
    return self;
}

- (XxiLabel *)labelTouchBlock:(void (^)(XxiLabel *label))callBack{
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

- (XxiLabel *)setAdjustsFontSizeToFitWidth{
    self.adjustsFontSizeToFitWidth = YES;
    return self;
}

- (XxiLabel *)shadowColor:(UIColor *)Color shadowOffset:(CGSize)offset shadowOpacity:(CGFloat)opacity shadowRadius:(CGFloat)radius{
    self.clipsToBounds = NO;
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = Color ? Color.CGColor:[UIColor clearColor].CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
    return self;
}

- (XxiLabel *(^)(UILayoutPriority priority))setVerticalCompressionResistancePriority{
    return ^XxiLabel *(UILayoutPriority priority){
        [self setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisVertical];
        return self;
    };
}

- (XxiLabel *(^)(UILayoutPriority priority))setHorizontalCompressionResistancePriority{
    return ^XxiLabel *(UILayoutPriority priority){
        [self setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        return self;
    };
}

- (XxiLabel *(^)(UILayoutPriority priority))setVerticalHuggingPriority{
    return ^XxiLabel *(UILayoutPriority priority){
        [self setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisVertical];
        return self;
    };
}

- (XxiLabel *(^)(UILayoutPriority priority))setHorizontalHuggingPriority{
    return ^XxiLabel *(UILayoutPriority priority){
        [self setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        return self;
    };
}

-(void)tapAction:(UITapGestureRecognizer *)tap{
    NSLog(@"XxiLabel被点击");
    if (self.tapBlock){
        self.tapBlock(self);
    }
}

@end
