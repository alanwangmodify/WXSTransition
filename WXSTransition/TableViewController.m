//
//  TableViewController.m
//  WXSTransition
//
//  Created by 王小树 on 16/5/31.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
@property (nonatomic, strong) NSArray *array;

@end

@implementation TableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _array = @[@"淡入淡出",@"立方体",@"推入",@"移动进入",@"解开"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _array[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
    //因为一个事件循环机制中
    CATransition *tran=[CATransition animation];
    tran.duration=0.75;
    tran.type=@"pageCurl";
    tran.subtype=kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:tran forKey:nil];
//
    SecondViewController *vc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    [self.view.layer addAnimation:tran forKey:@"tran"];
    
//    [self presentViewController:vc animated:YES completion:^{
    
//    }];
    
//    [UIView transitionWithView:self.navigationController.view duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
//        SecondViewController *vc = [[SecondViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];        } completion:^(BOOL finished) {
//
//    }];
}


-(void)sysTransitionWithType:(WXSTransitionSysAnimationType)type directionType:(NSString *)subTypeStr{
    
    
}

-(void)sysTransitionWithType:(WXSTransitionSysAnimationType)type {
    
    CATransition *tran=[CATransition animation];
    tran.duration=0.75;
    tran.type=@"pageCurl";
    tran.subtype=kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:tran forKey:nil];
    
    
}
@end
