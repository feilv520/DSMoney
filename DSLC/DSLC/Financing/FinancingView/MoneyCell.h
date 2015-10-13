//
//  MoneyCell.h
//  DSLC
//
//  Created by ios on 15/10/13.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoneyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelMoney;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *viewLine1;
@property (weak, nonatomic) IBOutlet UILabel *labelShouRu;
@property (weak, nonatomic) IBOutlet UILabel *labelYuan;
@property (weak, nonatomic) IBOutlet UILabel *labelOneZi;

@end
