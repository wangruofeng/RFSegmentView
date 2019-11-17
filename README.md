# iOS RFSegmentView
Imitate after iOS7 style segmented controls!
***It is simple, Elegant, practical！***


##  Requirements
_**iOS8.0 and later**_


##  Usage

### install via source code

1. download  the newest code , and `#import "RFSegmentView.h"`
2. use blow method to initialize
```objective-c
 - (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles; 
```
3. set TintColor and delegate or block handler if needed
4. implement delegate callBack function if you use delegate
```objective-c
- (void)segmentView:(RFSegmentView * __nullable)segmentView didSelectedIndex:(NSUInteger)selectedIndex;
```
or use block callback 
```objective-c
segmentView.handlder = ^ (RFSegmentView * __nullable view, NSUInteger selectedIndex) {
	// doSomething
};
```

### install via CocoaPod

first add to config to Podfile
```ruby
pod 'RFSegmentView', '~>1.3.0'
```

then import header file and  enjoy it.
```objective-c
#import <RFSegmentView.h>
```

###  below is sample code

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
