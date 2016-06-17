//
//  TableViewController.m
//  WXSTransition
//
//  Created by 王小树 on 16/5/31.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
{
    NSArray *_names;
    
}


@end

@implementation TableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    _names = @[@"Fade",
               @"Push",@"Push",@"Push",@"Push",
               @"Reveal",@"Reveal",@"Reveal",@"Reveal",
               @"MoveIn",@"MoveIn",@"MoveIn",@"MoveIn",
               @"Cube",@"Cube",@"Cube",@"Cube",
               @"suckEffect",
               @"oglFlip",@"oglFlip",@"oglFlip",@"oglFlip",
               @"rippleEffect",
               @"pageCurl",@"pageCurl",@"pageCurl",@"pageCurl",
               @"pageUnCurl",@"pageUnCurl",@"pageUnCurl",@"pageUnCurl",
               @"CameraIrisHollowOpen",
               @"CameraIrisHollowClose"];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return WXSTransitionAnimationTypeSysCameraIrisHollowClose;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return section == 0 ? @"present" : @"push";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = indexPath.row < WXSTransitionAnimationTypeSysCameraIrisHollowClose ? _names[indexPath.row] : @"转场动画";
    
    cell.backgroundColor = [UIColor whiteColor] ;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        PresentViewController *vc = [[PresentViewController alloc] init];
        [self wxs_presentViewController:vc makeTransition:^(WXSTransitionManager *transition) {
            transition.animationType = indexPath.row + 1;
            transition.isSysBackAnimation = (int)rand()%2 < 1 ?  YES : NO;
        } completion:nil];
        
    }else{
        
        SecondViewController *vc = [[SecondViewController alloc] init];
        
        [self.navigationController wxs_pushViewController:vc makeTransition:^(WXSTransitionManager *transition) {
            transition.animationType = indexPath.row + 1;
            transition.isSysBackAnimation = (int)rand()%2 < 1 ?  YES : NO;
        }];
        
    }

    
}


@end
