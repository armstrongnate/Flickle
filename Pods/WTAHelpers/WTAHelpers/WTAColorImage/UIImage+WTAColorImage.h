//
//  UIImage+WTAColorImage.h
//
//  Created by Novall Khan on 2/12/14.
//

#import <UIKit/UIKit.h>

@interface UIImage (WTAColorImage)

/**
 Creates an image with the given color
 
 @param color of the image.
 @param size of the resulting image
 @return The colored image.
 */
+ (UIImage *)wta_imageWithSize:(CGSize)size color:(UIColor *)color;

/**
 *  Creates an image with the given background
 *  and border colors. Desired bordered edges
 *  can be masked in using UIRectEdge.
 *
 *  @param size            size of the resulting image
 *  @param backgroundColor the background color
 *  @param borderEdge      the edge mask to apply border color and width
 *  @param borderColor     the border color
 *  @param borderWidth     the border stroke width
 *
 *  @return the color image with borders
 */
+ (UIImage *)wta_imageWithSize:(CGSize)size
               backgroundColor:(UIColor *)backgroundColor
                    borderEdge:(UIRectEdge)borderEdge
                   borderColor:(UIColor *)borderColor
                   borderWidth:(CGFloat)borderWidth;

/**
 *  Creates a desaturated image from the
 *  current image. This can be used to 
 *  create disabled state images for use in
 *  buttons and controls.
 *
 *  @return the desaturated image
 */
- (UIImage *)wta_desaturatedImage;

@end
