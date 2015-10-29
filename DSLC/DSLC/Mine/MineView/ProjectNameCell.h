//
//  ProjectNameCell.h
//  DSLC
//
//  Created by ios on 15/10/29.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectNameCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelLine;
@property (weak, nonatomic) IBOutlet UIView *viewDown;
@property (weak, nonatomic) IBOutlet UILabel *labelSheng;
@property (weak, nonatomic) IBOutlet UILabel *labelMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelLeftUp;
@property (weak, nonatomic) IBOutlet UILabel *labelRightUp;
@property (weak, nonatomic) IBOutlet UILabel *labelLeftDown;
@property (weak, nonatomic) IBOutlet UILabel *labelRightDown;
@property (weak, nonatomic) IBOutlet UILabel *labelLineDown;

@end
