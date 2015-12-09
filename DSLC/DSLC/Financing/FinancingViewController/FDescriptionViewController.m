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
    
    self.textArray = @[@"本次资金用途为都江堰除用于滨江新城区域涉及的一级土地整理.本次资金用途为都江堰除用于滨江新城区域涉及的一级土地整理.本次资金用途为都江堰除用于滨江新城区域涉及的一级土地整理.本次资金用途为都江堰除用于滨江新城区域涉及的一级土地整理.本次资金用途为都江堰除用于滨江新城区域涉及的一级土地整理.",@"人物、情节、环境是小说的三要素。情节一般包括开端、发展、高潮、结局四部分，有的包括序幕、尾声。环境包括自然环境和社会环境。 小说按照篇幅及容量可分为长篇、中篇、短篇和微型小说（小小说）。按照表现的内容可分为科幻、公案、传奇、武侠、言情、同人、官宦等。按照体制可分为章回体小说、日记体小说、书信体小说、自传体小说。按照语言形式可分为文言小说和白话小说。",@"“小说”一词最早出现于《庄子·外物》：「饰小说以干县令，其于大达亦远矣。」庄子所谓的「小说」，是指琐碎的言论，与今日小说观念相差甚远。直至东汉桓谭《新论》：「小说家合残丛小语，近取譬喻，以作短书，治身理家，有可观之辞。」班固《汉书．艺文志》将「小说家」列为十家之后，其下的定义为：「小说家者流，盖出于稗官，街谈巷语，道听途说[4]之所造也。」才稍与今日小说的意义相近。而中国小说最大的特色，便自宋代开始具有文言小说与白话小说两种不同的小说系统。文言小说起源于先秦的街谈巷语，是一种小知小道的纪录。在历经魏晋南北朝及隋唐长期的发展，无论是题材或人物的描写，文言小说都有明显的进步，形成笔记与传奇两种小说类型。而白话小说则起源于唐宋时期说话人的话本，故事的取材来自民间，主要表现了百姓的生活及思想意识。但不管文言小说或白话小说都源远流长，呈现各自不同的艺术特色。"];
    self.photoArray = @[@"lianggeren.png",@"lianggeren.png",@"lianggeren.png"];
    
//    [self createOfTableView];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20)];
//    webView.scalesPageToFit = YES;
    
    [self.view addSubview:webView];
    
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
