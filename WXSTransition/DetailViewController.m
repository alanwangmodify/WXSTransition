//
//  DetailViewController.m
//  WXSTransition
//
//  Created by 王小树 on 16/5/31.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation DetailViewController
-(void)dealloc{
    NSLog(@"DetailViewController dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    
    self.targetView = self.imageView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}

-(void)tapAction {
    if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
    }
    [self.navigationController popViewControllerAnimated:YES];

}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _imageView.center = self.view.center;
        _imageView.image = [UIImage imageNamed:@"img"];
    }
    return _imageView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
