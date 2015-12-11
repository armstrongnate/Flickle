//
//  UIView+WTAFrameHelpers.m
//  WTALayoutHelpers
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

#import "UIView+WTAFrameHelpers.h"

@implementation UIView (WTAFrameHelpers)

#pragma mark - Convenience Frame Getters

- (CGSize)wta_frameSize
{
    CGRect frame = [self frame];
    return frame.size;
}

- (CGFloat)wta_frameSizeWidth
{
    CGRect frame = [self frame];
    return frame.size.width;
}

- (CGFloat)wta_frameSizeHeight
{
    CGRect frame = [self frame];
    return frame.size.height;
}

- (CGPoint)wta_frameOrigin
{
    CGRect frame = [self frame];
    return frame.origin;
}

- (CGFloat)wta_frameOriginX
{
    CGRect frame = [self frame];
    return frame.origin.x;
}

- (CGFloat)wta_frameOriginY
{
    CGRect frame = [self frame];
    return frame.origin.y;
}

#pragma mark - Convenience Frame Setters

- (void)wta_setFrameSize:(CGSize)size
{
    CGRect frame = [self frame];
    frame.size = size;
    [self setFrame:frame];
}

- (void)wta_setFrameSizeHeight:(CGFloat)height
{
    CGRect frame = [self frame];
    frame.size.height = height;
    [self setFrame:frame];
}

- (void)wta_setFrameSizeWidth:(CGFloat)width
{
    CGRect frame = [self frame];
    frame.size.width = width;
    [self setFrame:frame];
}

- (void)wta_setFrameOrigin:(CGPoint)origin
{
    CGRect frame = [self frame];
    frame.origin = origin;
    [self setFrame:frame];
}

- (void)wta_setFrameOriginX:(CGFloat)x
{
    CGRect frame = [self frame];
    frame.origin.x = x;
    [self setFrame:frame];
}

- (void)wta_setFrameOriginY:(CGFloat)y
{
    CGRect frame = [self frame];
    frame.origin.y = y;
    [self setFrame:frame];
}

#pragma mark - Convenience Objective-C CGRectGet* Methods

- (CGFloat)wta_frameMinX
{
    CGRect frame = [self frame];
    return CGRectGetMinX(frame);
}

- (CGFloat)wta_frameMinY
{
    CGRect frame = [self frame];
    return CGRectGetMinY(frame);
}

- (CGFloat)wta_frameMidX
{
    CGRect frame = [self frame];
    return CGRectGetMidX(frame);
}

- (CGFloat)wta_frameMidY
{
    CGRect frame = [self frame];
    return CGRectGetMidY(frame);
}

- (CGFloat)wta_frameMaxX
{
    CGRect frame = [self frame];
    return CGRectGetMaxX(frame);
}

- (CGFloat)wta_frameMaxY
{
    CGRect frame = [self frame];
    return CGRectGetMaxY(frame);
}

#pragma mark - Edge Alignment Methods For a Given View

- (void)wta_topAlignInView:(UIView *)view
{
    [self wta_topAlignInView:view offset:0.0f];
}

- (void)wta_leftAlignInView:(UIView *)view
{
    [self wta_leftAlignInView:view offset:0.0f];
}

- (void)wta_bottomAlignInView:(UIView *)view
{
    [self wta_bottomAlignInView:view offset:0.0f];
}

- (void)wta_rightAlignInView:(UIView *)view
{
    [self wta_rightAlignInView:view offset:0.0f];
}

- (void)wta_topAlignInView:(UIView *)view offset:(CGFloat)offset
{
    [self wta_setFrameOriginY:offset];
}

- (void)wta_leftAlignInView:(UIView *)view offset:(CGFloat)offset
{
    [self wta_setFrameOriginX:offset];
}

- (void)wta_bottomAlignInView:(UIView *)view offset:(CGFloat)offset
{
    CGFloat y = [view wta_frameSizeHeight] - [self wta_frameSizeHeight] - offset;
    [self wta_setFrameOriginY:y];
}

- (void)wta_rightAlignInView:(UIView *)view offset:(CGFloat)offset
{
    CGFloat x = [view wta_frameSizeWidth] - [self wta_frameSizeWidth] - offset;
    [self wta_setFrameOriginX:x];
}

#pragma mark - Edge Alignment Methods For Superview

- (void)wta_topAlignInSuperview
{
    [self wta_topAlignInView:[self superview]];
}

- (void)wta_leftAlignInSuperview
{
    [self wta_leftAlignInView:[self superview]];
}

- (void)wta_bottomAlignInSuperview
{
    [self wta_bottomAlignInView:[self superview]];
}

- (void)wta_rightAlignInSuperview
{
    [self wta_rightAlignInView:[self superview]];
}

- (void)wta_topAlignInSuperviewOffset:(CGFloat)offset
{
    [self wta_topAlignInView:[self superview] offset:offset];
}

- (void)wta_leftAlignInSuperviewOffset:(CGFloat)offset
{
    [self wta_leftAlignInView:[self superview] offset:offset];
}

- (void)wta_bottomAlignInSuperviewOffset:(CGFloat)offset
{
    [self wta_bottomAlignInView:[self superview] offset:offset];
}

- (void)wta_rightAlignInSuperviewOffset:(CGFloat)offset
{
    [self wta_rightAlignInView:[self superview] offset:offset];
}

#pragma mark - Centering Methods in a View

- (void)wta_centerAlignInView:(UIView *)view
{
    [self wta_centerAlignInView:view offset:CGPointZero];
}

- (void)wta_centerAlignVerticallyInView:(UIView *)view
{
    [self wta_centerAlignVerticallyInView:view offset:0.0f];
}

- (void)wta_centerAlignHorizontallyInView:(UIView *)view
{
    [self wta_centerAlignHorizontallyInView:view offset:0.0f];
}

- (void)wta_centerAlignInView:(UIView *)view offset:(CGPoint)offset
{
    [self wta_centerAlignHorizontallyInView:view offset:offset.x];
    [self wta_centerAlignVerticallyInView:view offset:offset.y];
}

- (void)wta_centerAlignVerticallyInView:(UIView *)view offset:(CGFloat)offset
{
    CGFloat y = roundf(([view wta_frameSizeHeight] - [self wta_frameSizeHeight])/2.0f) + offset;
    [self wta_setFrameOriginY:y];
}

- (void)wta_centerAlignHorizontallyInView:(UIView *)view offset:(CGFloat)offset
{
    CGFloat x = roundf(([view wta_frameSizeWidth] - [self wta_frameSizeWidth])/2.0f) + offset;
    [self wta_setFrameOriginX:x];
}

#pragma mark - Centering Methods in its Superview

- (void)wta_centerAlignInSuperview
{
    [self wta_centerAlignInView:[self superview]];
}

- (void)wta_centerAlignVerticallyInSuperview
{
    [self wta_centerAlignVerticallyInView:[self superview]];
}

- (void)wta_centerAlignHorizontallyInSuperview
{
    [self wta_centerAlignHorizontallyInView:[self superview]];
}

- (void)wta_centerAlignInSuperviewOffset:(CGPoint)offset
{
    [self wta_centerAlignInView:[self superview] offset:offset];
}

- (void)wta_centerAlignVerticallyInSuperviewOffset:(CGFloat)offset
{
    [self wta_centerAlignVerticallyInView:[self superview] offset:offset];
}

- (void)wta_centerAlignHorizontallyInSuperviewOffset:(CGFloat)offset
{
    [self wta_centerAlignHorizontallyInView:[self superview] offset:offset];
}

#pragma mark - @name Placing Views Next to Sibling Views

- (void)wta_setFrameOriginXRightOfView:(UIView *)view;
{
    [self wta_setFrameOriginXRightOfView:view offset:0.0];
}

- (void)wta_setFrameOriginXRightOfView:(UIView *)view offset:(CGFloat)offset;
{
    [self wta_setFrameOriginX:[view wta_frameOriginX] + [view wta_frameSizeWidth] + offset];
}

- (void)wta_setFrameOriginXLeftOfView:(UIView *)view;
{
    [self wta_setFrameOriginXLeftOfView:view offset:0.0];
}

- (void)wta_setFrameOriginXLeftOfView:(UIView *)view offset:(CGFloat)offset;
{
    [self wta_setFrameOriginX:[view wta_frameOriginX] - [self wta_frameSizeWidth] - offset];
}

- (void)wta_setFrameOriginYBelowView:(UIView *)view;
{
    [self wta_setFrameOriginYBelowView:view offset:0.0];
}

- (void)wta_setFrameOriginYBelowView:(UIView *)view offset:(CGFloat)offset;
{
    [self wta_setFrameOriginY:[view wta_frameOriginY] + [view wta_frameSizeHeight] + offset];
}

- (void)wta_setFrameOriginYAboveView:(UIView *)view;
{
    [self wta_setFrameOriginYAboveView:view offset:0.0];
}

- (void)wta_setFrameOriginYAboveView:(UIView *)view offset:(CGFloat)offset;
{
    [self wta_setFrameOriginY:[view wta_frameOriginY] - [self wta_frameSizeHeight] - offset];
}

@end
