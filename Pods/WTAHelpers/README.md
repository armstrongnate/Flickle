#About WTAHelpers

WTAHelpers is a collection of useful categories for iOS development that will help you make your life easier.

## About the Helpers
- [`WTAAutoLayoutHelpers`](#wtaautolayouthelpers) - Categories on `UIView` and `NSLayoutConstraint` for creating common Auto Layout constraints.
- [`WTAFrameHelpers`](#wtaframehelpers) - A category on `UIView` for common getting and setting methods on frames.
- [`WTANibLoading`](#wtanibloading) - A category on `UIView` to easily create an instance from a nib.
- [`WTAReusableIdentifier`](#wtareusableidentifier) - Categories on reusable cells and view's in `UICollectionView` and `UITableView` for creating reusable identifiers.
- [`WTAColorImage`](#wtacolorimage) - A category on `UIImage` for creating images with a solid color as its contents.

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is the dependency manager for Objective-C projects. It has thousands of libraries and can help you scale your projects elegantly.

Currently WTAHelpers is not in the CocoaPods Spec repository while it is under development. In the meantime you can use the helpers as a pod by pointing the podspec in the repository.

#### Including all of the helpers in your Podfile:

```ruby
pod 'WTAHelpers', :git => 'git@github.com:willowtreeapps/WTAHelpers.git', :tag => '0.0.1'
```

#### Including individual subspecs in your Podfile:

```ruby
pod "WTAHelpers/WTAFrameHelpers", :git => 'git@github.com:willowtreeapps/WTAHelpers.git', :tag => '0.0.1'
pod "WTAHelpers/WTAAutoLayoutHelpers", :git => 'git@github.com:willowtreeapps/WTAHelpers.git', :tag => '0.0.1'
```

## Usage

Import all of the helpers at once with:

```objective-c
#import <WTAHelpers/WTAHelpers.h>
```

Or import each helper separately:

```objective-c
#import <WTAHelpers/UIView+WTAAutoLayoutHelpers.h>
#import <WTAHelpers/UIView+WTAFrameHelpers.h>
```
 
## <a name="wtaautolayouthelpers"></a>WTAAutoLayoutHelpers

`WTAAutoLayoutHelpers` is an attempt to make Auto Layout through code less painful. The category methods found in `UIView+WTAAutoLayoutHelpers.h` and `NSLayoutConstraint+WTAAutoLayoutHelpers.h` provide convenience methods for adding and creating common constraints.

### Adding constraints
Here is an example that creates a constraint that places a view 5px from the top of its superview and adds the constraint to the view's superview.

Note that some constraints are added to the view's superview. So you will need to make sure the view is added as a subview before using this helper.

```objective-c
[view wta_addTopConstraintToSuperviewOffset:5.0];
```

### Creating constraints
If you don't want the view's constraint added immediately, you can create the constraint with the `NSLayoutConstraint` category methods. The following two lines are equal to the line in the previous example.
```objective-c
NSLayoutConstraint *constraint = [NSLayoutConstraint wta_topConstraintWithView:view toView:[view superview] offset:5.0];
[[view superview] addConstraint:constraint]
```

### Autosetting TranslatesAutoresizingMasksIntoConstraints

If you set `wta_setAutomaticallySetAutoTranslatesAutoresizingMasksToOff:` to `YES`, you will no longer need to set `translatesAutoresizingMasksIntoConstraints` to `NO` when using the WTAutoLayoutHelpers on calling views. 

Example:
```objective-c
[UIView wta_setAutomaticallySetAutoTranslatesAutoresizingMasksToOff:YES];

UIView *viewA = [UIView new];
[viewA wta_addSizeConstraint:CGSizeMake(30.0f, 30.0f)];

UIView *viewB = [UIView new];
[viewB wta_addSizeConstraint:CGSizeMake(30.0f, 30.0f)];
```

is equivalent to:

```objective-c
UIView *viewA = [UIView new];
[viewA setTranslatesAutoresizingMasksIntoConstraints:NO];
[viewA wta_addSizeConstraint:CGSizeMake(30.0f, 30.0f)];

UIView *viewB = [UIView new];
[viewB setTranslatesAutoresizingMasksIntoConstraints:NO];
[viewB wta_addSizeConstraint:CGSizeMake(30.0f, 30.0f)];
```

### Instantiating a View That Sets TranslatesAutoresizingMasksIntoConstraints
There is also a convenience constructor that will set `translatesAutoresizingMasksIntoConstraints` to `NO`.

Example:
```objective-c
UIView *view = [UIView wta_autolayoutView];
```

is equivalent to:
```objective-c
UIView *view = [UIView new];
[view setTranslatesAutoresizingMasksIntoConstraints:NO];
```

### Common Constraints

- Setting edge constraints from a view to its superview (e.g. `wta_addLeadingConstraintToSuperviewOffset:`).
- Aligning edges for sibling views (e.g. `wta_addLeadingConstraintToView:offset:`).
- Placing sibling views adjacent to one eachother (e.g. `wta_addConstraintPlacingViewRightOfView:separation:`).
- Centering views in their superview (e.g. `wta_addCenteringConstraintToSuperviewOffset:`).
- Setting the size of a view with constraints (e.g. `wta_addHeightConstraint:`).


## <a name="wtaframehelpers"></a>WTAFrameHelpers
## <a name="wtanibloading"></a>WTANibLoading
## <a name="wtareusableidentifier"></a>WTAReusableIdentifier
## <a name="wtacolorimage"></a>WTAColorImage

## License

WTAHelpers is available under the MIT license.
