//
//  MyHandButton.m
//  DSLC
//
//  Created by 马成铭 on 15/10/16.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MyHandButton.h"

@interface MyHandButton ()

@property (nonatomic, strong) NSMutableArray *selectBtns;
@property (nonatomic, assign) CGPoint current;

@end

// 只读的变量名,在其他的类中不能生成相同的变量名
CGFloat const btnCount = 9;
CGFloat const btnW = 74;
CGFloat const btnH = 74;
CGFloat const viewY = 300;
NSInteger const columnCount = 3;
#define viewW [UIScreen mainScreen].bounds.size.width

@implementation MyHandButton

- (NSMutableArray *)selectBtns{
    if (_selectBtns == nil) {
        _selectBtns = [NSMutableArray array];
    }
    return _selectBtns;
}

// 通过代码会调用这个方法
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self AddButton];
    }
    return self;
}

// 通过sb 和 xib 文件创建的时候会调用
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
        [self AddButton];
    }
    return self;
}

// 布局按钮
- (void)AddButton{
    CGFloat height = 0;
    for (NSInteger i = 0; i < btnCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        button.tag = i;
        button.userInteractionEnabled = NO;
        
        [button setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        
        NSInteger row = i / columnCount;//第几行
        NSInteger column = i % columnCount;//第几列
        // 边距
        CGFloat margin = (self.frame.size.width - columnCount *btnW) / (columnCount + 1);
        CGFloat btnX = margin + column * (btnW + margin);
        CGFloat btnY = row * (btnW + margin);
        
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        height = btnH + btnY;
        [self addSubview:button];
    }
    
    self.frame = CGRectMake(8, viewY, viewW - 16, height);
}

#pragma mark 私有方法

- (CGPoint)pointWithTouch:(NSSet *)touches{
    // 拿到触摸的点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    return point;
}

- (UIButton *)buttonWithPoint:(CGPoint)point{
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
    }
    return nil;
}

#pragma mark - 触摸方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [self pointWithTouch:touches];
    UIButton *btn = [self buttonWithPoint:point];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectBtns addObject:btn];//往数组或者字典添加东西的时候要判断对象是否存在
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [self pointWithTouch:touches];
    UIButton *btn = [self buttonWithPoint:point];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectBtns addObject:btn];
    } else {
        self.current = point;
    }
    
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(lockView:didFinishPath:)]) {
        NSLog(@"123");
        NSMutableString *path = [NSMutableString string];
        for (UIButton *btn in self.selectBtns) {
            [path appendFormat:@"%ld",(long)btn.tag];
        }
        [self.delegate lockView:self didFinishPath:path];
    }
    
    // 清空按钮的选择状态
    // 类似循环的方法  效率高
//    [self.selectBtns makeObjectsPerformSelector:@selector(setSelected:) withObject:@NO];
    for (UIButton *btn in self.selectBtns) {
        btn.selected = NO;
    }
    [self.selectBtns removeAllObjects];
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchesEnded:touches withEvent:event];
}

#pragma mark 绘图

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    if (self.selectBtns.count == 0) {
        return;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 8;
    path.lineJoinStyle = kCGLineJoinRound;
    [[UIColor colorWithRed:211 / 255.0 green:75 / 255.0 blue:72 / 255.0 alpha:0.5] set];
    for (NSInteger i = 0; i < self.selectBtns.count; i++) {
        UIButton *button = self.selectBtns[i];
        if (i == 0) {
            [path moveToPoint:button.center];
        } else {
            [path addLineToPoint:button.center];
        }
    }
    [path addLineToPoint:self.current];
    [path stroke];
    
}


@end
