//
//  TWOProfitGettingCell.h
//  DSLC
//
//  Created by ios on 16/5/10.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWOProfitGettingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UILabel *labelTouZiMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelProfit;
@property (weak, nonatomic) IBOutlet UILabel *labelTouZi;
@property (weak, nonatomic) IBOutlet UILabel *labelShouYi;
@property (weak, nonatomic) IBOutlet UIView *viewLineS;
@property (weak, nonatomic) IBOutlet UIImageView *imageCash;

@end
