//
//  UIScrollView+UITouchEvent.m
//  DSLC
//
//  Created by 马成铭 on 16/6/14.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "UIScrollView+UITouchEvent.h"

@implementation UIScrollView (UITouchEvent)

// 手写输入会产生冲突, 所以这个方法要屏蔽
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

@end
