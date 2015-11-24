//
//  transactionModel.h
//  DSLC
//
//  Created by 马成铭 on 15/11/24.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTransactionModel : NSObject

@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *tradeId;
@property (nonatomic, copy) NSString *tradeMoney;
@property (nonatomic, copy) NSString *tradeProductName;
@property (nonatomic, copy) NSString *tradeProductType;
@property (nonatomic, copy) NSString *tradeStatus;
@property (nonatomic, copy) NSString *tradeTime;
@property (nonatomic, copy) NSString *tradeType;
@property (nonatomic, copy) NSString *tradeTypeName;

@end
