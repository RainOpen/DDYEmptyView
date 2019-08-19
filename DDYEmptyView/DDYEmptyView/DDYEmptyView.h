#import <UIKit/UIKit.h>


@interface DDYEmptyView : UIView

/** 无数据占位自定义视图 */
@property (nonatomic, copy, readonly) DDYEmptyView *(^customView)(UIView *customView);

/** 无数据占位图片(自定义时设置无效) */
@property (nonatomic, copy, readonly) DDYEmptyView *(^image)(UIImage *image);
/** 无数据占位图片名称(自定义时设置无效) */
@property (nonatomic, copy, readonly) DDYEmptyView *(^imageName)(NSString *imageName);
/** 无数据占位标题(自定义时设置无效) */
@property (nonatomic, copy, readonly) DDYEmptyView *(^title)(NSString *title);
/** 无数据占位详细描述(自定义时设置无效) */
@property (nonatomic, copy, readonly) DDYEmptyView *(^detail)(NSString *detail);
/** 无数据占位按钮标题(自定义时设置无效) */
@property (nonatomic, copy, readonly) DDYEmptyView *(^actionTitle)(NSString *actionTitle);
/** 内容区域点击事件回调(自定义时设置无效) */
@property (nonatomic, copy) void (^contentViewClickBlock)(void);
/** 按钮点击事件回调(自定义时设置无效) */
@property (nonatomic, copy) void (^actionButtonClickBlock)(void);

/** 是否根据Section自动显隐(自定义时设置也有效) 默认YES */
@property (nonatomic, copy, readonly) DDYEmptyView *(^autoShowWithSection)(BOOL autoShowWithSection);
/** 是否根据Cell自动显隐(自定义时设置也有效) 默认YES */
@property (nonatomic, copy, readonly) DDYEmptyView *(^autoShowWithCell)(BOOL autoShowWithCell);
/** 得到 是否根据Section自动显隐(自定义时设置也有效) 默认YES */
@property (nonatomic, assign, readonly) BOOL autoShowWithSectionValue;
/** 得到 是否根据Cell自动显隐(自定义时设置也有效) 默认YES */
@property (nonatomic, assign, readonly) BOOL autoShowWithCellValue;

/** 整体背景色 默认RGBA(250.0/255.0, 250.0/255.0, 250.0/255.0, 1.0) */
@property (nonatomic, copy, readonly) DDYEmptyView *(^bgColor)(UIColor *bgColor);
/** 图片大小 默认图片大小 */
@property (nonatomic, copy, readonly) DDYEmptyView *(^imageSize)(CGSize imageSize);
/** 图片与标题间距 默认20 */
@property (nonatomic, copy, readonly) DDYEmptyView *(^imageTitleMargin)(CGFloat imageTitleMargin);
/** 标题字体 默认16号字体 */
@property (nonatomic, copy, readonly) DDYEmptyView *(^titleFont)(UIFont *titleFont);
/** 标题字色 默认RGBA(80.0/255.0, 80.0/255.0, 80.0/255.0, 1.0) */
@property (nonatomic, copy, readonly) DDYEmptyView *(^titleColor)(UIColor *titleColor);
/** 标题最大长度 默认280 */
@property (nonatomic, copy, readonly) DDYEmptyView *(^titleMaxWidth)(CGFloat titleMaxWidth);
/** 标题与详细描述间距 默认20 */
@property (nonatomic, copy, readonly) DDYEmptyView *(^titleDetailMargin)(CGFloat titleDetailMargin);
/** 详细描述字体 默认14号字体 */
@property (nonatomic, copy, readonly) DDYEmptyView *(^detailFont)(UIFont *detailFont);
/** 详细描述字色 默认RGBA(120.0/255.0, 120.0/255.0, 120.0/255.0, 1.0) */
@property (nonatomic, copy, readonly) DDYEmptyView *(^detailColor)(UIColor *detailColor);
/** 详细描述最大长度 */
@property (nonatomic, copy, readonly) DDYEmptyView *(^detailMaxWidth)(CGFloat detailMaxWidth);
/** 详细描述与按钮间距 默认20 */
@property (nonatomic, copy, readonly) DDYEmptyView *(^detailActionMargin)(CGFloat detailActionMargin);
/** 按钮字体 默认14号字体 */
@property (nonatomic, copy, readonly) DDYEmptyView *(^actionFont)(UIFont *actionFont);
/** 按钮字色 默认RGBA(80.0/255.0, 80.0/255.0, 80.0/255.0, 1.0) */
@property (nonatomic, copy, readonly) DDYEmptyView *(^actionColor)(UIColor *actionColor);
/** 按钮大小 默认为适应文字 */
@property (nonatomic, copy, readonly) DDYEmptyView *(^actionSize)(CGSize actionSize);
/** 按钮背景色 默认clear */
@property (nonatomic, copy, readonly) DDYEmptyView *(^actionBackgroundColor)(UIColor *actionBackgroundColor);
/** 按钮边色 默认clear */
@property (nonatomic, copy, readonly) DDYEmptyView *(^actionBorderColor)(UIColor *actionBorderColor);
/** 按钮边宽 默认0 */
@property (nonatomic, copy, readonly) DDYEmptyView *(^actionBorderWidth)(CGFloat actionBorderWidth);
/** 按钮圆角 默认0 */
@property (nonatomic, copy, readonly) DDYEmptyView *(^actionCornerRadius)(CGFloat actionCornerRadius);

/** 内容偏移调整 默认zero */
@property (nonatomic, copy, readonly) DDYEmptyView *(^offset)(CGPoint offset);


- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)emptyView;

// !!!: 手动控制显隐,不受DataSource的影响
/** 手动调用显隐 */
- (void)hide:(BOOL)hide closeAutoShow:(BOOL)closeAutoShow;

@end

