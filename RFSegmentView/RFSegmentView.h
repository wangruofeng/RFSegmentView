//
//  RFSegmentView.h
//  RFSegmentView <https://github.com/wangruofeng/RFSegmentView>
//
//  Created by 王若风 on 1/15/15.
//  Copyright (c) 2015 王若风. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <UIKit/UIKit.h>

@class RFSegmentView;

NS_ASSUME_NONNULL_BEGIN

@protocol RFSegmentViewDelegate <NSObject>
- (void)segmentView:(RFSegmentView * __nullable)segmentView didSelectedIndex:(NSUInteger)selectedIndex;
@end

/**
 *  This is a SegmentView 
 * @discussion This class supports iOS5 and above,you can create a segmentView like iOS7's style -- flatting.
 
 Example:
 
     RFSegmentView* segmentView = [[RFSegmentView alloc] initWithFrame:aRect items:@[@"spring",@"summer",@"autumn",@"winnter"]];
     
     segmentView.tintColor       = [UIColor orangeColor];
     segmentView.selectedIndex   = 2;
     segmentView.itemHeight      = 30.f;
     segmentView.leftRightMargin = 50.f;
     segmentView.handlder        = ^ (RFSegmentView * __nullable view, NSInteger selectedIndex) {
        // doSomething
     };
     
     [self.view addSubview:segmentView];
    
     Ps:It also support delegate style callback.

 */
@interface RFSegmentView : UIView

typedef void (^selectedHandler)(RFSegmentView * __nullable view, NSInteger selectedIndex);

#pragma mark - Accessing the Delegate
///=============================================================================
/// @name Accessing the Delegate
///=============================================================================

@property (nullable, nonatomic, weak) id<RFSegmentViewDelegate> delegate;

#pragma mark - Accessing the BlockHandler
///=============================================================================
/// @name Accessing the BlockHandler
///=============================================================================

@property (nullable, nonatomic, copy) selectedHandler handlder;

#pragma mark - Configuring the Text Attributes
///=============================================================================
/// @name Configuring the Text Attributes
///=============================================================================

@property (nonatomic, strong) UIColor *tintColor; ///< set style color, default blue color.
@property (nonatomic, assign) CGFloat leftRightMargin; ///< set RFSegmentView left and right margin, default 15.f.
@property (nonatomic, assign) CGFloat itemHeight; ///< set RFSegmentView item height, default 30.f.
@property (nonatomic, assign) CGFloat cornerRadius; ///< set RFSegmentView's cornerRadius, default 3.f.
@property (nonatomic, assign, getter=currentSelectedIndex) NSUInteger selectedIndex; ///< set which item is seltected, default 0.

#pragma mark - Initializer
///=============================================================================
/// @name Initializer
///=============================================================================

/**
 *  Creates an RFSegmentView,designated initializer.
 *
 *  @param frame RFSegmentView's frame.
 *  @param items a array of titles.
 *
 *  @return a RFSegmentView instance, or nil if fail.
 */
- (instancetype)initWithFrame:(CGRect)frame
                        items:(NSArray<NSString *> * _Nonnull)items;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end

NS_ASSUME_NONNULL_END