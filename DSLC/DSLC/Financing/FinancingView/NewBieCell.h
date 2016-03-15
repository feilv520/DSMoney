//
//  NewBieCell.h
//  DSLC
//
//  Created by ios on 15/11/2.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewBieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelShouYiLv;
@property (weak, nonatomic) IBOutlet UILabel *labelPercent;
@property (weak, nonatomic) IBOutlet UIView *viewLine;
@property (weak, nonatomic) IBOutlet UIButton *buttonImage;
@property (weak, nonatomic) IBOutlet UILabel *labelLeftUp;
@property (weak, nonatomic) IBOutlet UILabel *labelMidUp;
@property (weak, nonatomic) IBOutlet UILabel *labelRightUp;
@property (weak, nonatomic) IBOutlet UILabel *labelLeftRight;
@property (weak, nonatomic) IBOutlet UILabel *labelMidDOwn;
@property (weak, nonatomic) IBOutlet UILabel *labelDownRight;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;

@end
