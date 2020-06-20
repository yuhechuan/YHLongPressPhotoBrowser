//
//  YHLongPressPhotoBrowser.h
//  YHLongPressPhotoBrowser
//
//  Created by yuhechuan on 2020/6/15.
//  Copyright © 2020 yuhechuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHExpression : NSObject
/*
 * 展示图标题
 */
@property (nonatomic, copy) NSString *exTitle;
/*
 * 展示图本地图片
 */
@property (nonatomic, copy) NSString *exImage;
/*
 * 展示图远端Url
 */
@property (nonatomic, copy) NSString *exImageUrl;

@end

/*
 *  用于寻求被展示的targetView(用于算出预览视图的真实frame)
 */
typedef void(^LocationInTarget)(UIView *targetView, YHExpression *expression);

@interface YHLongPressPhotoBrowser : NSObject

/*
 * gestureView 添加手势的视图
 */
- (instancetype)initWithGestureView:(UIView *)gestureView;

/*
 * bz_dataSource 当长按手势开始调用 用于寻求要预览的view 及预览view所带的属性
 */
@property (nonatomic, copy) void(^bz_dataSource)(UILongPressGestureRecognizer *recognizer, LocationInTarget locationInTarget);

/*
 * bz_expression 用于给当前展示视图赋值 为了不耦合 SDWebImage 而且可自定义表情显示方式 如果没有 直接拿本地图片
 */
@property (nonatomic, copy) void(^bz_expression)(UIImageView *displayView, YHExpression *expression);

/*
 * 展示图宽 默认是原视图宽的 2.5倍
 */
@property (nonatomic, assign) CGFloat exWidth;
/*
 * 展示图宽 默认是原视图宽的 2.5倍 + 箭头高度 7
 */
@property (nonatomic, assign) CGFloat exHeight;

/*
* 原表情 与 展示表情之间的间距 默认是 10
*/
@property (nonatomic, assign) CGFloat exMargin;

/*
* 自定义展示视图
*/
@property (nonatomic, strong) UIView *customDisplayView;


@end

NS_ASSUME_NONNULL_END
