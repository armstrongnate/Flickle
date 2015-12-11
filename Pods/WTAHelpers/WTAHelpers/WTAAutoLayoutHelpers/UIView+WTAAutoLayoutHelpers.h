//
//  UIView+WTAAutoLayoutHelpers.h
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

#import <UIKit/UIKit.h>

@interface UIView (WTAAutoLayoutHelpers)

///---------------------------------
/// @name Convenience Constructors
///---------------------------------

/**
 Method to create a view with translatesAutoresizingMasks set to NO. 
 
 @return The newly created view.
 */
+ (id)wta_autolayoutView;

///------------------------------------------------------------------------
/// @name Automatically Setting TranslatesAutoresizingMasksIntoConstraints
///------------------------------------------------------------------------

/**
 Method to automatically set translatesAutoresizingMasks to NO when WTAAutoLayoutHelper constraints are added. If this is set to NO, the view's existing value for translatesAutoresizingMasks wil be used.
 @param autoOff whether translatesAutoresizingMasks should be set to NO.
 */
+ (void)wta_setAutomaticallySetAutoTranslatesAutoresizingMasksToOff:(BOOL)autoOff;

/**
 @return whether translatesAutoresizingMasks should be set to NO.
 */
+ (BOOL)wta_automaticallySetAutoTranslatesAutoresizingMasksToOff;

///--------------------------------------------------
/// @name Edge Constraints to Superview
///--------------------------------------------------

/**
 Creates Top, Leading, Bottom and Trailing constraints with inset. The constraints are added to the view's superview.
 
 @param inset for the constraints.
 @return array of constraints
 */
- (NSArray *)wta_addEdgeConstraintsToSuperview:(UIEdgeInsets)inset;

/**
 Creates a leading constraint to the current view with offset. The constraint is added the view's superview
 
 @param offset from the edge.
 @param relation of the offset.
 @return The newly added constraint.
 */
- (NSLayoutConstraint *)wta_addLeadingConstraintToSuperviewOffset:(CGFloat)offset;
- (NSLayoutConstraint *)wta_addLeadingConstraintToSuperviewOffset:(CGFloat)offset relation:(NSLayoutRelation)relation;

/**
 Creates a trailing constraint to the current view with offset. The constraint is added the view's superview.
 
 @param offset from the edge.
 @param relation of the offset.
 @return The newly added constraint.
 */
- (NSLayoutConstraint *)wta_addTrailingConstraintToSuperviewOffset:(CGFloat)offset;
- (NSLayoutConstraint *)wta_addTrailingConstraintToSuperviewOffset:(CGFloat)offset relation:(NSLayoutRelation)relation;

/**
 Creates a top constraint to the current view with offset. The constraint is added the view's superview.
 
 @param offset from the edge.
 @param relation of the offset.
 @return The newly added constraint.
 */
- (NSLayoutConstraint *)wta_addTopConstraintToSuperviewOffset:(CGFloat)offset;
- (NSLayoutConstraint *)wta_addTopConstraintToSuperviewOffset:(CGFloat)offset relation:(NSLayoutRelation)relation;

/**
 Creates a bottom constraint to the current view with offset. The constraint is added the view's superview.
 
 @param offset from the edge.
 @param relation of the offset.
 @return The newly added constraint.
 */
- (NSLayoutConstraint *)wta_addBottomConstraintToSuperviewOffset:(CGFloat)offset;
- (NSLayoutConstraint *)wta_addBottomConstraintToSuperviewOffset:(CGFloat)offset relation:(NSLayoutRelation)relation;

///-------------------------------------
/// @name Align Edges for Sibling Views
///-------------------------------------

/**
 Aligns leading edge of view with another view. The constraint is added to the view's superview.
 
 @param withView View that will be effected by the constraint.
 @param offset between the withView and toView.
 @param relation of the offset.
 @return The newly added constraint.
 */
- (NSLayoutConstraint *)wta_addLeadingConstraintToView:(UIView *)toView offset:(CGFloat)offset;
- (NSLayoutConstraint *)wta_addLeadingConstraintToView:(UIView *)toView offset:(CGFloat)offset relation:(NSLayoutRelation)relation;

/**
 Aligns trailing edge of a view with another view. The constraint is added to the view's superview.
 
 @param toView View that the constraint is related to.
 @param offset from the edge.
 @param relation of the offset.
 @return The newly added constraint.
 */
- (NSLayoutConstraint *)wta_addTrailingConstraintToView:(UIView *)toView offset:(CGFloat)offset;
- (NSLayoutConstraint *)wta_addTrailingConstraintToView:(UIView *)toView offset:(CGFloat)offset relation:(NSLayoutRelation)relation;

/**
 Aligns top edge of a view with another view. The constraint is added to the view's superview.
 
 @param toView View that the constraint is related to.
 @param offset between the withView and toView.
 @param relation of the offset.
 @return The newly added constraint.
 */
- (NSLayoutConstraint *)wta_addTopConstraintToView:(UIView *)toView offset:(CGFloat)offset;
- (NSLayoutConstraint *)wta_addTopConstraintToView:(UIView *)toView offset:(CGFloat)offset relation:(NSLayoutRelation)relation;

/**
 Aligns bottom edge of a view with another view. The constraint is added to the view's superview.
 
 @param toView View that the constraint is related to.
 @param offset between the withView and toView.
 @param relation of the offset.
 @return The newly added constraint.
 */
- (NSLayoutConstraint *)wta_addBottomConstraintToView:(UIView *)toView offset:(CGFloat)offset;
- (NSLayoutConstraint *)wta_addBottomConstraintToView:(UIView *)toView offset:(CGFloat)offset relation:(NSLayoutRelation)relation;

///---------------------------------------------------
/// @name Placing Sibling Views Adjacent to Eachother
///---------------------------------------------------

/**
 Places the current view to the right of a view with a separation.
 
 @param view that the current view will placed to the right of.
 @param relation of the offset.
 @param separation between the sibling views.
 */
- (NSLayoutConstraint *)wta_addConstraintPlacingViewRightOfView:(UIView *)view separation:(CGFloat)separation;
- (NSLayoutConstraint *)wta_addConstraintPlacingViewRightOfView:(UIView *)view separation:(CGFloat)separation relation:(NSLayoutRelation)relation;

/**
 Places the current view to the left of a view with a separation.
 
 @param view that the current view will placed to the left of.
 @param relation of the offset.
 @param separation between the sibling views.
 */
- (NSLayoutConstraint *)wta_addConstraintPlacingViewLeftOfView:(UIView *)view separation:(CGFloat)separation;
- (NSLayoutConstraint *)wta_addConstraintPlacingViewLeftOfView:(UIView *)view separation:(CGFloat)separation relation:(NSLayoutRelation)relation;

/**
 Places the current view to the Top of a view with a separation.
 
 @param view that the current view will placed to the top of.
 @param relation of the offset.
 @param separation between the sibling views.
 */
- (NSLayoutConstraint *)wta_addConstraintPlacingViewAboveView:(UIView *)view separation:(CGFloat)separation;
- (NSLayoutConstraint *)wta_addConstraintPlacingViewAboveView:(UIView *)view separation:(CGFloat)separation relation:(NSLayoutRelation)relation;

/**
 Places the current view to the bottom of a view with a separation.
 
 @param view that the current view will placed to the bottom of.
 @param relation of the offset.
 @param separation between the sibling views.
 */
- (NSLayoutConstraint *)wta_addConstraintPlacingViewBelowView:(UIView *)view separation:(CGFloat)separation;
- (NSLayoutConstraint *)wta_addConstraintPlacingViewBelowView:(UIView *)view separation:(CGFloat)separation relation:(NSLayoutRelation)relation;

///-----------------------------
/// @name Centering Constraints
///-----------------------------

/**
 Creates vertical and horizontally centering constraints to the superview. These constraints are added to the view's superview.
 
 @return array of the created constraints.
 @param offset from the center.
 */
- (NSArray *)wta_addCenteringConstraintToSuperview;
- (NSArray *)wta_addCenteringConstraintToSuperviewOffset:(CGPoint)offset;

/**
 Creates a constraint to vertically center the current view. The constraint is added to the view's superview.
 
 @param offset to move the view vertically from the center.
 @return The newly added constraint.
 */
- (NSLayoutConstraint *)wta_addVerticallyCenterConstraintToSuperview;
- (NSLayoutConstraint *)wta_addVerticallyCenterConstraintToSuperviewOffset:(CGFloat)offset;

/**
 Creates a constraint to horizontally center the current view. The constraint is added to the view's superview.
 
 @param offset to move the view horizontally from the center.
 @return The newly added constraint.
 */
- (NSLayoutConstraint *)wta_addHorizontallyCenterConstraintToSuperview;
- (NSLayoutConstraint *)wta_addHorizontallyCenterConstraintToSuperviewOffset:(CGFloat)offset;

/**
 Creates a constraint to vertically center a view to a view. The constraint is added to the withView's superview.
 
 @param withView the view to be centered
 @param toView the view that the withView will be centered in relation to.
 @param offset to move the view vertically from the center.
 @return The newly added constraint.
 */
- (NSLayoutConstraint *)wta_addVerticallyCenterConstraintToView:(UIView *)toView offset:(CGFloat)offset;

/**
 Creates a constraint to horizontally center a view to a view. The constraint is added to the withView's superview.
 
 @param withView the view to be centered
 @param toView the view that the withView will be centered in relation to.
 @param offset to move the view horizontally from the center.
 @return The newly added constraint.
 */
- (NSLayoutConstraint *)wta_addHorizontallyCenterConstraintToView:(UIView *)toView offset:(CGFloat)offset;

///-------------------------
/// @name Size Constraints
///-------------------------

/**
 Adds constraints for height and width from the given size struct.
 
 @param size for the view.
 @param relation of the offset.
 @return array of size constraints.
 */
- (NSArray *)wta_addSizeConstraints:(CGSize)size;

/**
 Adds a constraint to set the height of the current view.
 
 @param height of the view.
 @param relation of the offset.
 @return The newly added constraint.
 */
- (NSLayoutConstraint *)wta_addHeightConstraint:(CGFloat)height;
- (NSLayoutConstraint *)wta_addHeightConstraint:(CGFloat)height relation:(NSLayoutRelation)relation;

/**
 Adds a constraint to set the width of the current view.
 
 @param width of the view.
 @param relation of the offset.
 @return The newly added constraint.
 */
- (NSLayoutConstraint *)wta_addWidthConstraint:(CGFloat)width;
- (NSLayoutConstraint *)wta_addWidthConstraint:(CGFloat)width relation:(NSLayoutRelation)relation;

/**
 Adds a constraint to set the width of the current view to the width of the superview.
 
 @param offet the amount added to the width.
 @param relation of the width constraint to the superview.
 */
- (NSLayoutConstraint *)wta_addWidthConstraintToSuperView;
- (NSLayoutConstraint *)wta_addWidthConstraintToSuperViewOffset:(CGFloat)offset;
- (NSLayoutConstraint *)wta_addWidthConstraintToSuperViewOffset:(CGFloat)offset relation:(NSLayoutRelation)relation;

/**
 Adds a constraint to set the width of the current view to toView.
 
 @param toView the view the constraint will be in relation to.
 @param offet the amount added to the width.
 @param relation of the width constraint to the superview.
 */
- (NSLayoutConstraint *)wta_addWidthConstraintToView:(UIView *)toView;
- (NSLayoutConstraint *)wta_addWidthConstraintToView:(UIView *)toView offset:(CGFloat)offset;
- (NSLayoutConstraint *)wta_addWidthConstraintToView:(UIView *)toView offset:(CGFloat)offset relation:(NSLayoutRelation)relation;

/**
 Adds a constraint to set the height of the current view to the height of the superview.
 
 @param offet the amount added to the height.
 @param relation of the height constraint to the superview.
 */
- (NSLayoutConstraint *)wta_addHeightConstraintToSuperView;
- (NSLayoutConstraint *)wta_addHeightConstraintToSuperViewOffset:(CGFloat)offset;
- (NSLayoutConstraint *)wta_addHeightConstraintToSuperViewOffset:(CGFloat)offset relation:(NSLayoutRelation)relation;

/**
 Adds a constraint to set the height of the current view to toView.
 
 @param toView the view the constraint will be in relation to.
 @param offet the amount added to the height.
 @param relation of the height constraint to the superview.
 */
- (NSLayoutConstraint *)wta_addHeightConstraintToView:(UIView *)toView;
- (NSLayoutConstraint *)wta_addHeightConstraintToView:(UIView *)toView offset:(CGFloat)offset;
- (NSLayoutConstraint *)wta_addHeightConstraintToView:(UIView *)toView offset:(CGFloat)offset relation:(NSLayoutRelation)relation;
@end
