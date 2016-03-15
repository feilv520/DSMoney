//
//  MeCell.h
//  DSLC
//
//  Created by ios on 15/10/21.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"

@interface MeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet YYAnimatedImageView *imageHeadPic;
@property (weak, nonatomic) IBOutlet UIImageView *imageRight;
@property (weak, nonatomic) IBOutlet UILabel *labelInviteNumber;

@end
