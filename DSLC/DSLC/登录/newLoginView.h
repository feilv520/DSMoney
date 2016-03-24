//
//  newLoginView.h
//  DSLC
//
//  Created by 马成铭 on 16/3/18.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newLoginView : UIView
@property (weak, nonatomic) IBOutlet UIButton *oneLogin;
@property (weak, nonatomic) IBOutlet UIButton *twoLogin;
@property (weak, nonatomic) IBOutlet UITextField *inviteNumber;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *ensureNumber;
@property (weak, nonatomic) IBOutlet UIButton *getEnsureNumber;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *inviteNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *ensureNumberLabel;
@property (weak, nonatomic) IBOutlet UIView *threeLineView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *selectLabel;

//two
@property (weak, nonatomic) IBOutlet UILabel *tPhoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *tPasswordNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mimaLabel;
@property (weak, nonatomic) IBOutlet UIImageView *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *forgetButton;
@property (weak, nonatomic) IBOutlet UIButton *xieyiButton;
@property (weak, nonatomic) IBOutlet UIButton *gouxuanButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
