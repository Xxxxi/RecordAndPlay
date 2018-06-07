//
//  XxiRecordView.m
//  VoiceUI
//
//  Created by XXxxi on 2018/6/5.
//  Copyright © 2018年 Chomp. All rights reserved.
//

#import "XxiRecordView.h"
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"
#import "MBProgressHUD+NJ.h"

@interface XxiRecordView()<AVAudioSessionDelegate,AVAudioPlayerDelegate,AVAudioRecorderDelegate>
{
    NSTimer *_noiseTimer; //声音分贝定时器
    NSInteger countDown;  //倒计时
}

@property(nonatomic,strong)AVAudioPlayer *player;  //播放器
@property(nonatomic,strong)AVAudioRecorder *recorder; //录音
@property(nonatomic,strong)NSURL *recordUrl; //录音文件路径
@property(nonatomic,copy)NSString *fileUrl; //存储路径
@end

@implementation XxiRecordView

#pragma mark init
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = alphaColor;
        self.frame = frame;
        [self createUI];
    }
    return self;
}

#pragma mark createUI
-(void)createUI{
    
    self.alertView = [[[[XxiView alloc]init] backgroundColor:WhiteColor] layerRadius:20*checkAdapt borderWidth:0 borderColor:WhiteColor];
    [self addSubview:self.alertView];
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.height.mas_equalTo(ScreenW-180*checkAdapt);
    }];
    
    self.tipsLbl = [[[XxiLabel alloc]init] labFont:[UIFont systemFontOfSize:30*checkAdapt] text:@"长按话筒图标进行录音" textAlignment:0];
    [self.tipsLbl setTextColor:blackColor];
    [self.alertView addSubview:self.tipsLbl];
    [self.tipsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.alertView);
        make.top.mas_equalTo(self.alertView.mas_top).offset(20*checkAdapt);
    }];
    
    //录音按钮
    self.voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.voiceBtn setImage:xxiImg(@"录音按钮") forState:UIControlStateNormal];
    [self.voiceBtn setImage:xxiImg(@"录音按钮按下") forState:UIControlStateHighlighted];
    [self.alertView addSubview:self.voiceBtn];
    [self.voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.alertView);
        make.top.mas_equalTo(self.tipsLbl.mas_bottom).offset(44*checkAdapt);
        make.width.height.mas_equalTo(192*checkAdapt);
    }];
    
    //按钮按下-->录音
    [self.voiceBtn addTarget:self action:@selector(startRecordVoice) forControlEvents:UIControlEventTouchDown];
    //先按下然后拖动到控件之外
    [self.voiceBtn addTarget:self action:@selector(confirmRecordVoice) forControlEvents:UIControlEventTouchUpOutside];
    //控件范围内抬起，前提先得按下
    [self.voiceBtn addTarget:self action:@selector(confirmRecordVoice) forControlEvents:UIControlEventTouchUpInside];
    //拖动动作中，从控件边界内到外时产生的事件。
    [self.voiceBtn addTarget:self action:@selector(confirmRecordVoice) forControlEvents:UIControlEventTouchDragExit];
    //指拖动动作中，从控件边界外到内时产生的事件。
    [self.voiceBtn addTarget:self action:@selector(confirmRecordVoice) forControlEvents:(UIControlEventTouchDragEnter)];
    
    self.volumeImg = [[XxiBaseImage alloc]initWithImage:xxiImg(@"")];
    [self.alertView addSubview:self.volumeImg];
    [self.volumeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.voiceBtn);
        make.left.mas_equalTo(self.voiceBtn.mas_right).offset(30*checkAdapt);
        make.width.height.mas_equalTo(60*checkAdapt);
    }];
    
    
    
    __weak typeof(self)weakSelf = self;
    
    self.broadCaseBtn = [[[[XxiButton alloc]init] setNorImage:xxiImg(@"录音播放背景") hightIma:xxiImg(@"录音播放背景")]  buttonTouchedBlock:^(XxiButton *button) {
       
        NSData *fileData = [NSData dataWithContentsOfFile:weakSelf.fileUrl];
        if(fileData.length){
             NSLog(@"播放ing");
            [self.broadAnimation startAnimating];  //开始声波动画
            [self.recorder stop];

            if([self.player isPlaying]) return ;
            self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordUrl error:nil];
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
            self.player.delegate = self  ;
            [self.player play];
        }else{
            [MBProgressHUD showError:@"没有录音文件"];
        }
    }];
    [self.alertView addSubview:self.broadCaseBtn];
    [self.broadCaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.alertView);
        make.top.mas_equalTo(self.voiceBtn.mas_bottom).offset(30*checkAdapt);
        make.width.mas_equalTo(188*checkAdapt);
        make.height.mas_equalTo(68*checkAdapt);
    }];
    
    self.broadAnimation  = [[[XxiBaseImage alloc]init] setIme:xxiImg(@"声波3")];
    self.broadAnimation.highlightedAnimationImages = @[xxiImg(@"声波1"),xxiImg(@"声波2"),xxiImg(@"声波3")];
    self.broadAnimation.animationImages = @[xxiImg(@"声波1"),xxiImg(@"声波2"),xxiImg(@"声波3")];
    self.broadAnimation.animationDuration = 1.5f;
    self.broadAnimation.animationRepeatCount = NSUIntegerMax;
    [self.broadCaseBtn  addSubview:self.broadAnimation];
    [self.broadAnimation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.broadCaseBtn);
        make.width.mas_equalTo(40*checkAdapt);
        make.height.mas_equalTo(36*checkAdapt);
        make.left.mas_equalTo(self.broadCaseBtn).offset(36*checkAdapt);
    }];
    
    self.voiceSecond = [[[XxiLabel alloc]init] labFont:[UIFont systemFontOfSize:30*checkAdapt] text:@"" textAlignment:0];
    [self.voiceSecond setTextColor:blackColor];
    [self.broadCaseBtn addSubview:self.voiceSecond];
    [self.voiceSecond mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.broadCaseBtn);
        make.left.mas_equalTo(self.broadAnimation.mas_right).offset(20*checkAdapt);
    }];
    
    self.saveBtn = [[[[[XxiButton alloc]init] setTitle:@"保存" font:[UIFont systemFontOfSize:30*checkAdapt]] backgroundColor:WhiteColor textColor:blackColor] buttonTouchedBlock:^(XxiButton *button) {
        NSLog(@"save");
        [weakSelf animationHideView];
        //返回主线程
        dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, 0.5*NSEC_PER_SEC);
        dispatch_after(delay, dispatch_get_main_queue(), ^{
            self.clickAction(self.fileUrl);  //将存储路径回调出去
        });
    }];
    
    [self.alertView addSubview:self.saveBtn];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.alertView).offset(120*checkAdapt);
        make.bottom.mas_equalTo(self.alertView).offset(-40*checkAdapt);
        make.width.mas_equalTo(100*checkAdapt);
        make.height.mas_equalTo(40*checkAdapt);
    }];
    
    self.deleteBtn = [[[[[XxiButton alloc]init] setTitle:@"删除" font:[UIFont systemFontOfSize:30*checkAdapt]] backgroundColor:WhiteColor textColor:blackColor] buttonTouchedBlock:^(XxiButton *button) {
        //这里删除了整个文件夹里面的内容，也可以通过具体的链接删除特定的数据
        NSLog(@"delete");
        NSError *error ;
        if ([[NSFileManager defaultManager] removeItemAtPath:[self recordPathByGroupName:@"xxi"] error:&error]) {
            if (!error) {
                NSLog(@"删除音频成功") ;
                [self animationHideView];
            }else{
                NSLog(@"Error = %@",error.description);
            }
        }
    }];
    [self.alertView addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.alertView).offset(-120*checkAdapt);
        make.bottom.mas_equalTo(self.alertView).offset(-40*checkAdapt);
        make.width.mas_equalTo(100*checkAdapt);
        make.height.mas_equalTo(40*checkAdapt);
    }];
}

#pragma mark init AudioSession
-(void)initRecord{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if(session  == nil){
        NSLog(@"Error creating session: %@",[sessionError description]);
    }else{
        [session setActive:YES error:nil];
    }
}

#pragma mark 存放录音文件夹的沙盒路径
-(NSString *)recordPathByGroupName:(NSString *)groupName{
    NSString *filePath = [DocumentPath stringByAppendingPathComponent:groupName];  //stringByAppendingString
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:&error];
        if(!error){
            NSLog(@"创建路径error%@",error);
        }else{
            NSLog(@"创建路径成功 存放录音路径的文件夹path为%@",filePath);
        }
    }else{
        NSLog(@"该路径已经存在了");
    }
    return  filePath;
}

#pragma mark 录音设置
-(NSDictionary *)recordSetting{
    NSMutableDictionary *recordSetting =[NSMutableDictionary dictionaryWithCapacity:10];
    [recordSetting setObject:[NSNumber numberWithInt: kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    //2 采样率
    [recordSetting setObject:[NSNumber numberWithFloat:32000.0] forKey: AVSampleRateKey];
    //3 通道的数目
    [recordSetting setObject:[NSNumber numberWithInt:1]forKey:AVNumberOfChannelsKey];
    //4 采样位数  默认 16
    [recordSetting setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    return recordSetting;
}

#pragma mark BtnClick
-(void)startRecordVoice{
    self.volumeImg.hidden = NO;
    countDown = 60;
    [self initRecord];
    //1.设置文件保存路径和名称
    NSString *groupName = [self recordPathByGroupName:@"xxi"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HHmmss"];
    NSDate *dateNow = [NSDate date];
    NSString *fileName = [[formatter stringFromDate:dateNow] stringByAppendingString:@".wav"]; //苹果手机的录音后缀
    //完整的沙盒路径
    self.fileUrl = [groupName stringByAppendingString:[NSString stringWithFormat:@"/%@",fileName]];
    NSLog(@"path == %@",self.fileUrl);
    
    //2.设置recorder播放路径
    self.recordUrl = [NSURL URLWithString:self.fileUrl];
    _recorder = [[AVAudioRecorder alloc]initWithURL:self.recordUrl settings:[self recordSetting] error:nil];
    
    if (_recorder) {
        
        _recorder.meteringEnabled = YES;
        [_recorder prepareToRecord];
        [_recorder record];
        
        
        //声音分贝定时器
        if(_noiseTimer){
            [_noiseTimer invalidate];
            _noiseTimer = nil;
        }else {
            //启动判断声音分贝的定时器
            _noiseTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(checkNoiseLevel:) userInfo:nil repeats:YES];
            //加入线程中
            [[NSRunLoop currentRunLoop] addTimer:_noiseTimer forMode:NSRunLoopCommonModes];
            //启动定时器
            [_noiseTimer fire];
        }
        
    }else{
        NSLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");
    }
}

//取消录音
-(void)confirmRecordVoice{
    NSLog(@"停止录音");
    
    if(_noiseTimer){
        [_noiseTimer invalidate];
        _noiseTimer = nil;
    }
    
    if([self.recorder isRecording]){
        [self.recorder stop];
    }
    
    //获取录音时间
    NSFileManager *manager = [NSFileManager defaultManager];
    if([manager fileExistsAtPath:self.fileUrl]){
        NSData *fileData = [NSData dataWithContentsOfFile:self.fileUrl];
        NSLog(@"fielPath ---  %@,datalength --- %li-- recordSecond %@s",self.fileUrl,(unsigned long)[fileData length],[self returnSoundLengthByVoicePath:self.fileUrl]);
        self.voiceSecond.text = [NSString stringWithFormat:@"%@s",[self returnSoundLengthByVoicePath:self.fileUrl]];
        self.volumeImg.hidden = YES;
    }
}

//隐藏视图以及添加动画
-(void)animationHideView{
    [UIView animateWithDuration:1.0 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark 通过文件路径计算录音文件的时长
-(NSString *)returnSoundLengthByVoicePath:(NSString *)file{
    // 通过文件 获取此音频文件的时间长度
    NSURL *audioFileURL = [NSURL fileURLWithPath:file] ;
    AVURLAsset*audioAsset=[AVURLAsset URLAssetWithURL:audioFileURL options:nil];
    // > 0.4 进 1
    CMTime audioDuration=audioAsset.duration;
    float audioDurationSeconds=CMTimeGetSeconds(audioDuration);
    // 音频时长
    if (audioDurationSeconds <1.0) {
        audioDurationSeconds = 1.0 ;
    }
    int result;
    result = (int)roundf(audioDurationSeconds);
    NSString *soundTime = [NSString stringWithFormat:@"%d",(int)result] ;
    if ([soundTime isEqualToString:@"0"]) {
        soundTime = @"1" ;
    }
    return soundTime;
}

#pragma mark AVAudioPlayerDelegate
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"播放完成");
    [self.broadAnimation stopAnimating];
}

#pragma mark 检查声音分贝大小
-(void)checkNoiseLevel:(NSTimer *)timer{
    if (self.recorder) {
        [self.recorder updateMeters];
        double ff = [self.recorder averagePowerForChannel:0];
        ff = ff+60;
        if (ff>0&&ff<=14) {
            self.volumeImg.image = [UIImage imageNamed:@"音量1"];
        } else if (ff>14 && ff<28) {
            self.volumeImg.image = [UIImage imageNamed:@"音量2"];
        } else if (ff >=28 &&ff<42) {
            self.volumeImg.image = [UIImage imageNamed:@"音量3"];
        } else if (ff >=42 &&ff<56) {
            self.volumeImg.image = [UIImage imageNamed:@"音量4"];
        } else {
            self.volumeImg.image = [UIImage imageNamed:@"音量5"];
        }
    }
}


#if 0
#pragma mark hideView
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (!CGRectContainsPoint(self.alertView.frame, point)) {
        [self removeFromSuperview];
    }
}

#endif


@end
