//
//  myCastTableViewCell.h
//  DSLC
//
//  Created by 马成铭 on 16/3/16.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myCastTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tzLabel;
@property (weak, nonatomic) IBOutlet UILabel *dfLabel;
@property (weak, nonatomic) IBOutlet UILabel *tzMLabel;
@property (weak, nonatomic) IBOutlet UILabel *syLabel;

@end
