#import "DDYEmptyView.h"
#import "DDYEmptyConfig.h"

#define DDYEmptyViewProperty(TYPE, NAME) \
- (DDYEmptyView *(^)(TYPE))NAME {\
    return ^DDYEmptyView *(TYPE NAME) {\
        self.NAME##Value = NAME;\
        return self;\
    };\
}\


inline UIColor *ddyEmptyColor(int r, int g, int b) { return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]; }

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


/** 是否自动显隐(自定义时设置也有效) */
@property (nonatomic, assign) BOOL autoShowValue;

/** 整体背景色 默认RGBA(250.0/255.0, 250.0/255.0, 250.0/255.0, 1.0) */
@property (nonatomic, strong) UIColor *bgColorValue;
/** 图片大小 默认图片大小 */
@property (nonatomic, assign) CGSize imageSizeValue;
/** 图片与标题间距 默认20 */
@property (nonatomic, assign) CGFloat imageTitleMarginValue;
/** 标题字体 默认16号字体 */
@property (nonatomic, strong) UIFont *titleFontValue;
/** 标题字色 默认RGBA(0.3, 0.3, 0.3, 1.0) */
@property (nonatomic, strong) UIColor *titleColorValue;
/** 标题最大长度 */
@property (nonatomic, assign) CGFloat titleMaxWidthValue;
/** 标题与详细描述间距 默认20 */
@property (nonatomic, assign) CGFloat titleDetailMarginValue;
/** 详细描述字体 默认14号字体 */
@property (nonatomic, strong) UIFont *detailFontValue;
/** 详细描述字色 默认RGBA(0.5, 0.5, 0.5, 1.0) */
@property (nonatomic, strong) UIColor *detailColorValue;
/** 详细描述最大长度 */
@property (nonatomic, assign) CGFloat detailMaxWidthValue;
/** 详细描述与按钮间距 默认20 */
@property (nonatomic, assign) CGFloat detailActionMarginValue;
/** 按钮字体 默认14号字体 */
@property (nonatomic, strong) UIFont *actionFontValue;
/** 按钮字色 默认RGBA(0.3, 0.3, 0.3, 1.0) */
@property (nonatomic, strong) UIColor *actionColorValue;
/** 按钮内边距 默认zero */
@property (nonatomic) UIEdgeInsets actionInsetsValue;
/** 按钮背景色 默认clear */
@property (nonatomic, strong) UIColor *actionBackgroundColorValue;
/** 按钮边色 默认clear */
@property (nonatomic, strong) UIColor *actionBorderColorValue;
/** 按钮边宽 默认0 */
@property (nonatomic, assign) CGFloat actionBorderWidthValue;
/** 按钮圆角 默认0 */
@property (nonatomic, assign) CGFloat actionCornerRadiusValue;

/** 内容偏移调整 默认zero */
@property (nonatomic, assign) CGPoint offsetValue;

/** 默认显示内容视图 */
@property (nonatomic, strong) UIView *contentView;
/**  */
@property (nonatomic, strong) UIImageView *imageView;
/**  */
@property (nonatomic, strong) UILabel *titleLabel;
/**  */
@property (nonatomic, strong) UILabel *detailLabel;
/**  */
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

DDYEmptyViewProperty(BOOL, autoShow)

DDYEmptyViewProperty(UIColor *, bgColor)
DDYEmptyViewProperty(CGSize, imageSize)
DDYEmptyViewProperty(CGFloat, imageTitleMargin)
DDYEmptyViewProperty(UIFont *, titleFont)
DDYEmptyViewProperty(UIColor *, titleColor)
DDYEmptyViewProperty(CGFloat, titleMaxWidth)
DDYEmptyViewProperty(CGFloat, titleDetailMargin)
DDYEmptyViewProperty(UIFont *, detailFont)
DDYEmptyViewProperty(UIColor *, detailColor)
DDYEmptyViewProperty(CGFloat, detailMaxWidth)
DDYEmptyViewProperty(CGFloat, detailActionMargin)
DDYEmptyViewProperty(UIFont *, actionFont)
DDYEmptyViewProperty(UIColor *, actionColor)
DDYEmptyViewProperty(UIColor *, actionBackgroundColor)
DDYEmptyViewProperty(UIColor *, actionBorderColor)
DDYEmptyViewProperty(CGFloat, actionBorderWidth)
DDYEmptyViewProperty(CGFloat, actionCornerRadius)
DDYEmptyViewProperty(CGPoint, offset)

- (void)setImageNameValue:(NSString *)imageNameValue {
    _imageNameValue = imageNameValue;
    UIImage *img = [UIImage imageNamed:imageNameValue];
    if (img) {
        self.imageValue = img;
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


// MARK:- 声明周期

- (instancetype)init {
    if (self = [super init]) {
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
        
        CGFloat centerX = self.bounds.size.width/2.0 + self.offsetValue.x;
        CGFloat centerY = self.bounds.size.height/2.0 + self.offsetValue.y;
        
        self.contentView.hidden = _customViewValue ? YES : NO;
        
        if (_customViewValue) {
            self.customViewValue.center = CGPointMake(centerX, centerY);
        } else {
            self.contentView.center = CGPointMake(centerX, centerY);
            [self layoutContentSubviews];
        }
    }
    
    
}

- (void)layoutContentSubviews {
    
    CGSize imageSize = CGSizeZero;
    CGFloat imageTitleMargin = (self.imageValue && self.titleValue) ? 20 : 0;
    CGSize titleSize = CGSizeZero;
    CGFloat titleDetailMargin = (self.titleValue && self.detailValue) ? 20 : 0;
    CGSize detailSize = CGSizeZero;
    CGFloat detailActionMargin = (self.detailValue && self.actionTitleValue) ? 20 : 0;
    CGSize actionSize = CGSizeZero;
    
    
    
    // 图片视图部分(即使超出范围也不缩放)
    if (self.imageValue) {
        self.imageView.image = self.imageValue;
        CGFloat imgW = self.imageSizeValue.width ?: [DDYEmptyConfig defaultConfig].imageSize.width ?: self.imageValue.size.width;
        CGFloat imgH = self.imageSizeValue.height ?: [DDYEmptyConfig defaultConfig].imageSize.height ?: self.imageValue.size.height;
        imageSize = CGSizeMake(imgW, imgH);
    }
    // 图片和标题间距
    if (self.imageValue && self.titleValue && self.titleValue.length>0) {
        imageTitleMargin = self.imageTitleMarginValue ?: [DDYEmptyConfig defaultConfig].imageTitleMargin;
    }
    // 标题
    if (self.titleValue && self.titleValue.length>0) {
        UIFont *font = self.titleFontValue ?: [DDYEmptyConfig defaultConfig].titleFont ?: [UIFont systemFontOfSize:16];
        self.titleLabel.font = font;
        self.titleLabel.text = self.titleValue;
        self.titleLabel.preferredMaxLayoutWidth = self.titleMaxWidthValue>0 ? self.titleMaxWidthValue : 280;
        self.titleLabel.textColor = self.titleColorValue ?: [DDYEmptyConfig defaultConfig].titleColor ?: ddyEmptyColor(80.0, 80.0, 80.0);
        titleSize = [self sizeWithLabel:self.titleLabel];
    }
    // 标题和详细描述间距
    if (self.titleValue && self.titleValue.length>0 && self.detailValue && self.detailValue.length>0) {
        titleDetailMargin = self.titleDetailMarginValue ?: [DDYEmptyConfig defaultConfig].titleDetailMargin;
    }
    // 详细描述
    if (self.detailValue && self.detailValue.length>0) {
        UIFont *font = self.detailFontValue ?: [DDYEmptyConfig defaultConfig].detailFont ?: [UIFont systemFontOfSize:14];
        self.detailLabel.font = font;
        self.detailLabel.text = self.detailValue;
        self.detailLabel.preferredMaxLayoutWidth = self.detailMaxWidthValue>0 ? self.detailMaxWidthValue : 280;
        self.detailLabel.textColor = self.detailColorValue ?: [DDYEmptyConfig defaultConfig].detailColor ?: ddyEmptyColor(120.0, 120.0, 120.0);
        detailSize = [self sizeWithLabel:self.detailLabel];
    }
    // 详细描述和按钮间距
    if (self.detailValue && self.detailValue.length>0 && self.actionTitleValue && self.actionTitleValue.length>0) {
        detailActionMargin = self.detailActionMarginValue ?: [DDYEmptyConfig defaultConfig].detailActionMargin;
    }
    // 按钮
    if (self.actionTitleValue && self.actionTitleValue.length>0) {
        
    }
    
}

// 构造器

+ (instancetype)emptyView {
    return [[self alloc] init];
}

// MARK:- 事件响应

- (void)tapContentView {
    if (self.contentViewClickBlock) {
        self.contentViewClickBlock();
    }
}


// MARK:- 设置
- (void)setImageViewAttributes:(void (^)(DDYEmptyView *, UIImageView *))attributes {
    if (attributes) {
        attributes(self, self.imageView);
    }
}

- (void)show {
    self.hidden = NO;
    
    self.backgroundColor = (_bgColorValue ?: [DDYEmptyConfig defaultConfig].backgroundColor) ?: ddyEmptyColor(250.0, 250.0, 250.0);
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (_customViewValue) {
        [self addSubview:self.customViewValue];
    } else {
        [self addSubview:self.contentView];
        
        
        
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

- (CGSize)sizeWithButton:(UIButton *)button {
    UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    return tempButton.frame.size;
}

@end
