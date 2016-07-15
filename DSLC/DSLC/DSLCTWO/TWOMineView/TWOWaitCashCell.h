//
//  TWOWaitCashCell.h
//  DSLC
//
//  Created by ios on 16/5/27.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWOWaitCashCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageWait;
@property (weak, nonatomic) IBOutlet UILabel *labelPercent;
@property (weak, nonatomic) IBOutlet UILabel *labelTiaoJian;
@property (weak, nonatomic) IBOutlet UILabel *labelEvery;
@property (weak, nonatomic) IBOutlet UILabel *laeblData;
@property (weak, nonatomic) IBOutlet UIButton *buttonWait;
@property (weak, nonatomic) IBOutlet UILabel *laeblMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UIView *viewLine;

@end
