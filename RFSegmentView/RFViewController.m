//
//  RFViewController.m
//  RFSegmentView
//
//  Created by 王若风 on 1/15/15.
//  Copyright (c) 2015 王若风. All rights reserved.
//

#import "RFViewController.h"
#import "RFSegmentView.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface RFViewController ()<RFSegmentViewDelegate>

@end

@implementation RFViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat initX           = 0;
    CGFloat initY           = 20.f;
    NSInteger numbersOfView = 10;
    CGFloat viewWidth       = kScreenWidth;
    CGFloat viewHeight      = (kScreenHeight - initY) / numbersOfView;
    
    for (int i = 0; i < numbersOfView; i++) {
        RFSegmentView *segmentView = [[RFSegmentView alloc] initWithFrame:CGRectMake(initX, initY, viewWidth, viewHeight)
																   titles:@[@"spring",@"summer",@"autumn",@"winnter"]];
        
        segmentView.tintColor       = [self getRandomColor];
        //segmentView.delegate      = self;
        segmentView.selectedIndex   = i%5;
//        segmentView.itemHeight      = 50.f;
        segmentView.leftRightMargin = 16.0;
//        segmentView.cornerRadius    = 5.f;
        segmentView.handlder = ^ (RFSegmentView * __nullable view, NSUInteger selectedIndex) {
            NSLog(@"view:%@ selectedIndex: %ld",view,selectedIndex);
        };
        
        [self.view addSubview:segmentView];
        
        initY += viewHeight;
    }
}

- (UIColor *)getRandomColor
{
    UIColor *color = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return color;
}

- (void)segmentView:(RFSegmentView * __nullable)segmentView didSelectedIndex:(NSUInteger)selectedIndex
{
    NSLog(@"current index is %lu",(unsigned long)index);
}

@end
