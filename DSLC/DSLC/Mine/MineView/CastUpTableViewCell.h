//
//  CastUpTableViewCell.h
//  DSLC
//
//  Created by 马成铭 on 15/10/19.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CastUpTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productType;
@property (weak, nonatomic) IBOutlet UILabel *productNumber;
@property (weak, nonatomic) IBOutlet UILabel *productMoney;
@property (weak, nonatomic) IBOutlet UILabel *productProfit;
@property (weak, nonatomic) IBOutlet UILabel *productDate;

@end
