#import <UIKit/UIKit.h>


@interface DDYEmptyConfig : NSObject

/** 整体背景色 默认RGBA(250.0/255.0, 250.0/255.0, 250.0/255.0, 1.0) */
@property (nonatomic, strong) UIColor *backgroundColor;

/** 图片大小 默认图片大小 */
@property (nonatomic, assign) CGSize imageSize;

/** 图片与标题间距 默认20 */
@property (nonatomic, assign) CGFloat imageTitleMargin;

/** 标题字体 默认16号字体 */
@property (nonatomic, strong) UIFont *titleFont;
/** 标题字色 默认RGBA(0.3, 0.3, 0.3, 1.0) */
@property (nonatomic, strong) UIColor *titleColor;

/** 标题与详细描述间距 默认20 */
@property (nonatomic, assign) CGFloat titleDetailMargin;

/** 详细描述字体 默认14号字体 */
@property (nonatomic, strong) UIFont *detailFont;
/** 详细描述字色 默认RGBA(0.5, 0.5, 0.5, 1.0) */
@property (nonatomic, strong) UIColor *detailColor;

/** 详细描述与按钮间距 默认20 */
@property (nonatomic, assign) CGFloat detailActionMargin;

/** 按钮字体 默认14号字体 */
@property (nonatomic, strong) UIFont *actionFont;
/** 按钮字色 默认RGBA(0.3, 0.3, 0.3, 1.0) */
@property (nonatomic, strong) UIColor *actionColor;
/** 按钮内边距 默认zero */
@property (nonatomic) UIEdgeInsets actionInsets;
/** 按钮背景色 默认clear */
@property (nonatomic, strong) UIColor *actionBackgroundColor;
/** 按钮边色 默认clear */
@property (nonatomic, strong) UIColor *actionBorderColor;
/** 按钮边宽 默认0 */
@property (nonatomic, assign) CGFloat actionBorderWidth;
/** 按钮圆角 默认0 */
@property (nonatomic, assign) CGFloat actionCornerRadius;


- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)defaultConfig;

@end


