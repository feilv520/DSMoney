//
//  TWOBankCardCell.h
//  DSLC
//
//  Created by ios on 16/5/16.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWOBankCardCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imagePincture;
@property (weak, nonatomic) IBOutlet UIImageView *imageBankLogo;
@property (weak, nonatomic) IBOutlet UILabel *labelBankName;
@property (weak, nonatomic) IBOutlet UILabel *labelStyle;
@property (weak, nonatomic) IBOutlet UILabel *labelCardNum;

@end
