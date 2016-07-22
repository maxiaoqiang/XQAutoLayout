//
//  TableViewController.m
//  XQAuto
//
//  Created by 深圳市泥巴装网络科技有限公司 on 16/7/20.
//  Copyright © 2016年 马晓强. All rights reserved.
//

#import "TableViewController.h"
#import "TestCell.h"


@interface TableViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;



@end

@implementation TableViewController

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[UITableView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    for (NSUInteger i = 0; i < 10; ++i) {
        TestModel *model = [[TestModel alloc] init];
        model.title = @"测试标题,可能很长很长,反正随便写吧";
        model.desc = @"描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，";
        [self.dataSource addObject:model];
    }
    [self.tableView reloadData];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"CellIdentifier";
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[TestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.indexPath = indexPath;
    cell.block = ^(NSIndexPath *path){
        [tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    };
    TestModel *model = [self.dataSource objectAtIndex:indexPath.row];
    [cell configCellWithModel:model];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TestModel *model = [self.dataSource objectAtIndex:indexPath.row];
    return [TestCell heightWithModel:model];
}





@end
