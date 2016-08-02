//
//  ViewController.m
//  WXSTransition
//
//  Created by 王小树 on 16/5/30.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *names;
@property (nonatomic,strong) NSArray *customNames;

@end

@implementation ViewController
#pragma mark lifecycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.delegate = nil;
    self.navigationController.navigationBarHidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgView.image = [UIImage imageNamed:@"bg4"];
    [self.view addSubview:bgView];
    [self.view addSubview:self.tableView];
    
    self.navigationController.view.layer.cornerRadius = 7.0;
    self.navigationController.view.layer.masksToBounds = YES;
    
    _names = @[@"pageTransition",@"viewMove",@"cover",@"spreadFromRight",@"spreadFromLeft",@"spreadFromTop",@"spreadFromBottom",@"point spread",@"boom",@"brick openV",@"brick openH",@"brick closeV",@"brick closeH",@"fragmentShowFromRight",@"fragmentShowFromLeft",@"fragmentShowFromTop",@"fragmentShowFromBottom",@"fragmenHide"];
    _customNames = @[@"poitnt spread from tap center",@" "];
    
}
#pragma mark Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1: 
        case 2:
            return WXSTransitionAnimationTypeFragmentHide - WXSTransitionAnimationTypeDefault;
            break;
        default:
            return _customNames.count;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 25)];
    label.font = [UIFont systemFontOfSize:25];
    
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    switch (section) {
        case 0:
            label.text = @"systerm";
            break;
        case 1:
            label.text = @"push";
            break;
        case 2:
            label.text = @"present";
            break;
        default:
            label.text = @"custom";
            break;
    }
    
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 26;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"wxsIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = @"systerm";
            break;
        case 1:
        case 2:
            cell.textLabel.text = indexPath.row < _names.count ? _names[indexPath.row] : @"other";
            break;
        default:
            cell.textLabel.text = indexPath.row < _customNames.count ? _customNames[indexPath.row] : @"other";
            break;
    }
    cell.imageView.image = [UIImage imageNamed:@"start"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:{
            TableViewController *vc = [[TableViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            if (indexPath.row == 1) {
                CollectionViewController *vc = [[CollectionViewController alloc] init];
                self.navigationController.delegate = nil;
                [self.navigationController pushViewController:vc animated:YES];
                return;
            }
            
            [self.navigationController wxs_pushViewController:[[SecondViewController alloc] init] animationType:WXSTransitionAnimationTypePageTransition + indexPath.row];
        }
            break;
        case 2:{
            if (indexPath.row == 1) {
                CollectionViewController *vc = [[CollectionViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                return;
            }
            [self wxs_presentViewController:[[PresentViewController alloc] init] animationType:WXSTransitionAnimationTypePageTransition + indexPath.row completion:nil];
            
            
    
            
        }
            break;
            
        default:{
            switch (indexPath.row) {
                case 0:{
                 
                    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                    SecondViewController *vc = [[SecondViewController alloc] init];
                    vc.wxs_startView = cell.contentView;
                    [self.navigationController wxs_pushViewController:vc makeTransition:^(WXSTransitionProperty *transition) {
                        transition.animationType =  WXSTransitionAnimationTypePointSpreadPresent;
                        transition.animationTime = 1;
                        transition.backGestureEnable = NO;

                    }];
                    
                    

                }
                    break;
                case 1:{
                    
            
                    ViewController *vc = [[ViewController alloc] init];
                    [self.navigationController wxs_pushViewController:vc makeTransition:^(WXSTransitionProperty *transition) {
                        transition.animationType  = WXSTransitionAnimationTypePointSpreadPresent;
                        transition.isSysBackAnimation = YES;
                    }];
                }
                    
                default:
                    break;
            }
        }
            break;
    }

}

#pragma mark Getter
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
