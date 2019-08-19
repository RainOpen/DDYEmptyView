#import "UICollectionView+DDYEmpty.h"
#import "DDYEmptyView.h"
#import <objc/runtime.h>

@implementation UICollectionView (DDYEmpty)

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
    
    ///section
    [self changeOrignalSEL:@selector(insertSections:) swizzleSEL:@selector(ddy_InsertSections:)];
    [self changeOrignalSEL:@selector(deleteSections:) swizzleSEL:@selector(ddy_DeleteSections:)];
    [self changeOrignalSEL:@selector(reloadSections:) swizzleSEL:@selector(ddy_ReloadSections:)];
    
    ///item
    [self changeOrignalSEL:@selector(insertItemsAtIndexPaths:) swizzleSEL:@selector(ddy_InsertItemsAtIndexPaths:)];
    [self changeOrignalSEL:@selector(deleteItemsAtIndexPaths:) swizzleSEL:@selector(ddy_DeleteItemsAtIndexPaths:)];
    [self changeOrignalSEL:@selector(reloadItemsAtIndexPaths:) swizzleSEL:@selector(ddy_ReloadItemsAtIndexPaths:)];
    
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
// section
- (void)ddy_InsertSections:(NSIndexSet *)sections {
    [self ddy_InsertSections:sections];
    [self changeEmpty];
}
- (void)ddy_DeleteSections:(NSIndexSet *)sections {
    [self ddy_DeleteSections:sections];
    [self changeEmpty];
}
- (void)ddy_ReloadSections:(NSIndexSet *)sections {
    [self ddy_ReloadSections:sections];
    [self changeEmpty];
}

// item
- (void)ddy_InsertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self ddy_InsertItemsAtIndexPaths:indexPaths];
    [self changeEmpty];
}
- (void)ddy_DeleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self ddy_DeleteItemsAtIndexPaths:indexPaths];
    [self changeEmpty];
}
- (void)ddy_ReloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self ddy_ReloadItemsAtIndexPaths:indexPaths];
    [self changeEmpty];
}

- (void)changeEmpty {
    
    if (self.ddy_EmptyView) {
        
        BOOL hidden = NO;
        if (self.ddy_EmptyView.autoShowWithSectionValue) {
            hidden = self.numberOfSections>0 ? YES : NO;
        } else if(self.ddy_EmptyView.autoShowWithCellValue) {
            for (NSInteger section = 0; section < self.numberOfSections; section++) {
                if ([self numberOfItemsInSection:section] > 0) {
                    hidden = YES;
                }
            }
        }
        [self.ddy_EmptyView hide:hidden closeAutoShow:NO];
    }
}

@end
