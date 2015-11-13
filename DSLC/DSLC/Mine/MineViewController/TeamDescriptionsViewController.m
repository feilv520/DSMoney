//
//  TeamDescriptionsViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/11/2.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "TeamDescriptionsViewController.h"

@interface TeamDescriptionsViewController ()

@end

@implementation TeamDescriptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"管理团队简介";
    
    [self contentShow];
}

- (void)contentShow
{
    UIScrollView *scrollView = [CreatView creatWithScrollViewFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) backgroundColor:[UIColor whiteColor] contentSize:CGSizeMake(0, 10) contentOffSet:CGPointMake(0, 0)];
    [self.view addSubview:scrollView];
    
    UILabel *labelTitle = [CreatView creatWithLabelFrame:CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"国丞财富 产品管理人"];
    [scrollView addSubview:labelTitle];
    
    UILabel *labelContent = [CreatView creatWithLabelFrame:CGRectMake(10, 50, WIDTH_CONTROLLER_DEFAULT - 20, 10) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"第一个问题是连接App Store，受影响的用户不能存取App Store、不能更新apps、不能找回下载记录。就算注销再登入Apple ID，依然未能修复。部分不幸的用户，问题更超越App Store，而是所有用Apple ID 登入的功能都受影响例如Game Center 和Apple Music。\n\n第二个不少用户都遇到的重大问题是Touch ID。有些装置的Touch ID 辨识速度变得很慢，或者变得不稳定，最严重的是完全没反应。部分用户强制重启后能暂时修复，但再过一阵子问题又再发生。\n\n之前只要由iOS 9.1 降回iOS 9.0.2 就能修正以上两个问题，可是现在Apple 已经暂停认证iOS 9.0.2。由于颇多人都受影响，外国大型传媒Forbes 甚至直接联络Apple，不过Apple 暂时不回应。被盗的福建三明“章公六全祖师”肉身佛到底能不能回到中国？这或许将诉诸一场跨国官司。“章公六全祖师”佛像曾一直供奉在福建大田县阳春村林氏宗祠，直到1995年被盗。佛像一失20年，今年3月，阳春村村民们发现，匈牙利自然科学博物馆展出的一尊“肉身坐佛”极似被盗的祖师佛像，福建省文物局亦认定“肉身坐佛”是“章公祖师”佛像。自此开始，肉身佛归国便成为阳春村人的期盼。通过民间交涉和外交途径，荷兰收藏者曾同意归还，但随后态度出现反复。面对20年诉讼时限即将到期，阳春村村民不得不走上打跨国官司的道路。12日，阳春村村民正式委托一个由中、荷两国7名律师组成的律师团，通过司法诉讼途径追索“章公祖师”肉身佛。此后，福建省文物局初步确认，这尊肉身坐佛应是20年前阳春村被盗的章公祖师像。国家文物局也在随后表示，将通过适当的渠道与这尊肉身佛的荷兰收藏者进行沟通，争取流失被盗的章公祖师像早日回到当地。"];
    [scrollView addSubview:labelContent];
    labelContent.numberOfLines = 0;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"CenturyGothic" size:14], NSFontAttributeName,nil];
    CGRect rect = [labelContent.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    labelContent.frame = CGRectMake(10, 50, WIDTH_CONTROLLER_DEFAULT - 20, rect.size.height);
    
    scrollView.contentSize = CGSizeMake(0, 50 + rect.size.height + 10);
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
