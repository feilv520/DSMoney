//
//  FinancingViewController.m
//  DSLC
//
//  Created by ios on 15/10/8.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "FinancingViewController.h"
#import "CreatView.h"

@interface FinancingViewController ()

{
    NSArray *buttonArr;
    UIButton *butThree;
    UILabel *lableRedLine;
    NSInteger buttonTag;
}

@end

@implementation FinancingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    buttonTag = 101;
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    self.navigationItem.title = @"理财产品";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self showButtonThree];
}

//导航栏下面的三个按钮
- (void)showButtonThree
{
    buttonArr = @[@"新手专享", @"固收理财", @"票据投资"];
    
    UIScrollView *scrollView = [CreatView creatWithScrollViewFrame:CGRectMake(0, 0, self.view.frame.size.width, 45) backgroundColor:[UIColor whiteColor] contentSize:CGSizeMake(self.view.frame.size.width/3 * buttonArr.count, 0) contentOffSet:CGPointMake(0, 0)];
    
    [self.view addSubview:scrollView];
    
    for (int i = 0; i < 3; i++) {
        
        butThree = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(self.view.frame.size.width/3 * i, 0, self.view.frame.size.width/3, 45) backgroundColor:[UIColor whiteColor] textColor:[UIColor grayColor] titleText:[NSString stringWithFormat:@"%@", [buttonArr objectAtIndex:i]]];
        butThree.titleLabel.font = [UIFont systemFontOfSize:14];
        butThree.tag = 100 + i;
        [scrollView addSubview:butThree];
        
        [butThree addTarget:self action:@selector(buttonThreePress:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 1) {
            
            [butThree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
    }
    
    lableRedLine = [CreatView creatWithLabelFrame:CGRectMake(self.view.frame.size.width/3, 43, self.view.frame.size.width/3, 2) backgroundColor:[UIColor redColor] textColor:[UIColor clearColor] textAlignment:NSTextAlignmentCenter text:@""];
    [self.view addSubview:lableRedLine];

}

- (void)buttonThreePress:(UIButton *)button
{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        if (button.tag == 100) {
            
            lableRedLine.frame = CGRectMake(0, 43, self.view.frame.size.width/3, 2);
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            UIButton *beforeButton = (UIButton *)[self.view viewWithTag:buttonTag];
            [beforeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
            buttonTag = button.tag;
            
        } else if (button.tag == 101) {
            
            lableRedLine.frame = CGRectMake(self.view.frame.size.width/3, 43, self.view.frame.size.width/3, 2);
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            UIButton *beforeButton = (UIButton *)[self.view viewWithTag:buttonTag];
            [beforeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
            buttonTag = button.tag;
            
        } else {
            
            lableRedLine.frame = CGRectMake(self.view.frame.size.width/3 * 2, 43, self.view.frame.size.width/3, 2);
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            UIButton *beforeButton = (UIButton *)[self.view viewWithTag:buttonTag];
            [beforeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
            buttonTag = button.tag;
        }
        
    } completion:^(BOOL finished) {
        
    }];
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
