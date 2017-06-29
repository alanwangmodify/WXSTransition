//
//  WXSTestViewController.m
//  WXSTransition
//
//  Created by fenqile on 2017/6/19.
//  Copyright © 2017年 王小树. All rights reserved.
//

#import "WXSTestViewController.h"
#import "UINavigationController+WXSTransition.h"
#import "WXSTestViewController.h"
@interface WXSTestViewController ()

@end

@implementation WXSTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgView.image = [UIImage imageNamed:@"bg4"];
    [self.view addSubview:bgView];
    
    
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(30, 100, 200, 50);
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:@"多级跳转" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(multiVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btn1 = [[UIButton alloc] init];
    btn1.frame = CGRectMake(30, 200, 200, 50);
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"无自定义" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(nomalPush) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
}
- (void)multiVC {
    WXSTestViewController *vc = [[WXSTestViewController alloc] init];
    [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeBrickCloseVertical];
}

- (void)nomalPush {
    WXSTestViewController *vc = [[WXSTestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
