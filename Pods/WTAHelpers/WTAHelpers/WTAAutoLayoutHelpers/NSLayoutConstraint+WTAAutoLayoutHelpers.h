//
//  NSLayoutConstraint+WTAAutoLayoutHelpers.h
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

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (WTAAutoLayoutHelpers)

///---------------------------------
/// @name Edge Creating Constraints
///---------------------------------

+ (NSLayoutConstraint *)wta_topConstraintWithView:(UIView *)withView toView:(UIView *)toView offset:(CGFloat)offset;
+ (NSLayoutConstraint *)wta_leadingConstraintWithView:(UIView *)withView toView:(UIView *)toView offset:(CGFloat)offset;
+ (NSLayoutConstraint *)wta_bottomConstraintWithView:(UIView *)withView toView:(UIView *)toView offset:(CGFloat)offset;
+ (NSLayoutConstraint *)wta_trailingConstraintWithView:(UIView *)withView toView:(UIView *)toView offset:(CGFloat)offset;

+ (NSLayoutConstraint *)wta_topConstraintWithView:(UIView *)withView toView:(UIView *)toView offset:(CGFloat)offset relation:(NSLayoutRelation)relation;
+ (NSLayoutConstraint *)wta_leadingConstraintWithView:(UIView *)withView toView:(UIView *)toView offset:(CGFloat)offset relation:(NSLayoutRelation)relation;
+ (NSLayoutConstraint *)wta_bottomConstraintWithView:(UIView *)withView toView:(UIView *)toView offset:(CGFloat)offset relation:(NSLayoutRelation)relation;
+ (NSLayoutConstraint *)wta_trailingConstraintWithView:(UIView *)withView toView:(UIView *)toView offset:(CGFloat)offset relation:(NSLayoutRelation)relation;

///----------------------------------------
/// @name Side-by-Side separation Constraints
///----------------------------------------

+ (NSLayoutConstraint *)wta_trailingToLeadingConstraintWithTrailingView:(UIView *)trailingView leadingView:(UIView *)leadingView separation:(CGFloat)separation;
+ (NSLayoutConstraint *)wta_bottomToTopConstraintWithTopView:(UIView *)topView bottomView:(UIView *)bottomView separation:(CGFloat)separation;

+ (NSLayoutConstraint *)wta_trailingToLeadingConstraintWithTrailingView:(UIView *)trailingView leadingView:(UIView *)leadingView separation:(CGFloat)separation relation:(NSLayoutRelation)relation;
+ (NSLayoutConstraint *)wta_bottomToTopConstraintWithTopView:(UIView *)topView bottomView:(UIView *)bottomView separation:(CGFloat)separation relation:(NSLayoutRelation)relation;

///------------------------------
/// @name Centering Constraints
///------------------------------

+ (NSLayoutConstraint *)wta_horizontallyCenterConstraintWithView:(UIView *)withView toView:(UIView *)toView offset:(CGFloat)offset;
+ (NSLayoutConstraint *)wta_verticallyCenterConstraintWithView:(UIView *)withView toView:(UIView *)toView offset:(CGFloat)offset;

///------------------------
/// @name Size Constraints
///------------------------

+ (NSLayoutConstraint *)wta_heightConstraintWithView:(UIView *)view height:(CGFloat)height;
+ (NSLayoutConstraint *)wta_widthConstraintWithView:(UIView *)view width:(CGFloat)width;

+ (NSLayoutConstraint *)wta_heightConstraintWithView:(UIView *)view height:(CGFloat)height relation:(NSLayoutRelation)relation;
+ (NSLayoutConstraint *)wta_widthConstraintWithView:(UIView *)view width:(CGFloat)width relation:(NSLayoutRelation)relation;

+ (NSLayoutConstraint *)wta_heightConstraintWithView:(UIView *)view toView:(UIView *)toView offset:(CGFloat)offset relation:(NSLayoutRelation)relation;
+ (NSLayoutConstraint *)wta_widthConstraintWithView:(UIView *)view toView:(UIView *)toView offset:(CGFloat)offset relation:(NSLayoutRelation)relation;

@end
