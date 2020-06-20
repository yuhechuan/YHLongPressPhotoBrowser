//
//  YHCollectionViewController.m
//  YHLongPressPhotoBrowser
//
//  Created by yuhechuan on 2020/6/19.
//  Copyright © 2020 yuhechuan. All rights reserved.
//

#import "YHCollectionViewController.h"
#import "YHCollectionViewCell.h"
#import "YHLongPressPhotoBrowser.h"

@interface YHCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) YHLongPressPhotoBrowser *photoBrowser;
@property (nonatomic, strong) UIView *customView;

@end

@implementation YHCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat wh  = ([UIScreen mainScreen].bounds.size.width - 30 - 6 *25) / 7.0;
    layout.itemSize = CGSizeMake(wh, wh);
    // 设置最小行间距
    layout.minimumLineSpacing = 18;
    // 设置垂直间距
    layout.minimumInteritemSpacing = 25;
    // 设置边缘的间距，默认是{0，0，0，0}
    layout.sectionInset = UIEdgeInsetsMake(20 + 100, 15, 20, 15);
    return [self initWithCollectionViewLayout:layout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.title = @"表情";
    // Register cell classes
    self.view.backgroundColor = [UIColor blackColor];
    self.collectionView.backgroundColor = [UIColor blackColor];
    [self.collectionView registerClass:[YHCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    __weak typeof(self) weakself = self;
    self.photoBrowser.bz_dataSource = ^(UILongPressGestureRecognizer * _Nonnull recognizer, LocationInTarget  _Nonnull locationInTarget) {
        [weakself locationInImageView:recognizer
                     locationInTarget:locationInTarget];
    };
    
    NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"boss_emoji" ofType:@"plist"]];
    
    [dataDict enumerateKeysAndObjectsUsingBlock:^(NSString  *_Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        YHExpression *e = [YHExpression new];
        e.exImage = obj;
        e.exTitle = key;
        [self.dataList addObject:e];
    }];
    [self.collectionView reloadData];
    // Do any additional setup after loading the view.
}

- (void)locationInImageView:(UILongPressGestureRecognizer*)recognizer
           locationInTarget:(LocationInTarget)locationInTarget {
    CGPoint locationTable = [recognizer locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:locationTable];
    YHCollectionViewCell *targetCell = (YHCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    YHExpression *e = self.dataList[indexPath.item];
    locationInTarget(targetCell.imageView,e);
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    YHExpression *e = self.dataList[indexPath.item];
    [cell setExpressions:e.exImage];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (YHLongPressPhotoBrowser *)photoBrowser {
    if (!_photoBrowser) {
        _photoBrowser = [[YHLongPressPhotoBrowser alloc]initWithGestureView:self.view];
    }
    return _photoBrowser;
}

- (UIView *)customView {
    if (!_customView) {
        _customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        _customView.backgroundColor = [UIColor redColor];
    }
    return _customView;
}

-(void)dealloc {
    NSLog(@"YHCollectionViewController dealloc");
}

@end
