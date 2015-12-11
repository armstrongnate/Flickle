//
//  UIColor+WTAColorHelpers.m
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

#import "UIColor+WTAColorHelpers.h"

@implementation UIColor (WTAColorHelpers)

+ (NSMutableDictionary *)wta_colors
{
    static NSMutableDictionary *_colorDictionary = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _colorDictionary = [NSMutableDictionary new];
    });
    return _colorDictionary;
}

+ (instancetype)wta_colorNamed:(NSString *)colorName
{
    return [[self wta_colors] objectForKey:colorName];
}

+ (void)wta_setColor:(UIColor *)color forName:(NSString *)colorName
{
    NSParameterAssert(colorName);
    if (color == nil)
    {
        [[self wta_colors] removeObjectForKey:colorName];
    }
    else
    {
        [[self wta_colors] setObject:color
                              forKey:colorName];
    }
}

+ (BOOL)wta_setColors:(NSDictionary *)colors
{
    // Validate values
    for (id value in [colors allValues])
    {
        if (![value isKindOfClass:[UIColor class]])
        {
            return NO;
        }
    }
    [[self wta_colors] setValuesForKeysWithDictionary:colors];
    return YES;
}

+ (BOOL)wta_setColorsWithContentsOfFile:(NSString *)path
{
    NSParameterAssert(path != nil);
    NSDictionary *colors = nil;
    if ([[path pathExtension] isEqualToString:@"plist"])
    {
        colors = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    else if ([[path pathExtension] isEqualToString:@"json"])
    {
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfFile:path];
        id dict = [NSJSONSerialization JSONObjectWithData:data
                                                  options:0
                                                    error:&error];
        
        if (!error && [dict isKindOfClass:[NSDictionary class]])
        {
            colors = dict;
        }
    }
    
    if (colors)
    {
        NSMutableDictionary *parsedColors = [NSMutableDictionary new];
        [colors enumerateKeysAndObjectsUsingBlock:^(id key, NSString *obj, BOOL *stop) {
            
            UIColor *color = [self wta_colorWithString:obj];
            [parsedColors setValue:color forKey:key];
            
        }];
        return [self wta_setColors:parsedColors];
    }
    
    return NO;
}

+ (instancetype)wta_colorWithString:(NSString *)colorString
{
    if ([colorString hasPrefix:@"rgb("] || [colorString hasPrefix:@"rgba("])
    {
        return [UIColor wta_colorWithRGBAString:colorString];
    }
    else if ([colorString hasPrefix:@"#"] || [colorString hasPrefix:@"0x"])
    {
        return [UIColor wta_colorWithHexString:colorString];
    }
    
    return nil;
}

+ (instancetype)wta_colorWithHexString:(NSString *)hexString
{
    CGColorRef colorRef = WTACGColorCreateWithHexString(hexString);
    UIColor *color = [UIColor colorWithCGColor:colorRef];
    CGColorRelease(colorRef);
    return color;
}

+ (instancetype)wta_colorWithHexRGB:(NSUInteger)RGB
{
    NSUInteger RGBA = (RGB << 8) | 0xFF;
    return [self wta_colorWithHexRGBA:RGBA];
}

+ (instancetype)wta_colorWithHexRGBA:(NSUInteger)RGBA
{
    CGColorRef colorRef = WTACGColorCreateWithHexRGBA((u_int32_t)RGBA);
    UIColor *color = [UIColor colorWithCGColor:colorRef];
    CGColorRelease(colorRef);
    return color;
}

+ (instancetype)wta_colorWithRGBAString:(NSString *)RGBAString
{
    CGColorRef colorRef = WTACGColorCreateWithRGBAString(RGBAString);
    UIColor *color = [UIColor colorWithCGColor:colorRef];
    CGColorRelease(colorRef);
    return color;
}

+ (instancetype)wta_colorWith8BitRGBAColorComponents:(const CGFloat *)components
{
    CGColorRef colorRef = WTACGColorCreateWith8BitRGBA(components[0],
                                                       components[1],
                                                       components[2],
                                                       components[3]);
    UIColor *color = [UIColor colorWithCGColor:colorRef];
    CGColorRelease(colorRef);
    return color;
}

+ (instancetype)wta_colorWith8BitRed:(CGFloat)red
                               green:(CGFloat)green
                                blue:(CGFloat)blue
                               alpha:(CGFloat)alpha
{
    const CGFloat components[] = {red, green, blue, alpha};
    return [self wta_colorWith8BitRGBAColorComponents:components];
}

- (NSString *)wta_hexStringValue
{
    NSString *hexString = nil;
    CGColorRef colorRef = [self CGColor];
    CGColorSpaceRef spaceRef = CGColorGetColorSpace(colorRef);
    CGColorSpaceRef deviceRGB = CGColorSpaceCreateDeviceRGB();
    if (spaceRef == deviceRGB)
    {
        hexString = @"0x";
        const CGFloat *components = CGColorGetComponents(colorRef);
        size_t count = CGColorGetNumberOfComponents(colorRef);
        for (int index = 0; index < count; index++)
        {
            u_int32_t hex = components[index] * 0xFF;
            NSString *component = [NSString stringWithFormat:@"%02X", hex];
            hexString = [hexString stringByAppendingString:component];
        }
    }
    CGColorSpaceRelease(deviceRGB);
    return hexString;
}

- (NSString *)wta_RGBAStringValue
{
    NSString *RGBAString = nil;
    CGColorRef colorRef = [self CGColor];
    CGColorSpaceRef spaceRef = CGColorGetColorSpace(colorRef);
    CGColorSpaceRef deviceRGB = CGColorSpaceCreateDeviceRGB();
    if (spaceRef == deviceRGB)
    {
        NSMutableArray *components = [NSMutableArray new];
        const CGFloat *colorComponents = CGColorGetComponents(colorRef);
        size_t count = CGColorGetNumberOfComponents(colorRef);
        for (int index = 0; index < count; index++)
        {
           [components addObject:@(colorComponents[index] * 255.0)];
        }
        RGBAString = [NSString stringWithFormat:@"rgba(%@)",
                      [components componentsJoinedByString:@","]];
    }
    CGColorSpaceRelease(deviceRGB);
    return RGBAString;
}

@end

@implementation NSString (WTAColorHelpers)

- (NSString *)wta_hexColorString
{
    NSString *hexString = self;
    if ([hexString hasPrefix:@"#"])
    {
        hexString = [hexString stringByReplacingOccurrencesOfString:@"#"
                                                         withString:@"0x"];
    }
    if ([hexString hasPrefix:@"0x"])
    {
        if ([hexString length] < 10)
        {
            NSString *pattern = [hexString stringByReplacingOccurrencesOfString:@"0x"
                                                                     withString:@""];
            while ([hexString length] < 10) {
                hexString = [hexString stringByAppendingString:pattern];
            }
            
            hexString = [hexString substringToIndex:10];
            hexString = [hexString stringByReplacingCharactersInRange:NSMakeRange(8, 2)
                                                           withString:@"FF"];
        }
        
        return hexString;
    }
    return nil;
}

- (NSArray *)wta_RGBColorComponents
{
    NSString *RGBAString = self;
    NSRange range = [RGBAString rangeOfString:@"("];
    range.location ++;
    range.length = [RGBAString rangeOfString:@")"].location - range.location;
    RGBAString = [RGBAString substringWithRange:range];
    NSArray *components = [RGBAString componentsSeparatedByString:@","];
    if ([components count] == 3)
    {
        components = [components arrayByAddingObject:@"1.0"];
    }
    if ([components count] == 4)
    {
        return components;
    }
    return nil;
}

@end
