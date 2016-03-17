//
//  BillCell.h
//  DSLC
//
//  Created by ios on 15/10/30.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDRadialProgressView.h"


@interface BillCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *buttonRed;
@property (weak, nonatomic) IBOutlet UILabel *labelMonth;
@property (weak, nonatomic) IBOutlet UILabel *labelQiTou;
@property (weak, nonatomic) IBOutlet UIView *viewLine1;
@property (weak, nonatomic) IBOutlet UILabel *labelLeftUp;
@property (weak, nonatomic) IBOutlet UILabel *labelMidUp;
@property (weak, nonatomic) IBOutlet UIView *viewLine2;
@property (weak, nonatomic) IBOutlet UIView *viewLine3;
@property (weak, nonatomic) IBOutlet UILabel *labelLeftDown;
@property (weak, nonatomic) IBOutlet UILabel *labelMidDown;
@property (weak, nonatomic) IBOutlet UIImageView *saleOut;
@property (weak, nonatomic) IBOutlet MDRadialProgressView *quanView;

@end
