//
//  NotSeparateCell.h
//  DSLC
//
//  Created by ios on 15/11/18.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotSeparateCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imagePic;
@property (weak, nonatomic) IBOutlet UILabel *labelSend;
@property (weak, nonatomic) IBOutlet UILabel *labelMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelBagStyle;
@property (weak, nonatomic) IBOutlet UILabel *laeblRequest;
@property (weak, nonatomic) IBOutlet UILabel *labelDays;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UIButton *buttonOpen;

@end
