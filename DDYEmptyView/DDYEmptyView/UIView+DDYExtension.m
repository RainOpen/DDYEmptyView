#import "UIView+DDYExtension.h"

@implementation UIView (DDYExtension)

#pragma mark - 布局
#pragma mark x的setter和getter方法
- (void)setDdy_x:(CGFloat)ddy_x {
    CGRect frame = self.frame;
    frame.origin.x = ddy_x;
    self.frame = frame;
}

- (CGFloat)ddy_x {
    return self.frame.origin.x;
}

#pragma mark y的setter和getter方法
- (void)setDdy_y:(CGFloat)ddy_y {
    CGRect frame = self.frame;
    frame.origin.y = ddy_y;
    self.frame = frame;
}

- (CGFloat)ddy_y
{
    return self.frame.origin.y;
}

#pragma mark width的setter和getter方法
- (void)setDdy_w:(CGFloat)ddy_w {
    CGRect frame = self.frame;
    frame.size.width = ddy_w;
    self.frame = frame;
}

- (CGFloat)ddy_w {
    return self.frame.size.width;
}

#pragma mark height的setter和getter方法
- (void)setDdy_h:(CGFloat)ddy_h {
    CGRect frame = self.frame;
    frame.size.height = ddy_h;
    self.frame = frame;
}
- (CGFloat)ddy_h {
    return self.frame.size.height;
}
#pragma mark centerX的setter和getter方法
- (void)setDdy_centerX:(CGFloat)ddy_centerX {
    CGPoint center = self.center;
    center.x = ddy_centerX;
    self.center = center;
}

- (CGFloat)ddy_centerX {
    return self.center.x;
}

#pragma mark centerY的setter和getter方法
- (void)setDdy_centerY:(CGFloat)ddy_centerY {
    CGPoint center = self.center;
    center.y = ddy_centerY;
    self.center = center;
}

- (CGFloat)ddy_centerY {
    return self.center.y;
}

#pragma mark 右边到 x 轴距离
- (void)setDdy_right:(CGFloat)ddy_right {
    CGRect frame = self.frame;
    frame.origin.x = ddy_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)ddy_right
{
    return self.frame.origin.x + self.frame.size.width;
    
}
#pragma mark 底边到 y 轴距离
- (void)setDdy_bottom:(CGFloat)ddy_bottom {
    CGRect frame = self.frame;
    frame.origin.y = ddy_bottom - frame.size.height;
    self.frame = frame;
}

-(CGFloat)ddy_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

#pragma mark size的setter和getter方法
- (void)setDdy_size:(CGSize)ddy_size {
    CGRect frame = self.frame;
    frame.size = ddy_size;
    self.frame = frame;
}

- (CGSize)ddy_size
{
    return self.frame.size;
}

#pragma mark origin的setter和getter方法
- (void)setDdy_origin:(CGPoint)ddy_origin {
    CGRect frame = self.frame;
    frame.origin = ddy_origin;
    self.frame = frame;
}

- (CGPoint)ddy_origin {
    return self.frame.origin;
}

@end
