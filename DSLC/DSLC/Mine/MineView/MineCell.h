//
//  MineCell.h
//  DSLC
//
//  Created by ios on 15/10/15.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewPic;
@property (weak, nonatomic) IBOutlet UIImageView *imageRight;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelLine;

@end
