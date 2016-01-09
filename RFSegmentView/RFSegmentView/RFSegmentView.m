//
//  RFSegmentView.m
//  RFSegmentView <https://github.com/wangruofeng/RFSegmentView>
//
//  Created by 王若风 on 1/15/15.
//  Copyright (c) 2015 王若风. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RFSegmentView.h"

#define RGB(r,g,b)    RGBA(r,g,b,1)
#define RGBA(r,g,b,a) ([UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:a])
#define kDefaultTintColor       RGB(3, 116, 255)
#define KDefaultCornerRadius    3.f
#define kLeftRightMargin        15
#define kItemHeight             30
#define kBorderLineWidth        0.5
#define kTitleSize              ([UIFont systemFontOfSize:14])

@class RFSegmentItem;
@protocol RFSegmentItemDelegate

- (void)ItemStateChanged:(RFSegmentItem *)item index:(NSInteger)index isSelected:(BOOL)isSelected;
@end

#pragma mark - RFSegmentItem
@interface RFSegmentItem : UIView

@property (nonatomic, strong) UIColor   *norColor;
@property (nonatomic, strong) UIColor   *selColor;
@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL      isSelected;
@property (nonatomic, assign) id        delegate;
@end

@implementation RFSegmentItem
- (id)initWithFrame:(CGRect)frame
              index:(NSInteger)index
              title:(NSString *)title
           norColor:(UIColor *)norColor
           selColor:(UIColor *)selColor
         isSelected:(BOOL)isSelected;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _titleLabel.textAlignment   = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font            = kTitleSize;
        [self addSubview:_titleLabel];
        
        _norColor        = norColor;
        _selColor        = selColor;
        _titleLabel.text = title;
        _index           = index;
        _isSelected      = isSelected;
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    self.titleLabel.frame = self.bounds;
}

- (void)setSelColor:(UIColor *)selColor
{
    if (_selColor != selColor) {
        _selColor = selColor;
        
        if (_isSelected) {
            self.titleLabel.textColor = self.norColor;
            self.backgroundColor      = self.selColor;
        }else{
            self.titleLabel.textColor = self.selColor;
            self.backgroundColor      = self.norColor;
        }

    }
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    
    if (_isSelected) {
        self.titleLabel.textColor = self.norColor;
        self.backgroundColor      = self.selColor;
    }else{
        self.titleLabel.textColor = self.selColor;
        self.backgroundColor      = self.norColor;
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    self.isSelected = !_isSelected;
    
    if (_delegate) {
        [_delegate ItemStateChanged:self index:self.index isSelected:self.isSelected];
    }
}

@end

#pragma mark - RFSegmentView

@interface RFSegmentView()

@property (nonatomic, strong) UIView         *bgView;
@property (nonatomic, strong) NSArray        *titles;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *lines;
@end

@implementation RFSegmentView

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<NSString *> * _Nonnull)items
{
    self = [super initWithFrame:frame];
    if (self) {
    
        NSAssert(items.count >= 2, @"items's cout at least 2!please check!");
        _titles              = items;
        _selectedIndex       = 0;
        self.backgroundColor = [UIColor clearColor];
        
        
        //
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor    = [UIColor whiteColor];
        _bgView.clipsToBounds      = YES;
        _bgView.layer.cornerRadius = KDefaultCornerRadius;
        _bgView.layer.borderWidth  = kBorderLineWidth;
        _bgView.layer.borderColor  = kDefaultTintColor.CGColor;
        
        [self addSubview:_bgView];
        
        
        NSInteger count = _titles.count;
        for (NSInteger i = 0; i < count; i++) {
            RFSegmentItem *item = [[RFSegmentItem alloc] initWithFrame:CGRectZero
                                                                 index:i
                                                                 title:items[i]
                                                              norColor:[UIColor whiteColor]
                                                              selColor:kDefaultTintColor
                                                            isSelected:(i == 0)? YES: NO];
            [_bgView addSubview:item];
            item.delegate = self;
            
            //save all items
            if (!self.items) {
                self.items = [[NSMutableArray alloc] initWithCapacity:count];
            }
            [_items addObject:item];
        }
        
        //add Ver lines
        for (NSInteger i = 0; i < count - 1; i++) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
            lineView.backgroundColor = kDefaultTintColor;
            
            [_bgView addSubview:lineView];
            
            //save all lines
            if (!self.lines) {
                self.lines = [[NSMutableArray alloc] initWithCapacity:count];
            }
            [_lines addObject:lineView];
        }
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewWidth     = CGRectGetWidth(self.frame);
    CGFloat viewHeight    = CGRectGetHeight(self.frame);
    __block CGFloat initX = 0;
    CGFloat initY         = 0;
    
    NSInteger count         = self.titles.count;
    CGFloat itemWidth       = CGRectGetWidth(self.bgView.frame)/count;
    CGFloat itemHeight      = CGRectGetHeight(self.bgView.frame);
    CGFloat leftRightMargin = self.leftRightMargin?:kLeftRightMargin;
    
    //configure bgView
    self.bgView.frame = CGRectMake(leftRightMargin, (viewHeight - self.itemHeight?:kItemHeight)/2, viewWidth - 2*leftRightMargin, self.itemHeight?:kItemHeight);
    
    //configure items
    [self.items enumerateObjectsUsingBlock:^(RFSegmentItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        item.frame = CGRectMake(initX, initY, itemWidth, itemHeight);
        initX += itemWidth;
    }];
 
    initX = 0;
    //configure lines
    [self.lines enumerateObjectsUsingBlock:^(UIView *  _Nonnull lineView, NSUInteger idx, BOOL * _Nonnull stop) {
        initX += itemWidth;
        lineView.frame = CGRectMake(initX, 0, kBorderLineWidth, itemHeight);
    }];

}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    
    NSAssert(cornerRadius > 0, @"cornerRadius must be above 0");
    
    _cornerRadius = cornerRadius;
    _bgView.layer.cornerRadius  = cornerRadius;
    
    [self setNeedsLayout];
}

- (void)setTintColor:(UIColor *)tintColor{

    if (_tintColor != tintColor) {
        _tintColor = tintColor;
        
        self.bgView.layer.borderColor  = tintColor.CGColor;
        
        for (NSInteger i = 0; i<self.items.count; i++) {
            RFSegmentItem *item = self.items[i];
            item.selColor = tintColor;
        }
        
        for (NSInteger i = 0; i<self.lines.count; i++) {
            UIView *lineView = self.lines[i];
            lineView.backgroundColor = tintColor;
        }
        
        [self setNeedsLayout];
    }
}

- (void)setSelectedIndex:(NSUInteger)index
{
    _selectedIndex = index;
    
    if (index<self.items.count) {
        for (int i = 0; i<self.items.count; i++) {
            RFSegmentItem *item=self.items[i];
            
            if (i==index) {
                [item setIsSelected:YES];
            } else {
                [item setIsSelected:NO];
            }
        }
    }
}

#pragma mark - RFSegmentItemDelegate
- (void)ItemStateChanged:(RFSegmentItem *)currentItem index:(NSInteger)index isSelected:(BOOL)isSelected
{
    
    // diselect all items
    for (int i = 0; i < self.items.count; i++) {
        RFSegmentItem *item = self.items[i];
        item.isSelected = NO;
    }
    currentItem.isSelected = YES;
    
    // notify delegate
    if (_delegate && [_delegate respondsToSelector:@selector(segmentView:didSelectedIndex:)])
    {
        [_delegate segmentView:self didSelectedIndex:index];
    }
    
    // notify block handler
    if (_handlder) {
        _handlder(self, index);
    }
}

@end
