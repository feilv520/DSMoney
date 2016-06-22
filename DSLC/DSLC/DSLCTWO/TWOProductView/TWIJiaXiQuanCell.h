//
//  TWIJiaXiQuanCell.h
//  DSLC
//
//  Created by ios on 16/6/21.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWIJiaXiQuanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagePicture;
@property (weak, nonatomic) IBOutlet UILabel *labelMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelTiaoJian;
@property (weak, nonatomic) IBOutlet UILabel *labelEvery;
@property (weak, nonatomic) IBOutlet UILabel *labelData;
@property (weak, nonatomic) IBOutlet UIButton *butCanUse;

@end
