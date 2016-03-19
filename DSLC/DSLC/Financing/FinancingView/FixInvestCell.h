//
//  FixInvestCell.h
//  DSLC
//
//  Created by ios on 15/10/10.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FixInvestCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelMonth;
@property (weak, nonatomic) IBOutlet UILabel *labelBuyNum;
@property (weak, nonatomic) IBOutlet UIView *viewLine;
@property (weak, nonatomic) IBOutlet UILabel *labelPercentage;
@property (weak, nonatomic) IBOutlet UILabel *labelDayNum;
@property (weak, nonatomic) IBOutlet UILabel *labelIncome;
@property (weak, nonatomic) IBOutlet UILabel *labelDeadline;
@property (weak, nonatomic) IBOutlet UIView *viewDiSe;
@property (weak, nonatomic) IBOutlet UILabel *labelSurplus;
@property (weak, nonatomic) IBOutlet UILabel *labelLine;
@property (weak, nonatomic) IBOutlet UIButton *butCountDown;
@property (weak, nonatomic) IBOutlet UIButton *butTouZi;

@end
