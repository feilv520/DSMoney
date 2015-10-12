//
//  BasicMessageCell.h
//  DSLC
//
//  Created by ios on 15/10/10.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelBaseMess;
@property (weak, nonatomic) IBOutlet UIView *viewLine;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *nameContent;
@property (weak, nonatomic) IBOutlet UILabel *labelNumber;
@property (weak, nonatomic) IBOutlet UILabel *numberContent;
@property (weak, nonatomic) IBOutlet UILabel *labelInvestor;
@property (weak, nonatomic) IBOutlet UILabel *InvestorContent;
@property (weak, nonatomic) IBOutlet UILabel *labelData;
@property (weak, nonatomic) IBOutlet UILabel *labelIntraday;
@property (weak, nonatomic) IBOutlet UILabel *labelStyle;
@property (weak, nonatomic) IBOutlet UILabel *labelIncome;

@end
