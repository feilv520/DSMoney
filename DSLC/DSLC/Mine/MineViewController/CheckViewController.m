//
//  CheckViewController.m
//  DSLC
//
//  Created by ios on 15/10/19.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "CheckViewController.h"
#import "UIColor+AddColor.h"
#import "define.h"
#import "CreatView.h"

@interface CheckViewController ()

@end

@implementation CheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationItem setTitle:@"查看协议"];
    [self labelShow];
}

//label自适应
- (void)labelShow
{
    UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, 100) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为1,0000元由大圣理财提供,期限3天,到期后兑付3天收益。\n新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为1,0000元由大圣理财提供,期限3天,到期后兑付3天收益。新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为1,0000元由大圣理财提供,期限3天,到期后兑付3天收益。新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为1,0000元由大圣理财提供,期限3天,到期后兑付3天收益。新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为1,0000元由大圣理财提供,期限3天,到期后兑付3天收益。\n新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为1,0000元由大圣理财提供,期限3天,到期后兑付3天收益。新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为1,0000元由大圣理财提供,期限3天,到期后兑付3天收益。"];
    [self.view addSubview:label];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil];
    CGRect rect = [label.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 20, 999999) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    label.numberOfLines = 0;
    label.frame = CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, rect.size.height + 13);
    NSLog(@"%f", rect.size.height);
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
