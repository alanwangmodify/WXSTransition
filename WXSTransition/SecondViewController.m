//
//  SecondViewController.m
//  WXSTransition
//
//  Created by 王小树 on 16/5/30.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

-(void)dealloc{
    NSLog(@"SecondViewController dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgView.image = [UIImage imageNamed:@"bg2"];
    [self.view addSubview:bgView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    btn.center = self.view.center;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"点我 返回上个界面" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
//    
//    self.navigationController.navigationBarHidden = NO;

}

-(void)click{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
