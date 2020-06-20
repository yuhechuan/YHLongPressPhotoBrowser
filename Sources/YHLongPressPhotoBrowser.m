//
//  YHLongPressPhotoBrowser.m
//  YHLongPressPhotoBrowser
//
//  Created by yuhechuan on 2020/6/15.
//  Copyright © 2020 yuhechuan. All rights reserved.
//

#import "YHLongPressPhotoBrowser.h"

@implementation YHExpression
@end

@interface YHLongPressPhotoBrowser ()

/*
 * 需要展示的表情视图
 */
@property (nonatomic, strong) UIView *targetView;
/*
 * 添加手势的视图
 */
@property (nonatomic, weak)  UIView *gestureView;
/*
 * 长按手势
 */
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
/*
 * 添加手势的视图
 */
@property (nonatomic, strong)  UIImageView *dispalyView;
/*
* 展示放大的背景图
*/
@property (nonatomic, strong)  UIImageView *dispalyImage;

/*
* 展示放大的图标 描述
*/
@property (nonatomic, strong)  UILabel *dispalyLabel;

/*
* 展示放大的视图
*/
@property (nonatomic, strong)  UIView *showView;


@end

@implementation YHLongPressPhotoBrowser

- (instancetype)initWithGestureView:(UIView *)gestureView {
    if (self = [super init]) {
        _gestureView = gestureView;
        _longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
        [_gestureView addGestureRecognizer:_longPress];
        _exMargin = 10;
    }
    return self;
}

- (void)longPressAction:(UILongPressGestureRecognizer *)recognizer {
    if (self.bz_dataSource) {
        __weak typeof(self) weakself = self;
        self.bz_dataSource(recognizer, ^(UIView * _Nonnull targetView, YHExpression * _Nonnull expression) {
            [weakself locationInTargetView:targetView
                                expression:expression
                                recognizer:recognizer];
        });
    }
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
           break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        {
           [self hideDisplayView];
        }
           break;
        default:
        {
          [self hideDisplayView];
        }
           break;
    }
}

- (void)locationInTargetView:(UIView *)targetView
                  expression:(YHExpression *)expression
                 recognizer:(UILongPressGestureRecognizer *)recognizer {
    if (!targetView) {
        return;
    }
    CGRect targetRect = [self.gestureView convertRect:targetView.frame fromView:targetView.superview];
    if (self.exWidth == 0) {
        self.exWidth = targetRect.size.width *2.5;
    }
    if (self.exHeight == 0) {
        CGFloat dispalyImagewh = self.exWidth - 18 *2;
        self.exHeight =  dispalyImagewh + 8 + 2 + 20 + 7 + 10;
    }
    
    CGFloat display_x = targetRect.origin.x - (self.showView.frame.size.width - targetRect.size.width) / 2.0;
    CGFloat display_y = targetRect.origin.y - (self.showView.frame.size.height + self.exMargin);
    if (display_x < 0) {
        display_x = 0;
    }
    
    CGFloat max_x = [UIScreen mainScreen].bounds.size.width - self.showView.frame.size.width;
    if (display_x > max_x) {
        display_x = max_x;
    }
    [self showDisplayView:display_x
                display_y:display_y];
    
    if (self.showView != self.dispalyView) {
        return;
    }
    if (self.bz_expression) {
        self.bz_expression(self.dispalyImage, expression);
    } else {
        self.dispalyImage.image = [UIImage imageNamed:expression.exImage];
    }
    self.dispalyLabel.text = expression.exTitle;
}

- (void)showDisplayView:(CGFloat)display_x
              display_y:(CGFloat)display_y {
    if (!self.dispalyView.superview) {
        [self.gestureView addSubview:self.showView];
        [self.gestureView bringSubviewToFront:self.showView];
    }
    self.showView.frame = CGRectMake(display_x, display_y, self.showView.frame.size.width, self.showView.frame.size.height);
    [UIView animateWithDuration:0.25 animations:^{
        self.showView.alpha = 1;
    }];
}

- (void)hideDisplayView {
    [UIView animateWithDuration:0.25 animations:^{
        self.showView.alpha = 0;
    } completion:^(BOOL finished) {
    }];
}

- (UIImageView *)dispalyView {
    if (!_dispalyView) {
        _dispalyView = [[UIImageView alloc]initWithFrame:CGRectMake(-1000, -1000, self.exWidth, self.exHeight)];
        UIEdgeInsets edge = UIEdgeInsetsMake(10, 10, 10, 10);
        UIImage * frameImg1 = [UIImage imageNamed:@"expression_bg@2x.png"];
        frameImg1 = [frameImg1 resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
        _dispalyView.image = frameImg1;
        _dispalyView.contentMode = UIViewContentModeScaleToFill;
        _dispalyView.alpha = 0;
        [_dispalyView addSubview:self.dispalyImage];
        [_dispalyView addSubview:self.dispalyLabel];
    }
    return _dispalyView;
}

- (UIImageView *)dispalyImage {
    if (!_dispalyImage) {
        CGFloat dispalyImagex = 18;
        CGFloat dispalyImagey = 8;
        CGFloat dispalyImagewh = self.exWidth - dispalyImagex *2;
        _dispalyImage = [[UIImageView alloc]initWithFrame:CGRectMake(dispalyImagex, dispalyImagey, dispalyImagewh, dispalyImagewh)];
    }
    return _dispalyImage;;
}

- (UILabel *)dispalyLabel {
    if (!_dispalyLabel) {
        _dispalyLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.dispalyImage.frame.origin.x, CGRectGetMaxY(self.dispalyImage.frame) + 2, self.dispalyImage.frame.size.width, 20)];
        _dispalyLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _dispalyLabel.textColor = [UIColor colorWithRed:170 / 255.0 green:170 / 255.0 blue:170 / 255.0 alpha:1];
        _dispalyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dispalyLabel;
}

- (UIView *)showView {
    return self.customDisplayView ?: self.dispalyView;
}

-(void)dealloc {
    [self.showView removeFromSuperview];
}

@end
