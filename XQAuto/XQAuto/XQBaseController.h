//
//  XQBaseController.h
//  XQAuto
//
//  ********************************
//  Created by 马晓强 on 16/7/19.
//  深圳泥巴装
//  ********************************

#import <UIKit/UIKit.h>
#define kWeakObject(obj) __weak __typeof(obj) weakObject = obj;
#define kIOSVersion ((float)[[[UIDevice currentDevice] systemVersion] doubleValue])


@interface XQBaseController : UIViewController


-(instancetype)initWithTitle:(NSString *)title;

@end
