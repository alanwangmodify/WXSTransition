//
//  WXSBaseViewController.m
//  WXSTransition
//
//  Created by thejoyrun on 16/7/8.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "WXSBaseViewController.h"

@interface WXSBaseViewController ()

@end

@implementation WXSBaseViewController

-(void)dealloc {
    NSLog(@"%@ dealloc",  NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
