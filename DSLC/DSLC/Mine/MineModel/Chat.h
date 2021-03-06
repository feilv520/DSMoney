//
//  Chat.h
//  DSLC
//
//  Created by ios on 15/11/26.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Chat : NSObject

@property (nonatomic) NSString *msgText;
@property (nonatomic) NSString *sendTime;
@property (nonatomic) NSNumber *sendUserId;
@property (nonatomic, copy) NSString *sendAvatarImg;
@property (nonatomic) NSNumber *recUserId;
@property (nonatomic) NSString *recAvatarImg;
@end
