//
//  TestCell.h
//  XQAuto
//
//  ********************************
//  Created by 马晓强 on 16/7/20.
//  深圳泥巴装
//  ********************************

#import <UIKit/UIKit.h>

@interface TestModel : NSObject


@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) BOOL isExpanded;


@end

typedef void (^testBlock)(NSIndexPath *indexPath);


@interface TestCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) testBlock block;

-(void)configCellWithModel:(TestModel *)model;

+(CGFloat)heightWithModel:(TestModel *)model;






@end
