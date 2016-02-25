//
//  CastUpMonkeyTableViewCell.h
//  DSLC
//
//  Created by 马成铭 on 16/2/25.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CastUpMonkeyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productType;
@property (weak, nonatomic) IBOutlet UILabel *productNumber;
@property (weak, nonatomic) IBOutlet UILabel *productMoney;
@property (weak, nonatomic) IBOutlet UILabel *productMonkeyNumber;
@property (weak, nonatomic) IBOutlet UILabel *productProfit;
@property (weak, nonatomic) IBOutlet UILabel *productDate;
@end
