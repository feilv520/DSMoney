//
//  CastProduceViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/10/19.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "CastProduceViewController.h"
#import "define.h"
#import "CastUpTableViewCell.h"
#import "CastDownTableViewCell.h"
#import "CastDetailTableViewCell.h"
#import "CreatView.h"
#import "UIColor+AddColor.h"
#import "CheckViewController.h"

@interface CastProduceViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation CastProduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = buttonBorderColor;
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 84) style:UITableViewStylePlain];
    
    self.mainTableView.backgroundColor = buttonBorderColor;
    
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"CastUpTableViewCell" bundle:nil] forCellReuseIdentifier:@"castUp"];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"CastDownTableViewCell" bundle:nil] forCellReuseIdentifier:@"castDown"];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"CastDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"castDetail"];
    
    [self.view addSubview:self.mainTableView];
    
    [self setXYButton];
    
    [self.navigationItem setTitle:@"在投产品"];
}

//查看协议
- (void)setXYButton{
    
    UIView *tableBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 84 + 43)];
    
    tableBottom.backgroundColor = Color_Clear;
    
    UIButton *xyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [xyButton setFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (51 / 375.0), 42, WIDTH_CONTROLLER_DEFAULT * (271.0 / 375.0), 43)];
    
    [xyButton setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    
    [xyButton setTitle:@"查看协议" forState:UIControlStateNormal];
    
    [xyButton setTitleColor:Color_White forState:UIControlStateNormal];
    
    [xyButton addTarget:self action:@selector(xyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [tableBottom addSubview:xyButton];
    
    self.mainTableView.tableFooterView = tableBottom;
    
}

- (void)xyButtonAction:(UIButton *)btn{
    
    CheckViewController *checkVC = [[CheckViewController alloc] init];
    [self.navigationController pushViewController:checkVC animated:YES];
}

#pragma mark tableview delegate and dataSource
#pragma mark ---------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 20;
    } else {
        return 0.5;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CastUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"castUp"];
        return cell;
    } else {
        if (indexPath.row == 0) {
            CastDownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"castDown"];
            return cell;
        } else {
            CastDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"castDetail"];
            return cell;
        }
        
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 222;
    } else {
        if (indexPath.row == 0) {
            return 133;
        } else {
            return 89;
        }
    }
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
