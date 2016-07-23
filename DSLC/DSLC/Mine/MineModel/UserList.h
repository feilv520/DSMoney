//
//  UserList.h
//  DSLC
//
//  Created by ios on 15/12/26.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserList : NSObject
@property (nonatomic) NSString *recUserName;
@property (nonatomic) NSString *sendUserName;
@property (nonatomic) NSString *sendTime;
@property (nonatomic) NSString *recUserId;
@property (nonatomic) NSString *sendUserId;
@property (nonatomic) NSString *msgText;
@property (nonatomic) NSString *recAvatarImg;
@property (nonatomic) NSString *sendAvatarImg;
@property (nonatomic) NSString *msgStatus;
@property (nonatomic) NSString *userAccount;
@end
