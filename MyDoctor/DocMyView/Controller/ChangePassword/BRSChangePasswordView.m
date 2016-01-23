//
//  BRSChangePasswordView.m
//  BRSClient
//
//  Created by 张昊辰 on 15/3/17.
//  Copyright (c) 2015年 minxing. All rights reserved.
//

#import "BRSChangePasswordView.h"
#import "BRSChangePasswordViewController.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"
#import "MDConst.h"

@implementation BRSChangePasswordView
{
    UIView *passwordView;
    UITextField *passwordTF;
    UIImageView *passwordImage;
    
    UIView *newPasswordView;
    UITextField *newPasswordTF;
    UIImageView *newPasswordImage;
    
    UIView *againPasswordView;
    UITextField *againPasswordTF;
    UIImageView *againPasswordImage;
    
    UIButton * finishButton;
}

@synthesize controller;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        passwordView = [[UIView alloc]init];
        passwordView.backgroundColor =[UIColor whiteColor];
        [self addSubview:passwordView];
        
        [passwordView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(0);
            make.top.equalTo(self.mas_top).with.offset(75);
            make.size.mas_equalTo(CGSizeMake(appWidth, 44));
        }];
        UIImageView *lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mx_tabLine_phone"]];
        lineView.frame = CGRectMake(10, 43, appWidth-10, 1);
        [passwordView addSubview:lineView];
        
        passwordTF = [[UITextField alloc] init];
        passwordTF.placeholder = @"请输入旧密码";
        [passwordTF setValue:[UIFont boldSystemFontOfSize:15*(appWidth>320?appWidth/320:1)] forKeyPath:@"_placeholderLabel.font"];
        passwordTF.keyboardType = UIKeyboardTypeDefault;
        passwordTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        passwordTF.font = [UIFont systemFontOfSize:17.0f];
        passwordTF.secureTextEntry = YES;
        passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        passwordTF.leftViewMode = UITextFieldViewModeWhileEditing;
        passwordTF.returnKeyType = UIReturnKeyDone;
        passwordTF.backgroundColor =[UIColor clearColor];
        [passwordView addSubview:passwordTF];
        [passwordTF mas_makeConstraints:^(MX_MASConstraintMaker *make) {
            make.left.equalTo(passwordView.mas_left).with.offset(40);
            make.top.equalTo(passwordView.mas_top).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(appWidth-60, 44));
        }];
        
        passwordImage = [[UIImageView alloc]init];
        [passwordImage setImage:[UIImage imageNamed:@"mx_passwordImage_phone"]];
        [passwordView addSubview:passwordImage];
        [passwordImage mas_makeConstraints:^(MX_MASConstraintMaker *make) {
            make.left.equalTo(passwordView.mas_left).with.offset(10);
            make.top.equalTo(passwordView.mas_top).with.offset(12);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        newPasswordView = [[UIView alloc]init];
        newPasswordView.backgroundColor =[UIColor whiteColor];
        [self addSubview:newPasswordView];
        [newPasswordView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(0);
            make.top.equalTo(self.mas_top).with.offset(119);
            make.size.mas_equalTo(CGSizeMake(appWidth, 44));
        }];
        
        UIImageView *newLineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mx_tabLine_phone"]];
        newLineView.frame = CGRectMake(10, 43, appWidth-10, 1);
        [newPasswordView addSubview:newLineView];
        
        newPasswordTF = [[UITextField alloc] init];
        newPasswordTF.placeholder = @"请输入新密码";
        //        passwordTF.delegate = self;
        newPasswordTF.keyboardType = UIKeyboardTypeDefault;
        [newPasswordTF setValue:[UIFont boldSystemFontOfSize:15*(appWidth>320?appWidth/320:1)] forKeyPath:@"_placeholderLabel.font"];

        newPasswordTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        newPasswordTF.font = [UIFont systemFontOfSize:17.0f];
        newPasswordTF.secureTextEntry = YES;
        newPasswordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        newPasswordTF.leftViewMode = UITextFieldViewModeWhileEditing;
        newPasswordTF.returnKeyType = UIReturnKeyDone;
        newPasswordTF.backgroundColor =[UIColor clearColor];
        [newPasswordView addSubview:newPasswordTF];
        [newPasswordTF mas_makeConstraints:^(MX_MASConstraintMaker *make) {
            make.left.equalTo(newPasswordView.mas_left).with.offset(40);
            make.top.equalTo(newPasswordView.mas_top).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(appWidth-60, 44));
        }];
        passwordImage = [[UIImageView alloc]init];
        [passwordImage setImage:[UIImage imageNamed:@"mx_passwordImage_phone"]];
        [newPasswordView addSubview:passwordImage];
        [passwordImage mas_makeConstraints:^(MX_MASConstraintMaker *make) {
            make.left.equalTo(newPasswordView.mas_left).with.offset(10);
            make.top.equalTo(newPasswordView.mas_top).with.offset(12);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        againPasswordView = [[UIView alloc]init];
        againPasswordView.backgroundColor =[UIColor whiteColor];
        [self addSubview:againPasswordView];
        [againPasswordView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(0);
            make.top.equalTo(self.mas_top).with.offset(163);
            make.size.mas_equalTo(CGSizeMake(appWidth, 44));
        }];
        UIImageView *againLineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mx_tabLine_phone"]];
        againLineView.frame = CGRectMake(10, 43, appWidth-10, 1);
        [againPasswordView addSubview:againLineView];
        
        againPasswordTF = [[UITextField alloc] init];
        againPasswordTF.placeholder = @"请再次输入新密码";
        //        passwordTF.delegate = self;
        againPasswordTF.keyboardType = UIKeyboardTypeDefault;
        againPasswordTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        againPasswordTF.font = [UIFont systemFontOfSize:17.0f];
        againPasswordTF.secureTextEntry = YES;
        [againPasswordTF setValue:[UIFont boldSystemFontOfSize:15*(appWidth>320?appWidth/320:1)] forKeyPath:@"_placeholderLabel.font"];
        againPasswordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        againPasswordTF.leftViewMode = UITextFieldViewModeWhileEditing;
        againPasswordTF.returnKeyType = UIReturnKeyDone;
        againPasswordTF.backgroundColor =[UIColor clearColor];
        [againPasswordView addSubview:againPasswordTF];
        [againPasswordTF mas_makeConstraints:^(MX_MASConstraintMaker *make) {
            make.left.equalTo(againPasswordView.mas_left).with.offset(40);
            make.top.equalTo(againPasswordView.mas_top).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(appWidth-60, 44));
        }];
        passwordImage = [[UIImageView alloc]init];
        [passwordImage setImage:[UIImage imageNamed:@"mx_passwordImage_phone"]];
        [againPasswordView addSubview:passwordImage];
        [passwordImage mas_makeConstraints:^(MX_MASConstraintMaker *make) {
            make.left.equalTo(againPasswordView.mas_left).with.offset(10);
            make.top.equalTo(againPasswordView.mas_top).with.offset(12);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [finishButton addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
        finishButton.layer.cornerRadius = 8;
        finishButton.layer.masksToBounds = YES;
        
        finishButton.backgroundColor = RedColor;
        [finishButton setTitle:@"完成" forState:UIControlStateNormal];
        [self addSubview:finishButton];
        [finishButton mas_makeConstraints:^(MX_MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(10);
            make.right.equalTo(self.mas_right).with.offset(-10);
            make.top.equalTo(self.mas_top).with.offset(235);
            make.size.mas_equalTo(CGSizeMake(appWidth-20, 44));
        }];
    }
    return self;
}
-(void)finish{
    if (passwordTF.text.length!=0) {
        if ([newPasswordTF.text isEqualToString:againPasswordTF.text] &&newPasswordTF.text.length!=0) {
//            finishButton.enabled = NO;
            
            [self.controller doChange:passwordTF.text andNewPassword:newPasswordTF.text];
            
        }else{
            
            if (newPasswordTF.text.length!=0 && againPasswordTF.text.length!=0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"新密码两次输入不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }else{
                if (newPasswordTF.text.length==0) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入新密码" delegate:nil cancelButtonTitle:@"确定"  otherButtonTitles:nil, nil];
                    [alert show];
                }else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入确认密码" delegate:nil cancelButtonTitle:@"确定"  otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"旧密码输入不正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(void)cleanTF{
    return;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
-(void)changeFinishButtonEnabled:(BOOL)enabled{
    finishButton.enabled = enabled;
}


@end
