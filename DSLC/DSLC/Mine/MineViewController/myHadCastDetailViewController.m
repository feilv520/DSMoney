//
//  myHadCastDetailViewController.m
//  DSLC
//
//  Created by 马成铭 on 16/3/17.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "myHadCastDetailViewController.h"

@interface myHadCastDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *tzLabel;
@property (weak, nonatomic) IBOutlet UILabel *dfLabel;
@property (weak, nonatomic) IBOutlet UILabel *tzMLabel;
@property (weak, nonatomic) IBOutlet UILabel *hyMLabel;

@end

@implementation myHadCastDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"兑付详情"];
    
    NSString *moneyString = [[DES3Util decrypt:self.model.money] stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2lf",[moneyString floatValue] + [[DES3Util decrypt:self.model.totalProfit] floatValue]];
    
    self.tzLabel.text = self.model.buyTime;
    self.dfLabel.text = self.model.dueDate;
    self.tzMLabel.text = [DES3Util decrypt:self.model.money];
    self.hyMLabel.text = [DES3Util decrypt:self.model.totalProfit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
