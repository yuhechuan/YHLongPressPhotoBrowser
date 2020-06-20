//
//  ViewController.m
//  YHLongPressPhotoBrowser
//
//  Created by yuhechuan on 2020/6/15.
//  Copyright © 2020 yuhechuan. All rights reserved.
//

#import "ViewController.h"
#import "YHButton.h"
#import "YHCollectionViewController.h"

@interface ViewController ()

@property (nonatomic, strong) YHButton *display;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
}

- (void)setUp {
    self.title = @"项目演示";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = 200;
    CGFloat height = 50;
    CGFloat x = (self.view.bounds.size.width - width) / 2.0;
    CGFloat y1 = 200;
    _display = [[YHButton alloc]initWithFrame:CGRectMake(x, y1, width, height)];
    _display.title = @"表情展示";
    _display.buttonColor = [UIColor colorWithRed:70 / 225.0 green:187 / 255.0 blue:38 / 255.0 alpha:1];
    typeof(self) __weak weakSelf = self;
    _display.operation = ^{
        [weakSelf displayAnimation];
    };
    [self.view addSubview:_display];
}

- (void)displayAnimation {
    YHCollectionViewController *s = [[YHCollectionViewController alloc]init];
    [self.navigationController pushViewController:s animated:YES];
}


@end
