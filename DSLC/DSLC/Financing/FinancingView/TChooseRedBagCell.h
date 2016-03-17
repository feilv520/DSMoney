//
//  TChooseRedBagCell.h
//  DSLC
//
//  Created by ios on 16/3/16.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TChooseRedBagCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *butChoose;
@property (weak, nonatomic) IBOutlet UIImageView *imageRedBag;
@property (weak, nonatomic) IBOutlet UIButton *butSend;
@property (weak, nonatomic) IBOutlet UILabel *labelRedBag;
@property (weak, nonatomic) IBOutlet UILabel *labelStyle;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UILabel *labelContent;
@end
