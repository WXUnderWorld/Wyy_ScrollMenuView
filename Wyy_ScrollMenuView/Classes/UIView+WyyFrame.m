//
//  UIView+WyyFrame.m
//  WYY_PageScrollView
//
//  Created by mac on 2021/8/7.
//

#import "UIView+WyyFrame.h"

@implementation UIView (WyyFrame)

- (CGFloat)ys_x {
    
    return self.frame.origin.x;
}

- (void)setYs_x:(CGFloat)x {
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)ys_y {
    
    return self.frame.origin.y;
}

- (void)setYs_y:(CGFloat)y {
    
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)ys_left {
    
    return self.frame.origin.x;
}

- (void)setYs_left:(CGFloat)left {
    
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)ys_top {
    
    return self.frame.origin.y;
}

- (void)setYs_top:(CGFloat)top {
    
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)ys_right {
    
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setYs_right:(CGFloat)right {
    
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)ys_bottom  {
    
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setYs_bottom:(CGFloat)bottom {
    
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)ys_centerX {
    
    return self.center.x;
}

- (void)setYs_centerX:(CGFloat)centerX {
    
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)ys_centerY {
    
    return self.center.y;
}

- (void)setYs_centerY:(CGFloat)centerY {
    
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)ys_width {
    
    return self.frame.size.width;
}

- (void)setYs_width:(CGFloat)width {
    
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)ys_height {
    
    return self.frame.size.height;
}

- (void)setYs_height:(CGFloat)height {
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)ys_origin {
    
    return self.frame.origin;
}

- (void)setYs_origin:(CGPoint)origin {
    
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


- (CGSize)ys_size {
    
    return self.frame.size;
}

- (void)setYs_size:(CGSize)size {
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

#pragma mark - 返回view所在的viewControllers，一个view可能在多个vc上都有添加所以返回一个数组
- (NSMutableArray*)ys_viewforViewControllers {
    
    NSMutableArray* arrayM = [NSMutableArray array];
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            [arrayM addObject:(UIViewController*)nextResponder];
        }
    }
    return arrayM;
}


@end
