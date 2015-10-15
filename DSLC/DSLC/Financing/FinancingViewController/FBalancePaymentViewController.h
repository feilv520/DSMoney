//
//  FBalancePaymentViewController.h
//  DSLC
//
//  Created by ios on 15/10/14.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBalancePaymentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelMonth1;
@property (weak, nonatomic) IBOutlet UILabel *labelLine1;
@property (weak, nonatomic) IBOutlet UILabel *lableThounand;
@property (weak, nonatomic) IBOutlet UILabel *lableLine2;
@property (weak, nonatomic) IBOutlet UILabel *labelLine3;
@property (weak, nonatomic) IBOutlet UIView *viewDianDi;
@property (weak, nonatomic) IBOutlet UILabel *labelLine4;
@property (weak, nonatomic) IBOutlet UIButton *butPayment;
@property (weak, nonatomic) IBOutlet UILabel *labelPayment;
@property (weak, nonatomic) IBOutlet UILabel *labelSecret;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSecret;
@property (weak, nonatomic) IBOutlet UIButton *butForget;

@end
