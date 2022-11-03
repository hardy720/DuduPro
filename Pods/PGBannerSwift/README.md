# PGBannerSwift
Swift版的 自定义控件无限轮播 + 无限图片轮播

![PGBanner.gif](http://upload-images.jianshu.io/upload_images/1340308-cb071aad23c7d951.gif?imageMogr2/auto-orient/strip)

# CocoaPods安装
```
pod 'PGBannerSwift'
```
使用```pod update```安装

# 使用
1、无限图片轮播

首先引入```import PGBannerSwift```

```
let banner = PGBanner(frame: self.customView.bounds, imageNameList: ["photo1", "photo2", "photo3"], timeInterval: 3.0)
banner.delegate = self
self.view.addSubview(banner)

// MARK: - PGBannerDelegate
func selectAction(didselectAtIndex index: NSInteger, didSelectView view: Any) {
    print("index = ", index, "view = ", view)
}
    
```
2、自定义控件无限轮播
> 使用自定义控件轮播时，需要注意两点  
> 
> 1、一定要把需要轮播的第一个view放到数组的最后位置  
> 2、一定要把需要轮播的最后一个view放到数组的第一个位置

首先引入```import PGBannerSwift```

```
let view1: CustomView = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)?.first as! CustomView
view1.index = 0

let view2: CustomView = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)?.first as! CustomView
view2.index = 1

let view3: CustomView = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)?.first as! CustomView
view3.index = 2

//将最后一个view放到数组的第一个位置
let view0: CustomView = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)?.first as! CustomView
view0.index = 2

//将第一个view放到数组的第最后位置
let view4: CustomView = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)?.first as! CustomView
view4.index = 0

let banner = PGBanner(frame: self.customView.bounds, viewList: [view0, view1, view2, view3, view4], timeInterval: 3.0)
banner.delegate = self
self.customView.addSubview(banner)

// MARK: - PGBannerDelegate
func selectAction(didselectAtIndex index: NSInteger, didSelectView view: Any) {
    print("index = ", index, "view = ", view)
}
    
```
# OC版本
[https://github.com/xiaozhuxiong121/PGBanner](https://github.com/xiaozhuxiong121/PGBanner)
