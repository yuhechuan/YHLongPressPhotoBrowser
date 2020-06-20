//
//  YHCollectionViewCell.h
//  YHLongPressPhotoBrowser
//
//  Created by yuhechuan on 2020/6/19.
//  Copyright © 2020 yuhechuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

- (void)setExpressions:(NSString *)expression;

@end

NS_ASSUME_NONNULL_END
