//
//  MiddleView.h
//  DSLC
//
//  Created by ios on 15/10/15.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MiddleView : UIView

@property (weak, nonatomic) IBOutlet UIView *viewLine;
@property (weak, nonatomic) IBOutlet UIView *viewLLine;
@property (weak, nonatomic) IBOutlet UILabel *labelYuan;
@property (weak, nonatomic) IBOutlet UILabel *labelMyMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelWanYuan;
@property (weak, nonatomic) IBOutlet UILabel *labelData;
@property (weak, nonatomic) IBOutlet UIButton *butCashMoney;
@property (weak, nonatomic) IBOutlet UIButton *butWithdrawal;
@property (weak, nonatomic) IBOutlet UIButton *butBigMoney;
@property (weak, nonatomic) IBOutlet UIView *viewDiBu;
@property (weak, nonatomic) IBOutlet UILabel *labelAllMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelTAllMoney;


@end
