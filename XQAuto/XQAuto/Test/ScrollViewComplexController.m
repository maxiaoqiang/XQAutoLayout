//
//  ScrollViewComplexController.m
//  XQAuto
//
//  Created by 深圳市泥巴装网络科技有限公司 on 16/7/20.
//  Copyright © 2016年 马晓强. All rights reserved.
//

#import "ScrollViewComplexController.h"

@interface ScrollViewComplexController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *expandState;



@end

@implementation ScrollViewComplexController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor lightGrayColor];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    UILabel *lastLabel = nil;
    for (NSUInteger i = 0; i < 10; ++i) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.layer.borderColor = [UIColor greenColor].CGColor;
        label.layer.borderWidth = 2.0;
        label.text = [self randomText];
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [label addGestureRecognizer:tap];
        
        label.preferredMaxLayoutWidth = screenWidth - 30;
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [self randomColor];
        [self.scrollView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(self.view).offset(-15);
            
            if (lastLabel) {
                make.top.mas_equalTo(lastLabel.mas_bottom).offset(20);
            }else{
                make.top.mas_equalTo(self.scrollView).offset(20);
            }
            make.height.mas_equalTo(40);
        }];
        lastLabel = label;
        [self.expandState addObject:[@[label,@(NO)] mutableCopy]];
        
    }

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        //让scrollView的contentSize随着内容的增多而变化
        make.bottom.mas_equalTo(lastLabel.mas_bottom).offset(20);
    }];
    
}

-(NSMutableArray *)expandState{
    if (_expandState == nil) {
        _expandState = [NSMutableArray array];
    }
    return _expandState;
}

-(void)onTap:(UITapGestureRecognizer *)tap{
    UIView *tapView = tap.view;
    NSUInteger index = 0;
    for (NSMutableArray *array in self.expandState) {
        UILabel *view = [array firstObject];
        
        if (view == tapView) {
            NSNumber *state = [array lastObject];
            //当前是展开状态的话，就收缩
            if ([state boolValue] == YES) {
                [view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(40);
                }];
            }else{
                UIView *preView = nil;
                UIView *nextView = nil;
                
                if (index - 1 < self.expandState.count && index >= 1) {
                    preView = [[self.expandState objectAtIndex:index - 1] firstObject];
                }
                if (index +1 < self.expandState.count) {
                    nextView = [[self.expandState objectAtIndex:index + 1] firstObject];
                }
                [view mas_remakeConstraints:^(MASConstraintMaker *make) {
                    if (preView) {
                        make.top.mas_equalTo(preView.mas_bottom).offset(20);
                    }else{
                        make.top.mas_equalTo(20);
                    }
                    make.left.mas_equalTo(15);
                    make.right.mas_equalTo(self.view).offset(-15);
                }];
                
                if (nextView) {
                    [nextView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(view.mas_bottom).offset(20);
                    }];
                }
                
                
                
            }
            [array replaceObjectAtIndex:1 withObject:@(!state.boolValue)];
            [self.view setNeedsUpdateConstraints];
            [self.view updateConstraintsIfNeeded];
            
            [UIView animateWithDuration:0.35 animations:^{
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                
            }];
            break;
            
        }
        index ++;
    }
}


-(UIColor *)randomColor{
    CGFloat hue =(arc4random() % 256 / 256.0);
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
}

-(NSString *)randomText{
    CGFloat length = arc4random()% 50 + 5;
    NSMutableString *str = [[NSMutableString alloc] init];
    for (NSUInteger i = 0; i < length; ++i) {
        [str appendString:@"逗你玩之豆豆豆,"];
    }
    return str;
}

@end
