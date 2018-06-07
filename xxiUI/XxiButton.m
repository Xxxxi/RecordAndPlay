//
//  XxiButton.m
//  BaseUI
//
//  Created by XXxxi on 2018/4/13.
//  Copyright © 2018年 Chomp. All rights reserved.
//

#import "XxiButton.h"
typedef void(^buttonTouchBlock)(XxiButton *imageView);

@interface XxiButton()
@property (nonatomic, copy) buttonTouchBlock touchBlock;
@end

@implementation XxiButton

- (instancetype)init{
    self = [super init];
    self.clipsToBounds = YES;
    [self addTarget:self action:@selector(didTouchBut:) forControlEvents:UIControlEventTouchUpInside];
    return self;
}

+ (instancetype)buttonWithType:(UIButtonType)buttonType{
    XxiButton *button = [super buttonWithType:buttonType];
    button.clipsToBounds = YES;
    [button addTarget:button action:@selector(didTouchBut:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (XxiButton *)setTitle:(NSString *)tit font:(UIFont *)font{
    [self setTitle:tit forState:UIControlStateNormal];
    self.titleLabel.font = font;
    return self;
}

- (XxiButton *)setBackImage:(UIImage *)image{
    [self setBackgroundImage:image forState:UIControlStateNormal];
    return self;
}

- (XxiButton *)setNorImage:(UIImage *)norIma hightIma:(UIImage *)hightIma{
    [self setImage:norIma forState:UIControlStateNormal];
    [self setImage:hightIma forState:UIControlStateHighlighted];
    return self;
}

- (XxiButton *)backgroundColor:(UIColor *)color textColor:(UIColor *)tColor{
    self.backgroundColor = color ? color:[UIColor clearColor];
    [self setTitleColor:tColor ? tColor:[UIColor blackColor] forState:UIControlStateNormal];
    return self;
}

- (XxiButton *)layerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color{
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = width;
    self.layer.cornerRadius = radius;
    self.layer.borderColor = color ? color.CGColor:[UIColor clearColor].CGColor;
    return self;
}

- (XxiButton *)setAdjustsFontSizeToFitWidth{
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    return self;
}

- (XxiButton *)setButContentHorizontalAlignment:(UIControlContentHorizontalAlignment) alignment{
    self.contentHorizontalAlignment = alignment;
    return self;
}

- (XxiButton *)buttonTouchedBlock:(void (^)(XxiButton *button)) callBlack{
    self.touchBlock = callBlack;
    return self;
}

- (XxiButton *(^)(UILayoutPriority priority))setVerticalCompressionResistancePriority{
    return ^XxiButton *(UILayoutPriority priority){
        [self setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisVertical];
        return self;
    };
}

- (XxiButton *(^)(UILayoutPriority priority))setHorizontalCompressionResistancePriority{
    return ^XxiButton *(UILayoutPriority priority){
        [self setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        return self;
    };
}

- (XxiButton *(^)(UILayoutPriority priority))setVerticalHuggingPriority{
    return ^XxiButton *(UILayoutPriority priority){
        [self setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisVertical];
        return self;
    };
}

- (XxiButton *(^)(UILayoutPriority priority))setHorizontalHuggingPriority{
    return ^XxiButton *(UILayoutPriority priority){
        [self setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        return self;
    };
}

- (void)didTouchBut:(XxiButton *)sender{
    if (self.touchBlock) {
        self.touchBlock(sender);
    }
}

//设置按钮的触控范围
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect btnBounds = self.bounds;
    btnBounds = CGRectInset(btnBounds, -_px, -_px);
    return CGRectContainsPoint(btnBounds, point);
}


@end
