//
//  UIView+WyyFrame.h
//  WYY_PageScrollView
//
//  Created by mac on 2021/8/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WyyFrame)

@property (nonatomic) CGFloat ys_x;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = y
 */
@property (nonatomic) CGFloat ys_y;

/**
 * Shortcut for frame.origin.x
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat ys_left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat ys_top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat ys_right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat ys_bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat ys_width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat ys_height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat ys_centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat ys_centerY;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint ys_origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize ys_size;

/**
 * 返回view所在的viewControllers，一个view可能在多个vc上都有添加所以返回一个数组
 */
- (NSMutableArray*)ys_viewforViewControllers;

@end

NS_ASSUME_NONNULL_END
