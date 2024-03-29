#import "UITableView+DDYEmpty.h"
#import "DDYEmptyView.h"
#import <objc/runtime.h>

@implementation UITableView (DDYEmpty)

+ (void)changeOrignalSEL:(SEL)orignalSEL swizzleSEL:(SEL)swizzleSEL {
    Method originalMethod = class_getInstanceMethod([self class], orignalSEL);
    Method swizzleMethod = class_getInstanceMethod([self class], swizzleSEL);
    if (class_addMethod([self class], orignalSEL, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod))) {
        class_replaceMethod([self class], swizzleSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
}

+ (void)load {
    
    [self changeOrignalSEL:@selector(reloadData) swizzleSEL:@selector(ddy_ReloadData)];
    [self changeOrignalSEL:@selector(insertSections:withRowAnimation:) swizzleSEL:@selector(ddy_InsertSections:withRowAnimation:)];
    [self changeOrignalSEL:@selector(deleteSections:withRowAnimation:) swizzleSEL:@selector(ddy_DeleteSections:withRowAnimation:)];
    [self changeOrignalSEL:@selector(reloadSections:withRowAnimation:) swizzleSEL:@selector(ddy_ReloadSections:withRowAnimation:)];
    [self changeOrignalSEL:@selector(insertRowsAtIndexPaths:withRowAnimation:) swizzleSEL:@selector(ddy_InsertRowsAtIndexPaths:withRowAnimation:)];
    [self changeOrignalSEL:@selector(deleteRowsAtIndexPaths:withRowAnimation:) swizzleSEL:@selector(ddy_DeleteRowsAtIndexPaths:withRowAnimation:)];
    [self changeOrignalSEL:@selector(reloadRowsAtIndexPaths:withRowAnimation:) swizzleSEL:@selector(ddy_ReloadRowsAtIndexPaths:withRowAnimation:)];
}

- (DDYEmptyView *)ddy_EmptyView {
    return  objc_getAssociatedObject(self, @selector(ddy_EmptyView));
}

- (void)setDdy_EmptyView:(DDYEmptyView *)ddy_EmptyView {
    if (ddy_EmptyView != self.ddy_EmptyView) {
        
        objc_setAssociatedObject(self, @selector(ddy_EmptyView), ddy_EmptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[DDYEmptyView class]]) {
                [view removeFromSuperview];
            }
        }
        [self addSubview:self.ddy_EmptyView];
        self.ddy_EmptyView.hidden = YES;
    }
}

- (void)ddy_ReloadData {
    [self ddy_ReloadData];
    [self changeEmpty];
}

- (void)ddy_InsertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self ddy_InsertSections:sections withRowAnimation:animation];
    [self changeEmpty];
}

- (void)ddy_DeleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self ddy_DeleteSections:sections withRowAnimation:animation];
    [self changeEmpty];
}

- (void)ddy_ReloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self ddy_ReloadSections:sections withRowAnimation:animation];
    [self changeEmpty];
}

- (void)ddy_InsertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self ddy_InsertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self changeEmpty];
}

- (void)ddy_DeleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self ddy_DeleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self changeEmpty];
}

- (void)ddy_ReloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self ddy_ReloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self changeEmpty];
}

- (void)changeEmpty {
    
    if (self.ddy_EmptyView) {
        
        BOOL hidden = NO;
        if (self.ddy_EmptyView.autoShowWithSectionValue) {
            hidden = self.numberOfSections>0 ? YES : NO;
        } else if(self.ddy_EmptyView.autoShowWithCellValue) {
            for (NSInteger section = 0; section < self.numberOfSections; section++) {
                if ([self numberOfRowsInSection:section] > 0) {
                    hidden = YES;
                }
            }
        }
        [self.ddy_EmptyView hide:hidden closeAutoShow:NO];
    }
}

@end


