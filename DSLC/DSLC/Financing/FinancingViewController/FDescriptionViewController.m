//
//  FDescriptionViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/11/2.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "FDescriptionViewController.h"
#import "TextTableViewCell.h"
#import "PhotoTableViewCell.h"

@interface FDescriptionViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic, strong) NSArray *photoArray;

@end

@implementation FDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"产品描述";
    
//    [self createOfTableView];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20)];
//    webView.scalesPageToFit = YES;
    
    [self.view addSubview:webView];

    NSLog(@"%@",self.detailString);
    
//    if ([self.detailString hasPrefix:@"&"]) {
        self.detailString = [self.detailString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        self.detailString = [self.detailString stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        self.detailString = [self.detailString stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
        self.detailString = [self.detailString stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        self.detailString = [self.detailString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
//    }
    
    [webView loadHTMLString:self.detailString baseURL:nil];
    
}

- (void)createOfTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 84) style:UITableViewStylePlain];
    
    tableView.dataSource = self;
    tableView.delegate = self;

    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [tableView registerNib:[UINib nibWithNibName:@"TextTableViewCell" bundle:nil] forCellReuseIdentifier:@"texttext"];
    [tableView registerNib:[UINib nibWithNibName:@"PhotoTableViewCell" bundle:nil] forCellReuseIdentifier:@"photophoto"];
    
    [self.view addSubview:tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.textArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TextTableViewCell *cell = (TextTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    } else {
        return 150.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"texttext"];
        [cell setIntroductionText:[self.textArray objectAtIndex:indexPath.section]];
        
        return cell;
    } else {
        
        PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photophoto"];
        
        return cell;
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
