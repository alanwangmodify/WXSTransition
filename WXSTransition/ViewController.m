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
//    self.navigationController.delegate = nil;
    self.navigationController.navigationBarHidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    _names = @[@"pageTransition",@"viewMove",@"cover",@"spread Present",@"point spread",@"boom",@"brick openV",@"brick openH",@"brick closeV",@"brick closeH"];
}
#pragma mark Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
        case 2:
            return WXSTransitionAnimationTypeBrickCloseHorizontal - WXSTransitionAnimationTypeDefault;
            break;
        default:
            return 10;
            break;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"systerm";
            break;
        case 1:
            return @"push";
            break;
        case 2:
            return @"present";
            break;
        default:
            return @"custom";
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"wxsIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
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
            cell.textLabel.text = @"00";
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

        }
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
}

@end
