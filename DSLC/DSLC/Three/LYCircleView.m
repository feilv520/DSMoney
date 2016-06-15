//
//  LYCircleView.m
//  LYCircleView
//
//  Created by user on 16/5/30.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "LYCircleView.h"

#define CENTER_X self.bounds.size.width / 2
#define CENTER_Y self.bounds.size.height / 2

#define FIRST_LINE_X(x) CENTER_X + x
#define FIRST_LINE_Y(y) CENTER_Y + y

#define SEC_LINE_X(x) x > 0 ? FIRST_LINE_X(x) + secLine : FIRST_LINE_X(x) - secLine

#define SIN(x) sin(x / 180 * M_PI)
#define COS(x) cos(x / 180 * M_PI)

static NSInteger firstLine = 20;
static NSInteger secLine = 50;

@implementation LYCircleView
{
    NSMutableArray *hexColorArray;
    
    NSMutableArray *percentArray;
    
    NSArray *textArray;
    
    BOOL canDraw;
    
    NSInteger totalAngle;
    
    CGFloat radius;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createColorArray];
        if (self.bounds.size.width >= self.bounds.size.height) {
            radius = self.bounds.size.height / 4.5;
        }else {
            radius = self.bounds.size.width / 4.5;
        }
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    canDraw = YES;
    
    if ([self.dataSource respondsToSelector:@selector(percentOfTheCircle)]) {
        percentArray = [[self.dataSource percentOfTheCircle] copy];
    }
    
    if ([self.dataSource respondsToSelector:@selector(textStringOfCircle)]) {
        textArray = [[self.dataSource textStringOfCircle] copy];
    }
    
    if ([self.dataSource respondsToSelector:@selector(hexStringOfCircleColor)]) {
        NSArray *colorArray = [self.dataSource hexStringOfCircleColor];
        if (colorArray.count > 0) {
            for (int i = 0; i < colorArray.count; i ++) {
                [hexColorArray insertObject:colorArray[i] atIndex:i];
            }
        }
    }
    [self checkCirCleViewDatas];
}

- (void)checkCirCleViewDatas{
    if (percentArray.count > hexColorArray.count || percentArray.count == 0) {
        canDraw = NO;
        return;
    }
    //检查百分比数组
    CGFloat totalPercent = 0.0;
    
    for (NSString *percent in percentArray) {
        if ([percent floatValue] <= 0) {
            canDraw = NO;
            return;
        }
        totalPercent = totalPercent + [percent floatValue];
    }
    
    if (totalPercent != 100) {
        canDraw = NO;
        return;
    }
    
    if (textArray.count > 0 &&  textArray.count != percentArray.count ) {
        canDraw = NO;
    }
}

//自带颜色
- (void)createColorArray{
    /**
     蓝色: 0000FF
     绿色: 008000
     紫色: 800080
     黄色: FFFF00
     红色: FF0000
     桃色: FFDAB9
     */
    hexColorArray = [[NSMutableArray alloc]initWithObjects:@"046bc4",@"0283de",@"0ca5f0",@"35a3ff",@"30cdf6",@"16b6cc",@"3399cc",@"79c6fc",@"b4e4ff",@"dbe5eb", nil];
}

- (void)drawRect:(CGRect)rect{
    if (!canDraw) {
        return;
    }
    //创建画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //已加载的扇形弧度总和
    CGFloat endPercent = 0.0;
    //当前扇形所占弧度
    CGFloat curPercent = 0.0;
    //每个扇形的百分比
    CGFloat perPercent = 0.0;
    
    for (int i = 0; i < percentArray.count; i ++) {
        perPercent = [percentArray[i] floatValue] / 100;
        curPercent = perPercent * 2 * M_PI;
        endPercent = perPercent * 2 * M_PI + endPercent;
        
        [self beginDrawingOnTheContext:context withHexColorString:hexColorArray[i] alpha:1];
        [self drawCircleOnTheContext:context WithRadius:radius StartAngle:endPercent - curPercent  EndAngle:endPercent];
        [self endDrawingOnTheContext:context withType:kCGPathFill];
        
        if (textArray.count > 0) {
            double angle = [self countLocationOftheExplainLine:endPercent curDegrees:curPercent];
            [self beginDrawingOnTheContext:context withHexColorString:hexColorArray[i] alpha:1];
            [self drawLineOnTheContext:context angle:angle withHexColorString:hexColorArray[i] andTextString:textArray[i] percent:percentArray[i]];
            [self endDrawingOnTheContext:context withType:kCGPathStroke];
        }
    }
//    //阴影
//    [self beginDrawingOnTheContext:context withHexColorString:@"000000" alpha:0.4];
//    [self drawCircleOnTheContext:context WithRadius:radius / 2 StartAngle:0 EndAngle:2 * M_PI];
//    [self endDrawingOnTheContext:context withType:kCGPathFill];
    
//    //中间空白
//    [self beginDrawingOnTheContext:context withHexColorString:@"FFFFFF" alpha:1];
//    [self drawCircleOnTheContext:context WithRadius:radius / 2 / 2.5  StartAngle:0 EndAngle:2 * M_PI];
//    [self endDrawingOnTheContext:context withType:kCGPathFill];
}

- (double)countLocationOftheExplainLine:(CGFloat)totalDegrees curDegrees:(CGFloat)curDegrees{
    CGFloat percent = (totalDegrees - curDegrees / 2) / M_PI_2;
    //和横纵轴形成的夹角
    totalAngle = percent * 90;
    //判断所在范围
    if ((totalAngle >= 90 && totalAngle < 180) || (totalAngle >= 270 && totalAngle < 360)) {
        return 90 - totalAngle % 90;
    }
    return totalAngle % 90 ;
}

//开始绘画
- (void)beginDrawingOnTheContext:(CGContextRef)context withHexColorString:(NSString *)color alpha:(CGFloat)alpha{
    CGContextMoveToPoint(context, CENTER_X, CENTER_Y);
    CGContextSetFillColorWithColor(context, [self colorWithHexString:color alpha:alpha].CGColor);
    CGContextSetStrokeColorWithColor(context, [self colorWithHexString:color alpha:alpha].CGColor);
}

//画线
- (void)drawLineOnTheContext:(CGContextRef)context angle:(double)angle withHexColorString:(NSString *)color andTextString:(NSString *)text percent:(NSString *)percent{
    CGFloat pointX = COS(angle);
    CGFloat pointY = SIN(angle);
    if (totalAngle >= 90 && totalAngle < 180) {
        pointX = -pointX;
    }
    if (totalAngle >= 180 && totalAngle < 270) {
        pointX = -pointX;
        pointY = -pointY;
    }
    if (totalAngle >= 270 && totalAngle < 360) {
        pointY = -pointY;
    }
    CGFloat lineX = FIRST_LINE_X(pointX * (radius + firstLine));
    CGFloat lineY = FIRST_LINE_Y(pointY * (radius + firstLine));
    //第一条线
    CGContextAddLineToPoint(context, lineX, lineY);

    //第二条线
    CGContextAddLineToPoint(context, SEC_LINE_X(pointX * (radius )), lineY);
    [self createExplainLabelPointX:lineX pointY:lineY withTextColorString:color andTextString:text percent:(NSString *)percent];
}

//画圆
- (void)drawCircleOnTheContext:(CGContextRef)context WithRadius:(CGFloat)radiu StartAngle:(CGFloat)startAngle EndAngle:(CGFloat)endAngle{
    CGContextAddArc(context, CENTER_X, CENTER_Y, radiu, startAngle, endAngle, 0);
}

//完成绘画
- (void)endDrawingOnTheContext:(CGContextRef)context withType:(CGPathDrawingMode)type{
    CGContextDrawPath(context, type);
}

- (void)createExplainLabelPointX:(CGFloat)pointX pointY:(CGFloat)pointY withTextColorString:(NSString *)colorStr andTextString:(NSString *)text percent:(NSString *)percent{
    if (pointX < CENTER_X) {
        pointX -= 150;
    }
    UILabel *percentLabel = [[UILabel alloc]initWithFrame:CGRectMake(pointX, pointY - 20, 150, 25)];
    percentLabel.text = [NSString stringWithFormat:@"%@%%",percent];
    percentLabel.textAlignment = 0;
    if (pointX < CENTER_X) {
        percentLabel.textAlignment = 2;
    }
    percentLabel.textColor = [self colorWithHexString:colorStr alpha:1];
    percentLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:percentLabel];
}

- (void)reloadData{
    [self layoutSubviews];
    [self setNeedsDisplay];
}


//颜色转换
- (UIColor *) colorWithHexString: (NSString *)color alpha:(CGFloat)alpha{
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

@end
