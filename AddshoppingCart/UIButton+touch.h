//
//  UIButton+touch.h
//  RMRuntime
//
//  Created by Raymon on 16/6/8.
//  Copyright © 2016年 Raymon. All rights reserved.
//

#import <UIKit/UIKit.h>
#define defaultInterval .7// 默认间隔时间
@interface UIButton (touch)
/**
 *  设置点击时间间隔
 */
@property (nonatomic, assign) NSTimeInterval timeInterVal;
@end
