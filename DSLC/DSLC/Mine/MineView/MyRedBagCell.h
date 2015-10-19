//
//  MyRedBagCell.h
//  DSLC
//
//  Created by ios on 15/10/19.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRedBagCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewBottm;
@property (weak, nonatomic) IBOutlet UIView *viewDown;
@property (weak, nonatomic) IBOutlet UILabel *bigBag;
@property (weak, nonatomic) IBOutlet UILabel *validData;
@property (weak, nonatomic) IBOutlet UILabel *labelLine;
@property (weak, nonatomic) IBOutlet UILabel *yuanShu;
@property (weak, nonatomic) IBOutlet UILabel *labelUse;
@property (weak, nonatomic) IBOutlet UILabel *labelDeduction;
@property (weak, nonatomic) IBOutlet UILabel *labelLowest;
@property (weak, nonatomic) IBOutlet UILabel *labelMonth;
@property (weak, nonatomic) IBOutlet UILabel *labelDaYu;
@property (weak, nonatomic) IBOutlet UILabel *bottomLine;

@end
