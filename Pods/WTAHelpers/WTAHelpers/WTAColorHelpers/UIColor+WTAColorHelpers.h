//
//  UIColor+WTAColorHelpers.h
//  WTAColorHelpers
//
//  Copyright (c) 2015 WillowTree, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <UIKit/UIKit.h>

@interface UIColor (WTAColorHelpers)

+ (instancetype)wta_colorNamed:(NSString *)colorName;

+ (void)wta_setColor:(UIColor *)color forName:(NSString *)colorName;
+ (BOOL)wta_setColors:(NSDictionary *)colors;
+ (BOOL)wta_setColorsWithContentsOfFile:(NSString *)path;

+ (instancetype)wta_colorWithString:(NSString *)colorString;
+ (instancetype)wta_colorWithHexString:(NSString *)hexString; // #f2f2f2, 0xcbcbcbff
+ (instancetype)wta_colorWithHexRGB:(NSUInteger)RGB;
+ (instancetype)wta_colorWithHexRGBA:(NSUInteger)RGBA;
+ (instancetype)wta_colorWithRGBAString:(NSString *)RGBAString; // rgba(0.0, 0.0, 0.0, 0.0)
+ (instancetype)wta_colorWith8BitRGBAColorComponents:(const CGFloat *)components;
+ (instancetype)wta_colorWith8BitRed:(CGFloat)red
                           green:(CGFloat)green
                            blue:(CGFloat)blue
                           alpha:(CGFloat)alpha;

- (NSString *)wta_hexStringValue;
- (NSString *)wta_RGBAStringValue;

@end

@interface NSString (WTAColorHelpers)

- (NSString *)wta_hexColorString;
- (NSArray *)wta_RGBColorComponents;

@end

CG_INLINE CGColorRef WTACGColorCreateWith8BitRGBA(CGFloat r, CGFloat g, CGFloat b, CGFloat a)
{
    const CGFloat components[] = {(r / 255.0), (g / 255.0), (b / 255.0), a};
    CGColorSpaceRef spaceRef = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorRef = CGColorCreate(spaceRef, components);
    CGColorSpaceRelease(spaceRef);
    return colorRef;
}

CG_INLINE CGColorRef WTACGColorCreateWithHexRGBA(u_int32_t RBGA)
{
    return WTACGColorCreateWith8BitRGBA(((RBGA & 0xFF000000) >> 24),
                                     ((RBGA & 0xFF0000) >> 16),
                                     ((RBGA & 0xFF00) >> 8),
                                     (RBGA & 0xFF));
}

CG_INLINE CGColorRef WTACGColorCreateWithHexString(NSString *hexString)
{
    hexString = [hexString wta_hexColorString];
    if (hexString != nil)
    {
        unsigned int RGBA = 0x0;
        [[NSScanner scannerWithString:hexString] scanHexInt:&RGBA];
        return WTACGColorCreateWithHexRGBA(RGBA);
    }
    return NULL;
}

CG_INLINE CGColorRef WTACGColorCreateWithRGBAString(NSString *RGBAString)
{
    NSArray *components = [RGBAString wta_RGBColorComponents];
    if ([components count] == 4)
    {
        return WTACGColorCreateWith8BitRGBA([components[0] floatValue],
                                            [components[1] floatValue],
                                            [components[2] floatValue],
                                            [components[3] floatValue]);
    }
    
    return NULL;
}
