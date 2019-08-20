#import "DDYEmptyView.h"
#import "UIView+DDYExtension.h"

#define DDYEmptyViewProperty(TYPE, NAME) \
- (DDYEmptyView *(^)(TYPE))NAME {\
    return ^DDYEmptyView *(TYPE NAME) {\
        self.NAME##Value = NAME;\
        return self;\
    };\
}\


static inline UIColor *ddyEmptyColor(int r, int g, int b) { return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]; }

@interface DDYEmptyView ()

/** 无数据占位自定义视图 */
@property (nonatomic, strong) UIView *customViewValue;

/** 无数据占位图片 */
@property (nonatomic, strong) UIImage *imageValue;
/** 无数据占位图片名称 */
@property (nonatomic, copy) NSString *imageNameValue;
/** 无数据占位标题 */
@property (nonatomic, copy) NSString *titleValue;
/** 无数据占位详细描述 */
@property (nonatomic, copy) NSString *detailValue;
/** 无数据占位按钮标题*/
@property (nonatomic, copy) NSString *actionTitleValue;

/** 按钮点击事件target */
@property (nonatomic) id targetValue;
/** 按钮点击事件selector */
@property (nonatomic) SEL selectorValue;
/** 内容区域点击事件回调(自定义时设置无效) */
@property (nonatomic, copy) DDYEmptyBlock contentBlockValue;
/** 按钮点击事件回调(自定义时设置无效) */
@property (nonatomic, copy) DDYEmptyBlock actionBlockValue;

/** 是否根据Section自动显隐(自定义时设置也有效) 默认YES */
@property (nonatomic, assign, readwrite) BOOL autoShowWithSectionValue;
/** 是否根据Cell自动显隐(自定义时设置也有效) 默认YES */
@property (nonatomic, assign, readwrite) BOOL autoShowWithCellValue;

/** 整体背景色 默认RGBA(250.0/255.0, 250.0/255.0, 250.0/255.0, 1.0) */
@property (nonatomic, strong) UIColor *bgColorValue;
/** 图片大小 默认图片大小 */
@property (nonatomic, assign) CGSize imageSizeValue;
/** 标题字体 默认16号字体 */
@property (nonatomic, strong) UIFont *titleFontValue;
/** 标题字色 默认RGBA(0.3, 0.3, 0.3, 1.0) */
@property (nonatomic, strong) UIColor *titleColorValue;
/** 标题最大长度 */
@property (nonatomic, assign) CGFloat titleMaxWidthValue;
/** 详细描述字体 默认14号字体 */
@property (nonatomic, strong) UIFont *detailFontValue;
/** 详细描述字色 默认RGBA(0.5, 0.5, 0.5, 1.0) */
@property (nonatomic, strong) UIColor *detailColorValue;
/** 详细描述最大长度 */
@property (nonatomic, assign) CGFloat detailMaxWidthValue;
/** 按钮字体 默认14号字体 */
@property (nonatomic, strong) UIFont *actionFontValue;
/** 按钮字色 默认RGBA(0.3, 0.3, 0.3, 1.0) */
@property (nonatomic, strong) UIColor *actionColorValue;
/** 按钮大小 默认为适应文字 */
@property (nonatomic, assign) CGSize actionSizeValue;
/** 按钮背景色 默认clear */
@property (nonatomic, strong) UIColor *actionBackgroundColorValue;
/** 按钮边色 默认clear */
@property (nonatomic, strong) UIColor *actionBorderColorValue;
/** 按钮边宽 默认0 */
@property (nonatomic, assign) CGFloat actionBorderWidthValue;
/** 按钮圆角 默认0 */
@property (nonatomic, assign) CGFloat actionCornerRadiusValue;

/** 间距 默认20 */
@property (nonatomic, assign) CGFloat subMarginValue;
/** 内容偏移调整 默认zero */
@property (nonatomic, assign) CGPoint offsetValue;

/** 默认显示内容视图 */
@property (nonatomic, strong) UIView *contentView;
/** 图片视图 */
@property (nonatomic, strong) UIImageView *imageView;
/** 标题视图 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 详细描述视图 */
@property (nonatomic, strong) UILabel *detailLabel;
/** 按钮视图 */
@property (nonatomic, strong) UIButton *actionButton;


@end

@implementation DDYEmptyView

// MARK:- 设置

DDYEmptyViewProperty(UIView *, customView)
DDYEmptyViewProperty(UIImage *, image)
DDYEmptyViewProperty(NSString *, imageName)
DDYEmptyViewProperty(NSString *, title)
DDYEmptyViewProperty(NSString *, detail)
DDYEmptyViewProperty(NSString *, actionTitle)

DDYEmptyViewProperty(id, target)
DDYEmptyViewProperty(SEL, selector)
DDYEmptyViewProperty(DDYEmptyBlock, contentBlock)
DDYEmptyViewProperty(DDYEmptyBlock, actionBlock)

DDYEmptyViewProperty(BOOL, autoShowWithSection)
DDYEmptyViewProperty(BOOL, autoShowWithCell)

DDYEmptyViewProperty(UIColor *, bgColor)
DDYEmptyViewProperty(CGSize, imageSize)
DDYEmptyViewProperty(UIFont *, titleFont)
DDYEmptyViewProperty(UIColor *, titleColor)
DDYEmptyViewProperty(CGFloat, titleMaxWidth)
DDYEmptyViewProperty(UIFont *, detailFont)
DDYEmptyViewProperty(UIColor *, detailColor)
DDYEmptyViewProperty(CGFloat, detailMaxWidth)
DDYEmptyViewProperty(UIFont *, actionFont)
DDYEmptyViewProperty(UIColor *, actionColor)
DDYEmptyViewProperty(CGSize, actionSize)
DDYEmptyViewProperty(UIColor *, actionBackgroundColor)
DDYEmptyViewProperty(UIColor *, actionBorderColor)
DDYEmptyViewProperty(CGFloat, actionBorderWidth)
DDYEmptyViewProperty(CGFloat, actionCornerRadius)
DDYEmptyViewProperty(CGFloat, subMargin)
DDYEmptyViewProperty(CGPoint, offset)

- (void)setImageNameValue:(NSString *)imageNameValue {
    _imageNameValue = imageNameValue;
    UIImage *img = [UIImage imageNamed:imageNameValue];
    if (img) {
        self.imageValue = img;
    }
}

- (void)setCustomViewValue:(UIView *)customViewValue {
    _customViewValue = customViewValue;
    if (customViewValue) {
         [self addSubview:customViewValue];
    }
}

// MARK:- 懒加载
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _detailLabel;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _actionButton.contentEdgeInsets = UIEdgeInsetsZero;
    }
    return _actionButton;
}

// MARK:- 声明周期
- (instancetype)init {
    if (self = [super init]) {
        [self setAutoShowWithSectionValue:YES];
        [self setAutoShowWithCellValue:YES];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self addSubview:self.contentView];
        [self.contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContentView)]];
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.actionButton];
        [self.contentView setHidden:YES];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.superview && [self.superview isKindOfClass:[UIView class]]) {
        self.frame = self.superview.bounds;
        self.contentView.hidden = _customViewValue ? YES : NO;
        
        if (_customViewValue) {
            self.customViewValue.center = CGPointMake(self.ddy_w/2.0, self.ddy_h/2.0);
        } else {
            self.contentView.center = CGPointMake(self.ddy_w/2.0, self.ddy_h/2.0);
            [self layoutContentSubviews];
        }
    }
}

- (void)layoutContentSubviews {
    
    CGPoint offset = CGPointZero;
    CGSize imageSize = CGSizeZero;
    CGSize titleSize = CGSizeZero;
    CGSize detailSize = CGSizeZero;
    CGSize actionSize = CGSizeZero;
    CGFloat titleTopMargin = 0;
    CGFloat detailTopMargin = 0;
    CGFloat actionTopMargin = 0;
    
    // 整体内容部分
    self.backgroundColor = self.bgColorValue ?: ddyEmptyColor(250.0, 250.0, 250.0);
    self.contentView.backgroundColor = [UIColor clearColor];
    offset = CGPointMake(self.offsetValue.x ?: 0, self.offsetValue.y ?: 0);
    self.contentView.frame = self.bounds;
    // 图片视图部分(即使超出范围也不缩放)
    if (self.imageValue) {
        self.imageView.image = self.imageValue;
        imageSize = CGSizeMake(self.imageSizeValue.width ?: self.imageValue.size.width, self.imageSizeValue.height ?: self.imageValue.size.height);
    }
    // 标题
    if (self.titleValue && self.titleValue.length>0) {
        UIFont *font = self.titleFontValue ?: [UIFont systemFontOfSize:16];
        self.titleLabel.font = font;
        self.titleLabel.text = self.titleValue;
        self.titleLabel.preferredMaxLayoutWidth = self.titleMaxWidthValue>0 ? self.titleMaxWidthValue : 280;
        self.titleLabel.textColor = self.titleColorValue ?: ddyEmptyColor(80.0, 80.0, 80.0);
        self.titleLabel.preferredMaxLayoutWidth = self.detailMaxWidthValue>0 ? self.detailMaxWidthValue : 280;
        titleSize = [self sizeWithLabel:self.titleLabel];
        titleTopMargin = self.subMarginValue>0 ? self.subMarginValue : 20;
    }
    // 详细描述
    if (self.detailValue && self.detailValue.length>0) {
        UIFont *font = self.detailFontValue ?: [UIFont systemFontOfSize:14];
        self.detailLabel.font = font;
        self.detailLabel.text = self.detailValue;
        self.detailLabel.preferredMaxLayoutWidth = self.detailMaxWidthValue>0 ? self.detailMaxWidthValue : 280;
        self.detailLabel.textColor = self.detailColorValue ?: ddyEmptyColor(120.0, 120.0, 120.0);
        detailSize = [self sizeWithLabel:self.detailLabel];
        detailTopMargin = self.subMarginValue>0 ? self.subMarginValue : 20;
    }
    // 按钮
    if (self.actionTitleValue && self.actionTitleValue.length>0) {
        UIFont *font = self.actionFontValue ?: [UIFont systemFontOfSize:16];
        [self.actionButton setTitle:self.actionTitleValue forState:UIControlStateNormal];
        [self.actionButton setTitleColor:self.actionColorValue ?: ddyEmptyColor(80.0, 80.0, 80.0) forState:UIControlStateNormal];
        [self.actionButton setBackgroundColor:self.actionBackgroundColorValue ?: [UIColor clearColor]];
        [self.actionButton.layer setBorderColor:self.actionBorderColorValue ? self.actionBorderColorValue.CGColor : [UIColor clearColor].CGColor];
        [self.actionButton.layer setBorderWidth:self.actionBorderWidthValue ?: 0];
        [self.actionButton.layer setCornerRadius:self.actionCornerRadiusValue ?: 0];
        [self.actionButton.layer setMasksToBounds:YES];
        [self.actionButton.titleLabel setFont:font];
        [self.actionButton.titleLabel setPreferredMaxLayoutWidth:self.detailMaxWidthValue>0 ? self.detailMaxWidthValue : 280];
        if (self.targetValue && self.selectorValue) {
            [self.actionButton addTarget:self.targetValue action:self.selectorValue forControlEvents:UIControlEventTouchUpInside];
        } else {
            [self.actionButton addTarget:self action:@selector(handleAction) forControlEvents:UIControlEventTouchUpInside];
        }
        CGSize labelSize = [self sizeWithLabel:self.actionButton.titleLabel];
        actionSize = CGSizeMake(self.actionSizeValue.width ?: labelSize.width, self.actionSizeValue.height ?: labelSize.height);
        actionTopMargin = self.subMarginValue>0 ? self.subMarginValue : 20;
    }
    // 布局
    self.imageView.ddy_size = imageSize;
    self.titleLabel.ddy_size = titleSize;
    self.detailLabel.ddy_size = detailSize;
    self.actionButton.ddy_size = actionSize;
    
    self.titleLabel.ddy_centerX = self.ddy_w/2.0 + offset.x;
    self.titleLabel.ddy_bottom = self.ddy_h/2.0 + offset.y;
    
    self.imageView.ddy_centerX = self.titleLabel.ddy_centerX;
    self.imageView.ddy_bottom = self.titleLabel.ddy_y - titleTopMargin;
    
    self.detailLabel.ddy_centerX = self.titleLabel.ddy_centerX;
    self.detailLabel.ddy_y = self.titleLabel.ddy_bottom + detailTopMargin;
    
    self.actionButton.ddy_centerX = self.titleLabel.ddy_centerX;
    self.actionButton.ddy_y = self.detailLabel.ddy_bottom + actionTopMargin;
}

// 构造器
+ (instancetype)emptyView {
    return [[self alloc] init];
}

// MARK:- 事件响应
- (void)tapContentView {
    if (self.contentBlockValue) {
        self.contentBlockValue();
    }
}

- (void)handleAction {
    if (self.actionBlockValue) {
        self.actionBlockValue();
    }
}

// MARK:- 设置
- (void)setImageViewAttributes:(void (^)(DDYEmptyView *, UIImageView *))attributes {
    if (attributes) {
        attributes(self, self.imageView);
    }
}

- (CGSize)sizeWithLabel:(UILabel *)label {
    UILabel *tempLabel = [[UILabel alloc] init];
    tempLabel.text = label.text;
    tempLabel.font = label.font;
    tempLabel.numberOfLines = 0;
    tempLabel.preferredMaxLayoutWidth = label.preferredMaxLayoutWidth;
    tempLabel.textAlignment = NSTextAlignmentCenter;
    [tempLabel sizeToFit];
    return tempLabel.frame.size;
}

- (void)hide:(BOOL)hide closeAutoShow:(BOOL)closeAutoShow {
    if (closeAutoShow) {
        self.autoShowWithSectionValue = NO;
        self.autoShowWithCellValue = NO;
    }
    [self setHidden:hide];
    [self.superview layoutIfNeeded];
    [self.superview bringSubviewToFront:self];
}

@end
