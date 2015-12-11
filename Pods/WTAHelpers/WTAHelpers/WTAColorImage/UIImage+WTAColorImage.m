//
//  UIImage+WTAColorImage.h
//
//  Created by Novall Khan on 2/12/14.
//

#import "UIImage+WTAColorImage.h"

@implementation UIImage (WTAColorImage)

+ (UIImage *)wta_imageWithSize:(CGSize)size color:(UIColor *)color
{   
    return [self wta_imageWithSize:size
                   backgroundColor:color
                        borderEdge:UIRectEdgeNone
                       borderColor:nil
                       borderWidth:0.0];
}

+ (UIImage *)wta_imageWithSize:(CGSize)size
               backgroundColor:(UIColor *)backgroundColor
                    borderEdge:(UIRectEdge)borderEdge
                   borderColor:(UIColor *)borderColor
                   borderWidth:(CGFloat)borderWidth
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor = backgroundColor;
    
    if (borderEdge == UIRectEdgeAll)
    {
        view.layer.borderColor = borderColor.CGColor;
        view.layer.borderWidth = borderWidth;
    }
    else if (borderEdge != UIRectEdgeNone)
    {
        if (borderEdge & UIRectEdgeTop)
        {
            [self wta_addBorderToView:view
                          forRectEdge:UIRectEdgeTop
                                color:borderColor
                                width:borderWidth];
        }
        
        if (borderEdge & UIRectEdgeRight)
        {
            [self wta_addBorderToView:view
                          forRectEdge:UIRectEdgeRight
                                color:borderColor
                                width:borderWidth];
        }
        
        if (borderEdge & UIRectEdgeBottom)
        {
            [self wta_addBorderToView:view
                          forRectEdge:UIRectEdgeBottom
                                color:borderColor
                                width:borderWidth];
        }
        
        if (borderEdge & UIRectEdgeLeft)
        {
            [self wta_addBorderToView:view
                          forRectEdge:UIRectEdgeLeft
                                color:borderColor
                                width:borderWidth];
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0, 0);
    [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (void)wta_addBorderToView:(UIView *)view
                forRectEdge:(UIRectEdge)rectEdge
                      color:(UIColor *)color
                      width:(CGFloat)width
{
    UIView *borderView = [UIView new];
    [borderView setBackgroundColor:color];
    
    CGRect frame = view.frame;
    switch (rectEdge)
    {
        case UIRectEdgeTop:
        {
            frame.size.height = width;
            frame.size.width = CGRectGetWidth(view.bounds);
        }
            break;
        case UIRectEdgeRight:
        {
            frame.size.height = CGRectGetHeight(view.bounds);
            frame.size.width = width;
            frame.origin.x = CGRectGetMaxX(view.bounds) - width;
        }
            break;
        case UIRectEdgeBottom:
        {
            frame.size.height = width;
            frame.size.width = CGRectGetWidth(view.bounds);
            frame.origin.y = CGRectGetMaxY(view.bounds) - width;
        }
            break;
        case UIRectEdgeLeft:
        {
            frame.size.height = CGRectGetHeight(view.bounds);
            frame.size.width = width;
        }
            break;
        default:
            break;
    }
    [borderView setFrame:frame];
    [view addSubview:borderView];
}

- (UIImage *)wta_desaturatedImage
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *image = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:image forKey:@"inputImage"];
    [filter setValue:[NSNumber numberWithFloat:0.0f] forKey:@"inputSaturation"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef imageRef = [context createCGImage:result fromRect:[result extent]];
    UIImage *desaturatedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return desaturatedImage;
}

@end
