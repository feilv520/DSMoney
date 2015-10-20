//
//  MyInviteCell.h
//  DSLC
//
//  Created by ios on 15/10/20.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInviteCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labInviteNum;
@property (weak, nonatomic) IBOutlet UILabel *labelNum;
@property (weak, nonatomic) IBOutlet UILabel *labelHttp;
@property (weak, nonatomic) IBOutlet UILabel *labelHttpNum;
@property (weak, nonatomic) IBOutlet UIButton *buttonCopy;
@property (weak, nonatomic) IBOutlet UIButton *butCopyTwo;

@end
