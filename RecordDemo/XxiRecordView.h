//
//  XxiRecordView.h
//  VoiceUI
//
//  Created by XXxxi on 2018/6/5.
//  Copyright © 2018年 Chomp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "XxiLabel.h"
#import "XxiButton.h"
#import "XxiView.h"
#import "XxiBaseImage.h"
#import <AVFoundation/AVFoundation.h>

#define checkAdapt      [UIScreen mainScreen].bounds.size.width /750
#define WhiteColor      [UIColor whiteColor]
#define blackColor      [UIColor blackColor]
#define BlueColor       [UIColor blueColor]
#define alphaColor      [blackColor colorWithAlphaComponent:0.35]
#define ScreenW         [UIScreen mainScreen].bounds.size.width
#define xxiImg(img)     [UIImage imageNamed:img]
#define SOUND_RECORD_LIMIT 60
#define DocumentPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define IOS_VERSION             ([[[UIDevice currentDevice] systemVersion] integerValue])
#define IOS10_OR_LATER          ( IOS_VERSION >=10 )

//保存音频播放链接
typedef void(^SureAction)(NSString *saveVoicePath);

@interface XxiRecordView : UIView

@property(nonatomic,strong)XxiView *alertView,*blueSquare;
@property(nonatomic,strong)XxiLabel *tipsLbl,*voiceSecond;
@property(nonatomic,strong)UIButton *voiceBtn;
@property(nonatomic,strong)XxiBaseImage *volumeImg;
@property(nonatomic,strong)XxiButton *broadCaseBtn,*saveBtn,*deleteBtn;
@property(nonatomic,strong)XxiBaseImage *broadAnimation; //声音播放动画图片
@property(nonatomic ,copy) SureAction clickAction; //// 点击保存确认回调

-(instancetype)initWithFrame:(CGRect)frame;


@end
