//
//  TWOHomePageProductCell.h
//  DSLC
//
//  Created by ios on 16/6/1.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWOHomePageProductCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UIImageView *imageBuying;
@property (weak, nonatomic) IBOutlet UIButton *butQuanQuan;
@property (weak, nonatomic) IBOutlet UILabel *labelYuQi;
@property (weak, nonatomic) IBOutlet UILabel *labelData;
@property (weak, nonatomic) IBOutlet UILabel *labelLastMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelQiTou;
@property (weak, nonatomic) IBOutlet UILabel *labelDownONe;
@property (weak, nonatomic) IBOutlet UILabel *labelDownMid;
@property (weak, nonatomic) IBOutlet UILabel *labelDownRight;
@property (weak, nonatomic) IBOutlet UIButton *butRightNow;
@property (weak, nonatomic) IBOutlet UIButton *butLeft;
@property (weak, nonatomic) IBOutlet UIButton *butRight;

@end
