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
    
    float init_y = 0;
    for (int i=0; i<10; i++) {
        RFSegmentView* segmentView = [[RFSegmentView alloc] initWithFrame:CGRectMake(0, 10+init_y, kScreenWidth, 60) items:@[@"spring",@"summer",@"autumn",@"winnter"]];
        segmentView.tintColor       = [self getRandomColor];
        segmentView.delegate        = self;
//        segmentView.leftRightMargin = arc4random()%10 + 5;
//        segmentView.itemHeight      = arc4random()%10 + 25;
        
        [self.view addSubview:segmentView];
        init_y += 60;
    }

    
}

- (UIColor *)getRandomColor
{
    UIColor *color = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return color;
}

- (void)segmentViewDidSelected:(NSUInteger)index
{
    NSLog(@"current index is %lu",(unsigned long)index);
}

@end
