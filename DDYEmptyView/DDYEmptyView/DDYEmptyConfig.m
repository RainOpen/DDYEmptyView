#import "DDYEmptyConfig.h"

@implementation DDYEmptyConfig

static DDYEmptyConfig *_instance;

+ (instancetype)defaultConfig {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}


/** 整体背景色 默认RGBA(250.0/255.0, 250.0/255.0, 250.0/255.0, 1.0) */
- (UIColor *)backgroundColor {
    return _backgroundColor ?: [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
}

/** 图片大小 默认图片大小 */
- (CGSize)imageSize {
    return _imageSize;
}

/** 图片与标题间距 默认20 */
- (CGFloat)imageTitleMargin {
    return _imageTitleMargin ?: 20;
}

/** 标题字体 默认16号字体 */
- (UIFont *)titleFont {
    return _titleFont ?: [UIFont systemFontOfSize:16];
}
/** 标题字色 默认RGBA(0.3, 0.3, 0.3, 1.0) */
- (UIColor *)titleColor {
    return _titleColor ?: [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
}

/** 标题与详细描述间距 默认20 */
- (CGFloat)titleDetailMargin {
    return _titleDetailMargin ?: 20;
}

/** 详细描述字体 默认14号字体 */
- (UIFont *)detailFont {
    return _detailFont ?: [UIFont systemFontOfSize:14];
}
/** 详细描述字色 默认RGBA(0.5, 0.5, 0.5, 1.0) */
- (UIColor *)detailColor {
    return _detailColor ?: [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
}

/** 详细描述与按钮间距 默认20 */
- (CGFloat)detailActionMargin {
    return _detailActionMargin ?: 20;
}

/** 按钮字体 默认14号字体 */
- (UIFont *)actionFont {
    return _actionFont ?: [UIFont systemFontOfSize:14];
}
/** 按钮字色 默认RGBA(0.3, 0.3, 0.3, 1.0) */
- (UIColor *)actionColor {
    return _actionColor ?: [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
}
/** 按钮内边距 默认zero */
- (UIEdgeInsets)actionInsets {
    return _actionInsets;
}
/** 按钮背景色 默认clear */
- (UIColor *)actionBackgroundColor {
    return _actionBackgroundColor ?: [UIColor clearColor];
}
/** 按钮边色 默认clear */
- (UIColor *)actionBorderColor {
    return _actionBorderColor ?: [UIColor clearColor];
}
/** 按钮边宽 默认0 */
- (CGFloat)actionBorderWidth {
    return _actionBorderWidth ?: 0;
}
/** 按钮圆角 默认0 */
- (CGFloat)actionCornerRadius {
    return _actionCornerRadius ?: 0;
}

@end
