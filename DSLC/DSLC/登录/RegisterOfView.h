//
//  RegisterView.h
//  DSLC
//
//  Created by 马成铭 on 15/10/28.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterOfView : UIView
@property (weak, nonatomic) IBOutlet UIButton *getCode;
@property (weak, nonatomic) IBOutlet UIButton *problemButton;
@property (weak, nonatomic) IBOutlet UITextField *sandMyselfIDCard;
@property (weak, nonatomic) IBOutlet UILabel *inviteNumber;
@property (weak, nonatomic) IBOutlet UITextField *smsCode;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *loginPassword;
@property (weak, nonatomic) IBOutlet UITextField *sureLoginPassword;

// 实名认证
@property (weak, nonatomic) IBOutlet UITextField *realName;
@property (weak, nonatomic) IBOutlet UITextField *IDCard;

// 绑定银行卡
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *bankName;
@property (weak, nonatomic) IBOutlet UITextField *bankCity;
@property (weak, nonatomic) IBOutlet UITextField *bankNumber;
@property (weak, nonatomic) IBOutlet UITextField *bankTelephone;
@property (weak, nonatomic) IBOutlet UITextField *bankSmsCode;


@end
