# YHLongPressPhotoBrowser

YHPinchPhotoBrowser

Travis CocoaPods CocoaPods CocoaPods Laguage CocoaPods LeoDev GitHub stars

☀️ 一个快速集成表情长按预览的组件

In me the tiger sniffs the rose.

心有猛虎，细嗅蔷薇。
欢迎访问我的博客：https://www.jianshu.com/u/7c43d8cb3cff

iOS 9.0+
Xcode 9.0+
Objective-C 
介绍 Introduction

☀️ 一个快速集成表情长按预览的组件

其中主要用到了 UILongPressRecognizer 手势 支持自定义视图预览

![功能展示图](https://github.com/yuhechuan/YHLongPressPhotoBrowser/blob/master/WechatIMG16781.jpeg)

### 使用方法
```
// 导入头文件
#import "YHLongPressPhotoBrowser.h"

```
#### 1.控制器中使用
```
- (YHLongPressPhotoBrowser *)photoBrowser {
    if (!_photoBrowser) {
        _photoBrowser = [[YHLongPressPhotoBrowser alloc]initWithGestureView:self.view];
    }
    return _photoBrowser;
}

__weak typeof(self) weakSelf = self;
self.yhPhotoBrowser.bz_dataSource = ^(UIPinchGestureRecognizer * _Nonnull recognizer, LocationInTarget  _Nonnull locationInTarget) {
       if (locationInTarget) {
           locationInTarget(weakSelf.sinleImageView);
       }
   };
```
#### 2.表情在CollectView上时
```
- (void)locationInImageView:(UILongPressGestureRecognizer*)recognizer
           locationInTarget:(LocationInTarget)locationInTarget {
    CGPoint locationTable = [recognizer locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:locationTable];
    YHCollectionViewCell *targetCell = (YHCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    YHExpression *e = self.dataList[indexPath.item];
    locationInTarget(targetCell.imageView,e);
}
```
