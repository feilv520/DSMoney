//
//  TWOMessageModel.h
//  DSLC
//
//  Created by ios on 16/7/18.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWOMessageModel : NSObject

@property (nonatomic) NSString *ID;
@property (nonatomic) NSString *content;
@property (nonatomic) NSString *createTime;
@property (nonatomic) NSString *sendTime;
@property (nonatomic) NSString *status;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *cover;
@property (nonatomic) NSString *readNum;

@end
