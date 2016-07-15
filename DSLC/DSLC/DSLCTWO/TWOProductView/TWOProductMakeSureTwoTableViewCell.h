//
//  TWOProductMakeSureTwoTableViewCell.h
//  DSLC
//
//  Created by 马成铭 on 16/5/12.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWOProductMakeSureTwoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *accountMoney;
@property (weak, nonatomic) IBOutlet UILabel *residueLabel;
@property (weak, nonatomic) IBOutlet UIButton *czButton;
@property (weak, nonatomic) IBOutlet UIButton *upMoneyButton;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UILabel *yqSLabel;
@property (weak, nonatomic) IBOutlet UIView *moneyView;

@end
