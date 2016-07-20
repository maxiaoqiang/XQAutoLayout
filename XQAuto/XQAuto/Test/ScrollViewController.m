//
//  ScrollViewController.m
//  XQAuto
//
//  Created by 深圳市泥巴装网络科技有限公司 on 16/7/20.
//  Copyright © 2016年 马晓强. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor lightGrayColor];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    UILabel *lastLabel = nil;
    
    for (NSUInteger i = 0; i < 20; ++i) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.layer.borderColor = [UIColor greenColor].CGColor;
        label.layer.borderWidth = 2.0;
        label.text = [self randomText];
        
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
        }];
        lastLabel = label;
        
    }
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        //让scrollView的contentSize随着内容的增多而变化
        make. bottom.mas_equalTo(lastLabel.mas_bottom).offset(20);
    }];
    
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
