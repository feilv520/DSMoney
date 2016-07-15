//
//  TWOMakeSureTableViewCell.h
//  DSLC
//
//  Created by 马成铭 on 16/5/11.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWOMakeSureTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *czButton;
@property (weak, nonatomic) IBOutlet UILabel *yqMoneyLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputMoneyTextField;
@property (weak, nonatomic) IBOutlet UIView *moneyView;

@end
