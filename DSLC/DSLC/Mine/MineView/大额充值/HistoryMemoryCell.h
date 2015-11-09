//
//  HistoryMemoryCell.h
//  DSLC
//
//  Created by ios on 15/11/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryMemoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelBigMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UILabel *labelMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelState;

@end
