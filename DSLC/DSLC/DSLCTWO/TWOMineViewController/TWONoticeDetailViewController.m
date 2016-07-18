//
//  TWONoticeDetailViewController.m
//  DSLC
//
//  Created by ios on 16/7/18.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWONoticeDetailViewController.h"

@interface TWONoticeDetailViewController ()

@end

@implementation TWONoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"公告详情"];
    
    [self contentShow];
}

- (void)contentShow
{
    UILabel *labelTitle = [CreatView creatWithLabelFrame:CGRectMake(25, 21, WIDTH_CONTROLLER_DEFAULT - 50, 17) backgroundColor:[UIColor clearColor] textColor:[UIColor blackZiTi] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:16] text:self.messageTitle];
    [self.view addSubview:labelTitle];
    
    UILabel *labelTime = [CreatView creatWithLabelFrame:CGRectMake(25, 56, WIDTH_CONTROLLER_DEFAULT - 50, 13) backgroundColor:[UIColor clearColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:self.creatTime];
    [self.view addSubview:labelTime];
    
    UILabel *labelContent = [CreatView creatWithLabelFrame:CGRectMake(25, 100, WIDTH_CONTROLLER_DEFAULT - 50, 10) backgroundColor:[UIColor clearColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:self.content];
    [self.view addSubview:labelContent];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"CenturyGothic" size:14], NSFontAttributeName, nil];
    CGRect rect = [labelContent.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 50, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    labelContent.numberOfLines = 0;
    labelContent.frame = CGRectMake(25, 100, WIDTH_CONTROLLER_DEFAULT - 50, rect.size.height);
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
