//
//  MBProgressHUD+NJ.h
//  NJWisdomCard
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 Weconex. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (NJ)

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;
+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUD;

+ (void)hideHUDS;

+ (void)hideHUD:(void (^)(void))hidden;

+ (void)hideHUDForView:(UIView *)view;

@end
