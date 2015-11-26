//
//  MessageModel.h
//  DSLC
//
//  Created by 马成铭 on 15/11/26.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic, copy) NSString *msgID;
@property (nonatomic, copy) NSString *msgStatus;
@property (nonatomic, copy) NSString *msgStatusName;
@property (nonatomic, copy) NSString *msgText;
@property (nonatomic, copy) NSString *msgTextId;
@property (nonatomic, copy) NSString *msgTitle;
@property (nonatomic, copy) NSString *msgType;
@property (nonatomic, copy) NSString *msgTypeName;
@property (nonatomic, copy) NSString *recUserId;
@property (nonatomic, copy) NSString *recUserName;
@property (nonatomic, copy) NSString *sendTime;
@property (nonatomic, copy) NSString *sendUserId;
@property (nonatomic, copy) NSString *sendUserName;

@end
