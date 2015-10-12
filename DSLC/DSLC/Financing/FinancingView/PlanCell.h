//
//  PlanCell.h
//  DSLC
//
//  Created by ios on 15/10/10.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelPlan;
@property (weak, nonatomic) IBOutlet UIView *viewLine;
@property (weak, nonatomic) IBOutlet UILabel *buyPlan;
@property (weak, nonatomic) IBOutlet UIImageView *imageTimeZhou;
@property (weak, nonatomic) IBOutlet UILabel *timeOne;
@property (weak, nonatomic) IBOutlet UILabel *beginDay;
@property (weak, nonatomic) IBOutlet UILabel *rightNowTime;
@property (weak, nonatomic) IBOutlet UILabel *labelEndDay;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *labelCash;
@property (weak, nonatomic) IBOutlet UILabel *cashDay;
@property (weak, nonatomic) IBOutlet UIImageView *imageQuan;

@end
