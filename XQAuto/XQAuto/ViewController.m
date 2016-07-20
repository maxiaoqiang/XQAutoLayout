//
//  ViewController.m
//  XQAuto
//
//  Created by 深圳市泥巴装网络科技有限公司 on 16/7/19.
//  Copyright © 2016年 马晓强. All rights reserved.
//

#import "ViewController.h"
#import "RemakeContraintsController.h"
#import "TotalUpdateController.h"
#import "CompositeController.h"
#import "AspectFitController.h"
#import "BaseAnimatedController.h"
#import "ScrollViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];

    self.controllers = @[[[RemakeContraintsController alloc]initWithTitle:@"动画重新添加约束"],[[TotalUpdateController alloc]initWithTitle:@"整体动画更新约束"],[[CompositeController alloc]initWithTitle:@"复合View循环约束"],[[AspectFitController alloc]initWithTitle:@"约束百分比"],[[BaseAnimatedController alloc]initWithTitle:@"基本动画"],[[ScrollViewController alloc]initWithTitle:@"ScrollView布局"],];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kCellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    
    UIViewController *viewController = self.controllers[indexPath.row];
    cell.textLabel.text = viewController.title;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.controllers.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *viewController = self.controllers[indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
   

}


@end
