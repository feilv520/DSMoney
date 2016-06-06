//
//  TWOProductDemoTableViewCell.h
//  DSLC
//
//  Created by 马成铭 on 16/6/6.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDRadialProgressView.h"

@interface TWOProductDemoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewGiPian;
@property (weak, nonatomic) IBOutlet UILabel *labelproductName;
@property (weak, nonatomic) IBOutlet UIView *viewLine;
@property (weak, nonatomic) IBOutlet UILabel *labelPercentage;
@property (weak, nonatomic) IBOutlet UILabel *labelDayNum;
@property (weak, nonatomic) IBOutlet UILabel *labelDetail;
@property (weak, nonatomic) IBOutlet UIImageView *outPay;
@property (weak, nonatomic) IBOutlet MDRadialProgressView *quanView;

@end
