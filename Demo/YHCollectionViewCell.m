//
//  YHCollectionViewCell.m
//  YHLongPressPhotoBrowser
//
//  Created by yuhechuan on 2020/6/19.
//  Copyright © 2020 yuhechuan. All rights reserved.
//

#import "YHCollectionViewCell.h"

@interface YHCollectionViewCell ()


@end

@implementation YHCollectionViewCell

- (instancetype)init {
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    [self.contentView addSubview:self.imageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

- (void)setExpressions:(NSString *)expression {
    self.imageView.image = [UIImage imageNamed:expression];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}

@end
