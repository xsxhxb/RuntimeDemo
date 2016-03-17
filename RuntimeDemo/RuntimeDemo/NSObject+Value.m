//
//  NSObject+Value.m
//  RuntimeDemo
//
//  Created by XSX on 16/3/16.
//  Copyright © 2016年 hivebox. All rights reserved.
//

#import "NSObject+Value.h"
#import <objc/runtime.h>
#import <objc/message.h>


@implementation NSObject (Value)
-(void)setValue:(NSDictionary *)valueDictionary{
    Class currentClass = [self class];
    while (currentClass) {
        unsigned int count = 0;
        Ivar *classIvar = class_copyIvarList(currentClass, &count);
        for (NSInteger i = 0; i < count; i++) {
            Ivar ivar = classIvar[i];
            const char *ivarName = ivar_getName(ivar);//获取当前变量名
            NSMutableString *propertyName = [NSMutableString stringWithUTF8String:ivarName]; //设置为变量方便重新设置字符
            NSLog(@"propertyName ==== %@",propertyName);
            [propertyName replaceCharactersInRange:NSMakeRange(0, 1) withString:@""]; //去掉“-”
            id value = valueDictionary[propertyName]; //取出当前值
            if (!value) {
                //过滤空防止crash
                continue;
            }
            NSString *firstChar = [propertyName substringToIndex:1];//取出首字符
            firstChar = [firstChar uppercaseString];
            [propertyName replaceCharactersInRange:NSMakeRange(0, 1) withString:firstChar];//替换大写
            [propertyName insertString:@"set" atIndex:0];//插入set 拼凑set方法
            [propertyName appendString:@":"];
            const char *type = ivar_getTypeEncoding(ivar);
            NSString *propertyType = [NSString stringWithUTF8String:type];
            NSLog(@"type ==== %@",propertyType);
            SEL messageSel = NSSelectorFromString([propertyName copy]);
            NSLog(@"sel === %@",propertyName);
            //有@为对象类型
            if ([propertyType hasPrefix:@"@"]) {
                objc_msgSend(self,messageSel,value);
            }else{
            //基本数据类型
                if ([propertyType hasPrefix:@"d"]) {
                    objc_msgSend(self, messageSel,[value doubleValue]);
                }if ([propertyType hasPrefix:@"l"]) {
                    objc_msgSend(self, messageSel,[value longValue]);
                }if ([propertyType hasPrefix:@"f"]) {
                    objc_msgSend_fpret(self, messageSel,[value doubleValue]);
                }if ([propertyType hasPrefix:@"q"]) {
                    objc_msgSend(self, messageSel,[value integerValue]);
                }else{
                    objc_msgSend(self, messageSel,[value longLongValue]);
                }
            
            }
        }
        currentClass = class_getSuperclass(currentClass);
        
    }


}

@end
