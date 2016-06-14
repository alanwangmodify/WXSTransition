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

@end

@implementation ViewController
#pragma mark lifecycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
#ifdef DEBUG
    NSLog(@"ViewController show");
#endif

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    _names = @[@"sys",@"pageTransition",@" ",@"cover",@"present",@"spread Present",@"boom",@"brick",@""];
}
#pragma mark Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _names.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"wxsIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.textLabel.text = _names[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"start"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            TableViewController *vc = [[TableViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            SecondViewController *vc  = [[SecondViewController alloc] init];            
            [self.navigationController wxs_pushViewController:vc makeTransition:^(WXSTransitionManager *transition) {
                transition.animationType = WXSTransitionAnimationTypePageTransition;
            }];

        }
            break;
            
        case 2:{
            
            CollectionViewController *vc = [[CollectionViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{ //cover
            
            SecondViewController *vc  = [[SecondViewController alloc] init];
            
            [self.navigationController wxs_pushViewController:vc makeTransition:^(WXSTransitionManager *transition) {
                
                transition.animationType = WXSTransitionAnimationTypeCover;
                transition.isSysBackAnimation = YES;
            }];
    
            
        }
            break;
        case 4:{
            PresentViewController *vc  = [[PresentViewController alloc] init];
            [self wxs_presentViewController:vc makeTransition:^(WXSTransitionManager *transition) {
                transition.animationTime = 1;
                transition.animationType = WXSTransitionAnimationTypePageTransition;
            }];            
            
        }
            break;
        case 5:{
            PresentViewController *vc  = [[PresentViewController alloc] init];
            
            [self wxs_presentViewController:vc makeTransition:^(WXSTransitionManager *transition) {
                transition.animationType = WXSTransitionAnimationTypeSpreadPresent;
                transition.animationTime = 0.65;
            }];
        }
            break;
        case  6:{
            PresentViewController *vc = [[PresentViewController alloc] init];
            [self wxs_presentViewController:vc animationType:WXSTransitionAnimationTypeBoom completion:nil];
        }
            break;
            
        case 7:{
            
            [self.navigationController wxs_pushViewController:[[SecondViewController alloc] init] makeTransition:^(WXSTransitionManager *transition) {
                transition.isSysBackAnimation = YES;
                transition.animationTime = 4;
                transition.animationType = WXSTransitionAnimationTypeBrick;
            }];
        }
            break;
        default:
            break;
    }
    
    
}

#pragma mark Getter
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
