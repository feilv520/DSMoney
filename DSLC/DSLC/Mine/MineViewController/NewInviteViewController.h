//
//  NewInviteViewController.h
//  DSLC
//
//  Created by ios on 16/4/14.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "BaseViewController.h"

@interface NewInviteViewController : BaseViewController
@property (nonatomic) NSString *inviteCode;
@property (nonatomic) NSString *realName;
@property (nonatomic) NSString *phoneNum;
@property (nonatomic) BOOL nameOrPhone;
@end
