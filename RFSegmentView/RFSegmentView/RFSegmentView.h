//
//  RFSegmentView.h
//  RFSegmentView
//
//  Created by 王若风 on 1/15/15.
//  Copyright (c) 2015 王若风. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RFSegmentViewDelegate <NSObject>

- (void)segmentViewDidSelected:(NSUInteger)index;
@end

@interface RFSegmentView : UIView

/**
 *  设置风格颜色 默认蓝色风格
 */
@property (nonatomic, strong) UIColor *tintColor;

/**
 *  设置RFSegmentView的左右间距 默认15
 */
@property (nonatomic, assign) CGFloat leftRightMargin;

/**
 *  设置RFSegmentView的每个选项卡的高度 默认30
 */
@property (nonatomic, assign) CGFloat itemHeight;

/**
 *  设置选中项 默认0
 */
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, assign) id<RFSegmentViewDelegate> delegate;

/**
 *  默认构造函数
 *
 *  @param frame frame
 *  @param items title字符串数组
 *
 *  @return 当前实例
 */
- (instancetype)initWithFrame:(CGRect)frame
                        items:(NSArray<NSString *> *)items;

@end
