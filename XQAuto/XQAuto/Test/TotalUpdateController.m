//
//  TotalUpdateController.m
//  XQAuto
//
//  Created by 深圳市泥巴装网络科技有限公司 on 16/7/19.
//  Copyright © 2016年 马晓强. All rights reserved.
//

#import "TotalUpdateController.h"

@interface TotalUpdateController ()

@property (nonatomic, assign) BOOL isExpanded;
@property (nonatomic, strong) UIView *purpleView;
@property (nonatomic, strong) UIView *orangeView;




@end

@implementation TotalUpdateController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *purpleView = [[UIView alloc] init];
    purpleView.backgroundColor = [UIColor purpleColor];
    purpleView.layer.borderColor = [UIColor blackColor].CGColor;
    purpleView.layer.borderWidth = 2;
    [self.view addSubview:purpleView];
    purpleView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [purpleView addGestureRecognizer:tap];
    self.purpleView = purpleView;
    
    
    UIView *orangeView = [UIView new];
    orangeView.backgroundColor = [UIColor orangeColor];
    orangeView.layer.borderColor = [UIColor blackColor].CGColor;
    orangeView.layer.borderWidth = 2;
    [self.view addSubview:orangeView];
    self.orangeView = orangeView;
    
    //这里，我们不使用updateViewContraints方法,但是我们一样可以做到
    //不过苹果推荐在updateViewContraints方法中更新或者添加约束
    [self updateWithExpand:NO animated:NO];

    
    UILabel*label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"点击purple部分放大,orange部分最大值250，最小值90";
    [self.purpleView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
    }];
    
    
}


-(void)updateWithExpand:(BOOL)isExpanded animated:(BOOL)animated{
    self.isExpanded = !isExpanded;
    [self.purpleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        if (isExpanded) {
            make.bottom.mas_equalTo(-20);
        }else{
            make.bottom.mas_equalTo(-300);
        }
    }];
    
    [self.orangeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.purpleView);
        //这里使用优先级处理
        //设置其最大值250，最小值90；
        if (!isExpanded) {
            make.width.height.mas_equalTo(100 * 0.5).priorityLow()
            ;
        }else{
            make.width.height.mas_equalTo(100 * 3).priorityLow();
        }
        //最大值为250
        make.width.height.lessThanOrEqualTo(@250);
        //最小值
        make.width.height.greaterThanOrEqualTo(@90);
    }];
    
   
    if (animated) {
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    
    
    
}







-(void)onTap{
    [self updateWithExpand:self.isExpanded animated:YES];
}

@end
