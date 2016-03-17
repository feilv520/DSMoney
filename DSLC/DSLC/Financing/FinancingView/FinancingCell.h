//
//  FinancingCell.h
//  DSLC
//
//  Created by ios on 15/10/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDRadialProgressView.h"

@interface FinancingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewGiPian;
@property (weak, nonatomic) IBOutlet UILabel *labelMonth;
@property (weak, nonatomic) IBOutlet UIView *viewLine;
@property (weak, nonatomic) IBOutlet UILabel *labelPercentage;
@property (weak, nonatomic) IBOutlet UILabel *labelDayNum;
@property (weak, nonatomic) IBOutlet UILabel *labelYear;
@property (weak, nonatomic) IBOutlet UILabel *labelData;
@property (weak, nonatomic) IBOutlet UIImageView *outPay;
@property (weak, nonatomic) IBOutlet MDRadialProgressView *quanView;

@end
