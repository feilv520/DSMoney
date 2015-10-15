//
//  FQuickPayViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/10/14.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "FQuickPayViewController.h"
#import "CreatView.h"
#import "define.h"

@interface FQuickPayViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *sendYanZhengCode;
@property (weak, nonatomic) IBOutlet UIButton *forgetPassword;

@property (weak, nonatomic) IBOutlet UITextField *inputCode;
@property (weak, nonatomic) IBOutlet UITextField *inputPassword;

@property (weak, nonatomic) IBOutlet UIView *failView;
@property (weak, nonatomic) IBOutlet UIView *successView;
@property (weak, nonatomic) IBOutlet UIButton *payButton;

@end

@implementation FQuickPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"快捷支付";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self modifiedWithXibView];
//    [self addTapGWithView];
    [self showNavigationReturn];
    
}

// 修改xibView上的细节
- (void)modifiedWithXibView{
    self.failView.hidden = YES;
    self.successView.hidden = YES;
    
    [self.sendYanZhengCode.layer setMasksToBounds:YES];
    self.sendYanZhengCode.layer.cornerRadius = 4.0;
    self.sendYanZhengCode.layer.borderWidth = 1;
    self.sendYanZhengCode.layer.borderColor = [[UIColor colorWithRed:226.0 / 255.0 green:226.0 / 255.0 blue:226.0 / 255.0 alpha:1] CGColor];
    
    self.inputCode.delegate = self;
    self.inputPassword.delegate = self;
    [self.inputCode addTarget:self action:@selector(textLengthChange:) forControlEvents:UIControlEventEditingChanged];
    [self.inputPassword addTarget:self action:@selector(textLengthChange:) forControlEvents:UIControlEventEditingChanged];
    
}

// 判断字符串长度
- (void)textLengthChange:(UITextField *)textField{
    if (![_inputCode.text isEqualToString:@""] && ![_inputPassword.text isEqualToString:@""]){
        self.payButton.userInteractionEnabled = YES;
        [self.payButton setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    } else {
        self.payButton.userInteractionEnabled = NO;
        [self.payButton setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    }
}

// 给view添加一个手势
- (void)addTapGWithView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    //  单击
    tap.numberOfTapsRequired = 1;
    //  试图添加一个手势，UIView的方法
    [self.view addGestureRecognizer:tap];

}

- (void)tap:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//修改导航栏的默认返回按钮
- (void)showNavigationReturn
{
    UIImageView *imageReturn = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, 20, 20) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"750产品111"]];
    imageReturn.userInteractionEnabled = YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageReturn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnBack:)];
    [imageReturn addGestureRecognizer:tap];
}

//导航返回按钮
- (void)returnBack:(UIBarButtonItem *)bar
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 支付按钮动作
- (IBAction)payButtonAction:(id)sender {
    NSInteger i = arc4random() % 2;
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGPoint originPoint = self.payButton.frame.origin;
    CGSize sizeButton = self.payButton.frame.size;
    
    if ([self.inputPassword.text isEqualToString:@"123456"] && [self.inputCode.text isEqualToString:@"1234"]){
        if (i) {
            self.successView.hidden = NO;
            self.failView.hidden = YES;
            
            CGFloat originY = CGRectGetMaxY(self.successView.frame) + 40;
            
            self.payButton.frame = CGRectMake(originPoint.x, originY, sizeButton.width, sizeButton.height);
            
            [self.payButton setTitle:@"继续投资" forState:UIControlStateNormal];
            
        } else {
            self.failView.hidden = NO;
            self.successView.hidden = YES;
            
            CGFloat originY = CGRectGetMaxY(self.failView.frame) + 46;
            
            self.payButton.frame = CGRectMake(originPoint.x, originY, sizeButton.width, sizeButton.height);
            
            [self.payButton setTitle:@"立即充值" forState:UIControlStateNormal];
            
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
