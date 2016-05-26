//
//  Calendar.h
//  DSLC
//
//  Created by 马成铭 on 15/10/13.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Calendar : UIView <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UITextField *inputMoney;
@property (weak, nonatomic) IBOutlet UILabel *yearLv;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIView *viewDown;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
