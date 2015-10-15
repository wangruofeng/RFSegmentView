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
    
    float initY = 0;
    for (int i=0; i<10; i++) {
        RFSegmentView* segmentView = [[RFSegmentView alloc] initWithFrame:CGRectMake(0, 10 + initY, kScreenWidth, 60) items:@[@"spring",@"summer",@"autumn",@"winnter"]];
        segmentView.tintColor       = [self getRandomColor];
        segmentView.delegate        = self;
        segmentView.selectedIndex   = i%5;
        
        initY += 60;
        
        [self.view addSubview:segmentView];
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
