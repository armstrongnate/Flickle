//
//  UIView+WTAAutoLayoutHelpers.m
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

#import "UIView+WTAAutoLayoutHelpers.h"
#import "NSLayoutConstraint+WTAAutoLayoutHelpers.h"

static BOOL __wta_automaticallySetAutoTranslatesAutoresizingMasksToOff = NO;

@implementation UIView (WTAAutoLayoutHelpers)

#pragma mark - Convenience Constructors

+ (id)wta_autolayoutView;
{
    id view = [self new];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    return view;
}

#pragma mark - Automatically Setting TranslatesAutoresizingMasksIntoConstraints

+ (void)wta_setAutomaticallySetAutoTranslatesAutoresizingMasksToOff:(BOOL)autoOff
{
    __wta_automaticallySetAutoTranslatesAutoresizingMasksToOff = autoOff;
}

+ (BOOL)wta_automaticallySetAutoTranslatesAutoresizingMasksToOff
{
    return __wta_automaticallySetAutoTranslatesAutoresizingMasksToOff;
}

- (void)wta_setTranslatesAutoresizingMasksIntoConstraintsIfNeeded
{
    if ([UIView wta_automaticallySetAutoTranslatesAutoresizingMasksToOff])
    {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
}

#pragma mark - Edge Constraints to Superview

- (NSArray *)wta_addEdgeConstraintsToSuperview:(UIEdgeInsets)inset
{
    NSLayoutConstraint *topConstraint = [self wta_addTopConstraintToSuperviewOffset:inset.top];
    NSLayoutConstraint *leadingConstraint = [self wta_addLeadingConstraintToSuperviewOffset:inset.left];
    NSLayoutConstraint *bottomConstraint = [self wta_addBottomConstraintToSuperviewOffset:inset.bottom];
    NSLayoutConstraint *trailingConstraint = [self wta_addTrailingConstraintToSuperviewOffset:inset.right];
    
    return @[topConstraint, leadingConstraint, bottomConstraint, trailingConstraint];
}

- (NSLayoutConstraint *)wta_addLeadingConstraintToSuperviewOffset:(CGFloat)offset
{
    return [self wta_addLeadingConstraintToSuperviewOffset:offset relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)wta_addLeadingConstraintToSuperviewOffset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    return [self wta_addLeadingConstraintToView:[self superview] offset:offset relation:relation];
}

- (NSLayoutConstraint *)wta_addTrailingConstraintToSuperviewOffset:(CGFloat)offset
{
    return [self wta_addTrailingConstraintToSuperviewOffset:offset relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)wta_addTrailingConstraintToSuperviewOffset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    return [self wta_addTrailingConstraintToView:[self superview] offset:offset relation:relation];
}

- (NSLayoutConstraint *)wta_addTopConstraintToSuperviewOffset:(CGFloat)offset
{
    return [self wta_addTopConstraintToSuperviewOffset:offset relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)wta_addTopConstraintToSuperviewOffset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    return [self wta_addTopConstraintToView:[self superview] offset:offset relation:relation];
}

- (NSLayoutConstraint *)wta_addBottomConstraintToSuperviewOffset:(CGFloat)offset
{
    return [self wta_addBottomConstraintToSuperviewOffset:offset relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)wta_addBottomConstraintToSuperviewOffset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    return [self wta_addBottomConstraintToView:[self superview] offset:offset relation:relation];
}

#pragma mark - Align Edges for Sibling Views

- (NSLayoutConstraint *)wta_addLeadingConstraintToView:(UIView *)toView offset:(CGFloat)offset
{
    return [self wta_addLeadingConstraintToView:toView offset:offset relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)wta_addLeadingConstraintToView:(UIView *)toView offset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint wta_leadingConstraintWithView:self toView:toView offset:offset relation:relation];
    [self wta_setTranslatesAutoresizingMasksIntoConstraintsIfNeeded];
    [[self superview] addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)wta_addTrailingConstraintToView:(UIView *)toView offset:(CGFloat)offset
{
    return [self wta_addTrailingConstraintToView:toView offset:offset relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)wta_addTrailingConstraintToView:(UIView *)toView offset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint wta_trailingConstraintWithView:self toView:toView offset:offset relation:relation];
    [self wta_setTranslatesAutoresizingMasksIntoConstraintsIfNeeded];
    [[self superview] addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)wta_addTopConstraintToView:(UIView *)toView offset:(CGFloat)offset
{
    return [self wta_addTopConstraintToView:toView offset:offset relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)wta_addTopConstraintToView:(UIView *)toView offset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint wta_topConstraintWithView:self toView:toView offset:offset relation:relation];
    [self wta_setTranslatesAutoresizingMasksIntoConstraintsIfNeeded];
    [[self superview] addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)wta_addBottomConstraintToView:(UIView *)toView offset:(CGFloat)offset
{
    return [self wta_addBottomConstraintToView:toView offset:offset relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)wta_addBottomConstraintToView:(UIView *)toView offset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint wta_bottomConstraintWithView:self toView:toView offset:offset relation:relation];
    [[self superview] addConstraint:constraint];
    return constraint;
}

#pragma mark - Placing Sibling Views Adjacent to Eachother

- (NSLayoutConstraint *)wta_addConstraintPlacingViewRightOfView:(UIView *)view separation:(CGFloat)separation
{
    return [self wta_addConstraintPlacingViewRightOfView:view separation:separation relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)wta_addConstraintPlacingViewRightOfView:(UIView *)view separation:(CGFloat)separation relation:(NSLayoutRelation)relation
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint wta_trailingToLeadingConstraintWithTrailingView:self
                                                                                             leadingView:view
                                                                                              separation:separation
                                                                                                relation:relation];
    [self wta_setTranslatesAutoresizingMasksIntoConstraintsIfNeeded];
    [[self superview] addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)wta_addConstraintPlacingViewLeftOfView:(UIView *)view separation:(CGFloat)separation
{
    return [self wta_addConstraintPlacingViewLeftOfView:view separation:separation relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)wta_addConstraintPlacingViewLeftOfView:(UIView *)view separation:(CGFloat)separation relation:(NSLayoutRelation)relation
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint wta_trailingToLeadingConstraintWithTrailingView:view
                                                                                             leadingView:self
                                                                                              separation:separation
                                                                                                relation:relation];
    [self wta_setTranslatesAutoresizingMasksIntoConstraintsIfNeeded];
    [[self superview] addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)wta_addConstraintPlacingViewAboveView:(UIView *)view separation:(CGFloat)separation
{
    return [self wta_addConstraintPlacingViewAboveView:view separation:separation relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)wta_addConstraintPlacingViewAboveView:(UIView *)view separation:(CGFloat)separation relation:(NSLayoutRelation)relation
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint wta_bottomToTopConstraintWithTopView:self
                                                                                   bottomView:view
                                                                                   separation:separation
                                                                                     relation:relation];
    [[self superview] addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)wta_addConstraintPlacingViewBelowView:(UIView *)view separation:(CGFloat)separation
{
    return [self wta_addConstraintPlacingViewBelowView:view separation:separation relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)wta_addConstraintPlacingViewBelowView:(UIView *)view separation:(CGFloat)separation relation:(NSLayoutRelation)relation
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint wta_bottomToTopConstraintWithTopView:view
                                                                                   bottomView:self
                                                                                   separation:separation
                                                                                     relation:relation];
    [self wta_setTranslatesAutoresizingMasksIntoConstraintsIfNeeded];
    [[self superview] addConstraint:constraint];
    return constraint;
}

#pragma mark - Centering Constraints

- (NSArray *)wta_addCenteringConstraintToSuperview
{
    return [self wta_addCenteringConstraintToSuperviewOffset:CGPointZero];
}

- (NSArray *)wta_addCenteringConstraintToSuperviewOffset:(CGPoint)offset
{
    NSLayoutConstraint *verticalConstraint = [self wta_addVerticallyCenterConstraintToSuperviewOffset:offset.y];
    NSLayoutConstraint *horizontalConstraint = [self wta_addHorizontallyCenterConstraintToSuperviewOffset:offset.x];
    
    return @[verticalConstraint, horizontalConstraint];
}

- (NSLayoutConstraint *)wta_addVerticallyCenterConstraintToSuperview
{
    return [self wta_addVerticallyCenterConstraintToSuperviewOffset:0.0];
}

- (NSLayoutConstraint *)wta_addHorizontallyCenterConstraintToSuperview
{
    return [self wta_addHorizontallyCenterConstraintToSuperviewOffset:0.0];
}

- (NSLayoutConstraint *)wta_addVerticallyCenterConstraintToSuperviewOffset:(CGFloat)offset
{
    return [self wta_addVerticallyCenterConstraintToView:[self superview] offset:offset];
}

- (NSLayoutConstraint *)wta_addHorizontallyCenterConstraintToSuperviewOffset:(CGFloat)offset
{
    return [self wta_addHorizontallyCenterConstraintToView:[self superview] offset:offset];
}

- (NSLayoutConstraint *)wta_addHorizontallyCenterConstraintToView:(UIView *)toView offset:(CGFloat)offset;
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint wta_horizontallyCenterConstraintWithView:self
                                                                                           toView:toView
                                                                                           offset:offset];
    [self wta_setTranslatesAutoresizingMasksIntoConstraintsIfNeeded];
    [[self superview] addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)wta_addVerticallyCenterConstraintToView:(UIView *)toView offset:(CGFloat)offset
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint wta_verticallyCenterConstraintWithView:self
                                                                                         toView:toView
                                                                                         offset:offset];
    [self wta_setTranslatesAutoresizingMasksIntoConstraintsIfNeeded];
    [[self superview] addConstraint:constraint];
    return constraint;
}

#pragma mark - Size Constraints

- (NSArray *)wta_addSizeConstraints:(CGSize)size
{
    NSLayoutConstraint *widthConstraint = [self wta_addWidthConstraint:size.width];
    NSLayoutConstraint *heightConstraint = [self wta_addHeightConstraint:size.height];

    return @[heightConstraint, widthConstraint];
}

- (NSLayoutConstraint *)wta_addHeightConstraint:(CGFloat)height
{
    return [self wta_addHeightConstraint:height relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)wta_addHeightConstraint:(CGFloat)height relation:(NSLayoutRelation)relation
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint wta_heightConstraintWithView:self
                                                                               height:height
                                                                             relation:relation];
    [self wta_setTranslatesAutoresizingMasksIntoConstraintsIfNeeded];
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)wta_addWidthConstraint:(CGFloat)width
{
    return [self wta_addWidthConstraint:width relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)wta_addWidthConstraint:(CGFloat)width relation:(NSLayoutRelation)relation
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint wta_widthConstraintWithView:self
                                                                               width:width
                                                                            relation:relation];
    
    [self wta_setTranslatesAutoresizingMasksIntoConstraintsIfNeeded];
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)wta_addWidthConstraintToSuperView
{
    return [self wta_addWidthConstraintToSuperViewOffset:0];
}

- (NSLayoutConstraint *)wta_addWidthConstraintToSuperViewOffset:(CGFloat)offset
{
    return [self wta_addWidthConstraintToSuperViewOffset:offset relation:NSLayoutRelationEqual];

}

- (NSLayoutConstraint *)wta_addWidthConstraintToSuperViewOffset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    return [self wta_addWidthConstraintToView:self.superview offset:offset relation:relation];
}

- (NSLayoutConstraint *)wta_addWidthConstraintToView:(UIView *)toView
{
    return [self wta_addWidthConstraintToView:toView offset:0];

}

- (NSLayoutConstraint *)wta_addWidthConstraintToView:(UIView *)toView offset:(CGFloat)offset
{
    return [self wta_addWidthConstraintToView:toView offset:0 relation:NSLayoutRelationEqual];

}

- (NSLayoutConstraint *)wta_addWidthConstraintToView:(UIView *)toView offset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint wta_widthConstraintWithView:self
                                                                              toView:toView
                                                                              offset:offset
                                                                            relation:relation];
    [self wta_setTranslatesAutoresizingMasksIntoConstraintsIfNeeded];
    [toView addConstraint:constraint];
    
    return constraint;
}

- (NSLayoutConstraint *)wta_addHeightConstraintToSuperView
{
    return [self wta_addHeightConstraintToSuperViewOffset:0];
}

- (NSLayoutConstraint *)wta_addHeightConstraintToSuperViewOffset:(CGFloat)offset
{
    return [self wta_addHeightConstraintToSuperViewOffset:0 relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)wta_addHeightConstraintToSuperViewOffset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    return [self wta_addHeightConstraintToView:self.superview offset:0 relation:relation];
}

- (NSLayoutConstraint *)wta_addHeightConstraintToView:(UIView *)toView
{
    return [self wta_addHeightConstraintToView:toView offset:0];
}

- (NSLayoutConstraint *)wta_addHeightConstraintToView:(UIView *)toView offset:(CGFloat)offset
{
    return [self wta_addHeightConstraintToView:toView offset:offset relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)wta_addHeightConstraintToView:(UIView *)toView offset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint wta_heightConstraintWithView:self
                                                                               toView:toView
                                                                               offset:offset
                                                                             relation:relation];
    [self wta_setTranslatesAutoresizingMasksIntoConstraintsIfNeeded];
    [toView addConstraint:constraint];
    
    return constraint;
}

@end
