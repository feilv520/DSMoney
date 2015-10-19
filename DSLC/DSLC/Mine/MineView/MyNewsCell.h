//
//  MyNewsCell.h
//  DSLC
//
//  Created by ios on 15/10/19.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageLeft;
@property (weak, nonatomic) IBOutlet UILabel *labelPrize;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;

@end
