//
//  Person.h
//  RuntimeDemo
//
//  Created by XSX on 16/3/15.
//  Copyright © 2016年 hivebox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Person : NSObject

@property(nonatomic,assign) NSInteger age;
@property(nonatomic ,copy) NSString *name;
@property(nonatomic ,copy) NSString *sex;
@property(nonatomic ,assign) float heightg;
@property(nonatomic ,assign) NSString *family;
@property(nonatomic,assign) double weight;
@property(nonatomic,assign) NSArray *moneyArr;
@property(nonatomic,assign) CGFloat hehe;
@end
