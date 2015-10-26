//
//  ServiceCell.h
//  DSLC
//
//  Created by ios on 15/10/26.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewLeft;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelNum;
@property (weak, nonatomic) IBOutlet UIImageView *imageRight;
@property (weak, nonatomic) IBOutlet UILabel *labelLine;

@end
