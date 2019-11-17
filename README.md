# iOS RFSegmentView
Imitate after iOS7 style segmented controls!
***It is simple, Elegant, practical！***


##  Requirements
_**iOS8.0 and later**_


##  Usage
1. `#import "RFSegmentView.h"`
2. use `- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles;` to initialize
3. set TintColor and delegate or block handler
4. implement delegate callBack function `- (void)segmentView:(RFSegmentView * __nullable)segmentView didSelectedIndex:(NSUInteger)selectedIndex` if you use delegate,or use block callback `segmentView.handlder = ^ (RFSegmentView * __nullable view, NSUInteger selectedIndex) {
          // doSomething
        };`

                                         

#### below is sample code
```objective-c

  RFSegmentView* segmentView = [[RFSegmentView alloc] initWithFrame:aRect titles:@[@"spring",@"summer",@"autumn",@"winnter"]];
  segmentView.tintColor       = aColor;
  //segmentView.delegate      = self;
  segmentView.handlder = ^ (RFSegmentView * __nullable view, NSUInteger selectedIndex) {
          // doSomething
  };
  [self.view addSubview:segmentView];
```

Ps:you can also use delegate callback.

## Screenshot
<!--![(Screenshot)](https://github.com/wangruofeng/RFSegmentView/raw/master/RFSegmentView/samplePic.png)-->
<img src ="https://github.com/wangruofeng/RFSegmentView/raw/master/RFSegmentView/samplePic.png" witdh = 320 height = 576>


##  Download
####  You can download binary release from the [latest releases](https://github.com/wangruofeng/RFSegmentView/archive/master.zip).


## License
RFSegmentView is released under the MIT license. See [LICENSE](/LICENSE) for details.
