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
#define RGBA(r,g,b,a) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])
#define kDefaultTintColor       RGB(3, 116, 255)
#define KDefaultCornerRadius    3.f
#define kLeftRightMargin        15
#define kItemHeight             30
#define kBorderLineWidth        0.5

@class RFSegmentItemView;

@protocol RFSegmentItemViewDelegate

- (void)itemStateChanged:(RFSegmentItemView *)item
				   index:(NSUInteger)index
			  isSelected:(BOOL)isSelected;
@end

#pragma mark - RFSegmentItemView

@interface RFSegmentItemView : UIView

@property (nonatomic, strong) UILabel   *titleLabel;

@property (nonatomic, strong) UIColor   *norColor;
@property (nonatomic, strong) UIColor   *selColor;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL      isSelected;
@property (nonatomic, weak	) id<RFSegmentItemViewDelegate> delegate;

@end

@implementation RFSegmentItemView

- (instancetype)initWithFrame:(CGRect)frame
						index:(NSInteger)index
						title:(NSString *)title
					 norColor:(UIColor *)norColor
					 selColor:(UIColor *)selColor
				   isSelected:(BOOL)isSelected;
{
	self = [super initWithFrame:frame];
	if (self) {
		
		_titleLabel                 = [UILabel new];
		_titleLabel.textAlignment   = NSTextAlignmentCenter;
		_titleLabel.backgroundColor = [UIColor clearColor];
		_titleLabel.font            = [UIFont systemFontOfSize:14];
		
		[self addSubview:_titleLabel];
		
		_norColor        = norColor;
		_selColor        = selColor;
		_titleLabel.text = title;
		_index           = index;
		_isSelected      = isSelected;
	}
	
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	_titleLabel.frame = self.bounds;
}

#pragma mark - Setter

- (void)setSelColor:(UIColor *)selColor
{
	if (_selColor != selColor) {
		_selColor = selColor;
		
		if (_isSelected) {
			self.titleLabel.textColor = self.norColor;
			self.backgroundColor      = self.selColor;
		} else {
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
	} else {
		self.titleLabel.textColor = self.selColor;
		self.backgroundColor      = self.norColor;
	}
	
}

#pragma mark - Event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	self.isSelected = !_isSelected;

	if (_delegate) {
		[_delegate itemStateChanged:self
							  index:self.index
						 isSelected:self.isSelected];
	}
}

@end

#pragma mark - RFSegmentView

@interface RFSegmentView()<RFSegmentItemViewDelegate>

@property (nonatomic, strong) UIView         *bgView;
@property (nonatomic, strong) NSArray        *titles;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *lines;

@end

@implementation RFSegmentView

- (instancetype)initWithFrame:(CGRect)frame
					   titles:(NSArray<NSString *> * _Nonnull)titles
{
	self = [super initWithFrame:frame];
	if (self) {
		
		NSAssert(titles.count >= 2, @"titles's cout at least 2!please check!");
		
		self.backgroundColor = [UIColor clearColor];

		_titles = titles;
		
		// bgView
		_bgView = [[UIView alloc] init];
		_bgView.backgroundColor    = [UIColor whiteColor];
		_bgView.clipsToBounds      = YES;
		_bgView.layer.cornerRadius = KDefaultCornerRadius;
		_bgView.layer.borderWidth  = kBorderLineWidth;
		_bgView.layer.borderColor  = kDefaultTintColor.CGColor;
		
		[self addSubview:_bgView];
		
		[self addSubItemView];
		[self addSubLineView];
	}
	
	return self;
}

- (void)addSubItemView
{
	NSInteger count = _titles.count;
	for (NSInteger i = 0; i < count; i++) {
		RFSegmentItemView *item = [[RFSegmentItemView alloc] initWithFrame:CGRectZero
															 index:i
															 title:_titles[i]
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
}

- (void)addSubLineView
{
	NSInteger count = _titles.count;

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

#pragma mark - Layout

- (void)willMoveToSuperview:(UIView *)newSuperview
{
	[self layoutUI];
}

- (void)layoutUI
{
	CGFloat viewWidth     = CGRectGetWidth(self.frame);
	CGFloat viewHeight    = CGRectGetHeight(self.frame);
	__block CGFloat initX = 0;
	CGFloat initY         = 0;
	
	NSInteger count         = self.titles.count;
	CGFloat leftRightMargin = self.leftRightMargin ?: kLeftRightMargin;
	CGFloat itemWidth       = (viewWidth - 2 * leftRightMargin)/count;
	CGFloat itemHeight      = self.itemHeight ?: kItemHeight;
	
	//configure bgView
	self.bgView.frame = CGRectMake(leftRightMargin, (viewHeight - itemHeight) / 2, viewWidth - 2 * leftRightMargin, itemHeight);
	
	//configure items
	[self.items enumerateObjectsUsingBlock:^(RFSegmentItemView * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
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

#pragma mark - Setter

- (void)setCornerRadius:(CGFloat)cornerRadius{
	
	NSAssert(cornerRadius > 0, @"cornerRadius must be above 0");
	
	_cornerRadius = cornerRadius;
	_bgView.layer.cornerRadius  = cornerRadius;
	
	[self layoutUI];
}

- (void)setTintColor:(UIColor *)tintColor{
	
	if (_tintColor != tintColor) {
		_tintColor = tintColor;
		
		self.bgView.layer.borderColor  = tintColor.CGColor;
		
		for (NSInteger i = 0; i < self.items.count; i++) {
			RFSegmentItemView *item = self.items[i];
			item.selColor = tintColor;
		}
		
		for (NSInteger i = 0; i < self.lines.count; i++) {
			UIView *lineView = self.lines[i];
			lineView.backgroundColor = tintColor;
		}
		
		[self layoutUI];
	}
}

- (void)setSelectedIndex:(NSUInteger)index
{
	_selectedIndex = index;
	
	if (index < self.items.count) {
		for (int i = 0; i < self.items.count; i++) {
			RFSegmentItemView *item = self.items[i];
			
			if (i == index) {
				[item setIsSelected:YES];
			} else {
				[item setIsSelected:NO];
			}
		}
	}
}

#pragma mark - RFSegmentItemViewDelegate

- (void)itemStateChanged:(RFSegmentItemView *)currentItem index:(NSUInteger)index isSelected:(BOOL)isSelected
{
	// diselect all items
	for (int i = 0; i < self.items.count; i++) {
		RFSegmentItemView *item = self.items[i];
		item.isSelected = NO;
	}
	currentItem.isSelected = YES;
	
	// notify delegate
	if ([_delegate respondsToSelector:@selector(segmentView:didSelectedIndex:)]) {
		[_delegate segmentView:self didSelectedIndex:index];
	}
	
	// notify block handler
	if (_handlder) {
		_handlder(self, index);
	}
}

@end
