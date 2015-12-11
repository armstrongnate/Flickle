//
//  UIView+WTANibLoading.m
//  WTAHelpers
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

#import "UIView+WTANibLoading.h"

@implementation UIView (WTANibLoading)

+ (UINib *)wta_nibNamed:(NSString *)nibName
{
    return [UINib nibWithNibName:nibName bundle:nil];
}

+ (UINib *)wta_nib
{
    NSString* className = NSStringFromClass([self class]);
    NSString *file = [[NSBundle mainBundle] pathForResource:className ofType:@"nib"];
    if (file) {
        return [self wta_nibNamed:className];
    }
    
    className = [[className componentsSeparatedByString:@"."] lastObject];
    file = [[NSBundle mainBundle] pathForResource:className ofType:@"nib"];
    
    if (file) {
        return [self wta_nibNamed:className];
    }
    
    return nil;
}

+ (instancetype)wta_loadInstanceWithNib:(UINib *)nib
{
    UIView *result = nil;
    NSArray *topLevelObjects = [nib instantiateWithOwner:nil options:nil];
    for (id anObject in topLevelObjects)
    {
        if ([anObject isKindOfClass:[self class]])
        {
            result = anObject;
            break;
        }
    }
    
    return result;
}

+ (instancetype)wta_loadInstanceFromNib
{
    return [self wta_loadInstanceWithNib:[self wta_nib]];
}

@end
