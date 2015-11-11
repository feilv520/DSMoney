//
//  ProductMoneyTableViewCell.h
//  DSLC
//
//  Created by 马成铭 on 15/11/10.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductMoneyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIView *BackView;

@end
