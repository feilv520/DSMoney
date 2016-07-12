//
//  UIColor+AddColor.m
//  FlatUI
//
//  Created by lzhr on 5/3/13.
//  Copyright (c) 2013 lzhr. All rights reserved.
//

#import "UIColor+AddColor.h"

@implementation UIColor (AddColor)


+ (UIColor *) colorFromHexCode:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *) ngaBackColor
{
    return [UIColor colorWithRed:253.0f/255.0f green:243.0f/255.0f blue:216.0f/255.0f alpha:1];
}

+ (UIColor *) ngaDarkColor
{
    return [UIColor colorWithRed:249.0f/255.0f green:238.0f/255.0f blue:167.0f/255.0f alpha:1];
}

+ (UIColor *) turquoiseColor {
    return [UIColor colorFromHexCode:@"1ABC9C"];
}

+ (UIColor *) greenSeaColor {
    return [UIColor colorFromHexCode:@"16A085"];
}

+ (UIColor *) emerlandColor {
    return [UIColor colorFromHexCode:@"2ECC71"];
}

+ (UIColor *) nephritisColor {
    return [UIColor colorFromHexCode:@"27AE60"];
}

+ (UIColor *) peterRiverColor {
    return [UIColor colorFromHexCode:@"3498DB"];
}

+ (UIColor *) belizeHoleColor {
    return [UIColor colorFromHexCode:@"2980B9"];
}

+ (UIColor *) amethystColor {
    return [UIColor colorFromHexCode:@"9B59B6"];
}

+ (UIColor *) wisteriaColor {
    return [UIColor colorFromHexCode:@"8E44AD"];
}

+ (UIColor *) wetAsphaltColor {
    return [UIColor colorFromHexCode:@"34495E"];
}

+ (UIColor *) midnightBlueColor {
    return [UIColor colorFromHexCode:@"2C3E50"];
}

+ (UIColor *) sunflowerColor {
    return [UIColor colorFromHexCode:@"F1C40F"];
}

+ (UIColor *) tangerineColor {
    return [UIColor colorFromHexCode:@"63B8FF"];
}

+ (UIColor *) carrotColor {
    return [UIColor colorFromHexCode:@"E67E22"];
}

+ (UIColor *) pumpkinColor {
    return [UIColor colorFromHexCode:@"D35400"];
}

+ (UIColor *) alizarinColor {
    return [UIColor colorFromHexCode:@"E74C3C"];
}

+ (UIColor *) pomegranateColor {
    return [UIColor colorFromHexCode:@"C0392B"];
}

+ (UIColor *) cloudsColor {
    return [UIColor colorFromHexCode:@"ECF0F1"];
}

+ (UIColor *) silverColor {
    return [UIColor colorFromHexCode:@"BDC3C7"];
}

+ (UIColor *) concreteColor {
    return [UIColor colorFromHexCode:@"95A5A6"];
}

+ (UIColor *) asbestosColor {
    return [UIColor colorFromHexCode:@"7F8C8D"];
}

+ (UIColor *) huiseColor {
    return [UIColor colorFromHexCode:@"ECF0F1"];
}

+ (UIColor *) shenhuiseColor{
    return [UIColor colorFromHexCode:@"#46485f"];
}

+ (UIColor *) tiankonglan {
    return [UIColor colorFromHexCode:@"56ABE4"];
}

+ (UIColor *) hongse {
    return [UIColor colorFromHexCode:@"FF0000"];
}

+ (UIColor *) anheiColor {
    return [UIColor colorFromHexCode:@"404040"];
}

+ (UIColor *) qing {
    return [UIColor colorFromHexCode:@"009ad6"];
}

+ (UIColor *) miganse {
    return [UIColor colorFromHexCode:@"#d5c59f"];
}

+ (UIColor *) huibai {
    return [UIColor colorFromHexCode:@"#f4f4f5"];
}

+ (UIColor *) qianhuise {
    return [UIColor colorFromHexCode:@"#f7fafb"];
}

+ (UIColor *) zitihui {
    return [UIColor colorFromHexCode:@"#75777d"];
}

+ (UIColor *) daohanglan {
    return [UIColor colorFromHexCode:@"#df4a43"];
}

+ (UIColor *) progressBackColor {
    return [UIColor colorFromHexCode:@"#e6e9ed"];
}

+ (UIColor *) progressColor {
    return [UIColor colorFromHexCode:@"#fc6e51"];
}

+ (UIColor *) shurukuangColor {
    return [UIColor colorFromHexCode:@"#f9f9f9"];
}

+ (UIColor *) shurukuangBian {
    return [UIColor colorFromHexCode:@"#2493e7"];
}

+ (UIColor *) yuanColor {
    return [UIColor colorFromHexCode:@"#8f9195"];
}

+ (UIColor *) chongzhiColor {
    return [UIColor colorFromHexCode:@"#1ba7f7"];
}

+ (UIColor *) jinse {
    return [UIColor colorFromHexCode:@"#c8a779"];
}

+ (UIColor *) monkeyRules {
    return [UIColor colorFromHexCode:@"#7f97b1"];
}

+ (UIColor *) profitGreen {
    return [UIColor colorFromHexCode:@"#87d196"];
}

+ (UIColor *) jisuanqiHui {
    return [UIColor colorFromHexCode:@"#4e5863"];
}

+ (UIColor *) biankuangse {
    return [UIColor colorFromHexCode:@"#e1e3e5"];
}

+ (UIColor *) blackZiTi {
    return [UIColor colorFromHexCode:@"#434a54"];
}

+ (UIColor *) ZiTiColor {
    return [UIColor colorFromHexCode:@"#626571"];
}

+ (UIColor *) profitColor {
    return [UIColor colorFromHexCode:@"#2493e7"];
}

+ (UIColor *) tequanColor {
    return [UIColor colorFromHexCode:@"#fbc34a"];
}

+ (UIColor *) findZiTiColor {
    return [UIColor colorFromHexCode:@"#8c909d"];
}

+ (UIColor *) moneyColor {
    return [UIColor colorFromHexCode:@"#5f6d7b"];
}

+ (UIColor *) orangecolor {
    return [UIColor colorFromHexCode:@"#ff721f"];
}

+ (UIColor *) fastZhuCeolor {
    return [UIColor colorFromHexCode:@"#d5edff"];
}

+ (UIColor *) quanColor {
    return [UIColor colorFromHexCode:@"#e5e5e5"];
}

+ (UIColor *) redBagBankColor {
    return [UIColor colorFromHexCode:@"#dbf0ff"];
}

+ (UIColor *) lineColor {
    return [UIColor colorFromHexCode:@"#e1e3e5"];
}

+ (UIColor *) changeColor {
    return [UIColor colorFromHexCode:@"#d6edff"];
}

+ (UIColor *) friendAlert {
    return [UIColor colorFromHexCode:@"#858585"];
}

+ (UIColor *) backColor {
    return [UIColor colorFromHexCode:@"#e1edf6"];
}

+ (UIColor *) alertColor {
    return [UIColor colorFromHexCode:@"#75777d"];
}

+ (UIColor *) pictureColor {
    return [UIColor colorFromHexCode:@"#93d0ff"];
}

@end
