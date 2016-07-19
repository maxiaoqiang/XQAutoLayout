//
//  CompositeController.m
//  XQAuto
//
//  Created by 深圳市泥巴装网络科技有限公司 on 16/7/19.
//  Copyright © 2016年 马晓强. All rights reserved.
//

#import "CompositeController.h"

@interface CompositeController ()

@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic, assign) BOOL isNormal;


@end

@implementation CompositeController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *lastView = self.view;
    for (int i = 0; i < 6; i++) {
        UIView *view = [UIView new];
        view.backgroundColor = [self randomColor];
        view.layer.borderColor = [UIColor blackColor].CGColor;
        view.layer.borderWidth = 2;
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(lastView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
        }];
        lastView = view;
        [self.viewArray addObject:view];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
        [view addGestureRecognizer:tap];
    }
    self.isNormal = YES;

}

-(void)onTap{
    UIView *lastView = self.view;
    if (self.isNormal) {
        for (NSInteger i = self.viewArray.count - 1; i>= 0; --i) {
            UIView *itemView = [self.viewArray objectAtIndex:i];
            [itemView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(lastView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
            }];
            [self.view bringSubviewToFront:itemView];
            lastView = itemView;
        }
    }else{
        for (NSInteger i = 0; i < self.viewArray.count; ++i) {
            UIView *itemView = [self.viewArray objectAtIndex:i];
            [itemView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(lastView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
            }];
        }
    }
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.isNormal = !self.isNormal;
    }];
}


-(NSMutableArray *)viewArray{
    if (_viewArray == nil) {
        _viewArray = [NSMutableArray array];
    }
    return _viewArray;
}

-(UIColor *)randomColor{
    CGFloat r = (arc4random() % 256 / 256.0);
    CGFloat g = (arc4random() % 128 / 256.0) + 0.5;
    CGFloat b = (arc4random() % 128 / 256.0) + 0.5;
    return  [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}


@end
