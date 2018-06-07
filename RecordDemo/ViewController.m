//
//  ViewController.m
//  RecordDemo
//
//  Created by XXxxi on 2018/6/6.
//  Copyright © 2018年 Chomp. All rights reserved.
//

#import "ViewController.h"
#import "XxiRecordView.h"

@interface ViewController ()
@property(nonatomic,strong)XxiRecordView *recordView;
@end

@implementation ViewController

#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark initUI
-(void)initUI{
    self.recordView = [[XxiRecordView alloc]initWithFrame:self.view.bounds];
    self.recordView.clickAction = ^(NSString *saveVoicePath) {
        NSLog(@"%@",saveVoicePath);
    };
    [self.view addSubview:self.recordView];
}


@end
