//
//  Person.m
//  RuntimeDemo
//
//  Created by XSX on 16/3/15.
//  Copyright © 2016年 hivebox. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{


}


-(NSDictionary*)convertModelToDic{
    NSArray* propertiesArray=[self GetPropertiesNameMethod];
    NSMutableDictionary* dic=[[NSMutableDictionary alloc] init];
    for (NSString* propertyName in propertiesArray) {
        if (propertyName) {
            id propertyValue=[self valueForKey:propertyName];
            
            if(propertyValue)
            {
                [dic setObject:propertyValue forKey:propertyName];
            }
            else
            {
                [dic setObject:@"" forKey:propertyName];
            }
            
        }
    }
    return [dic copy];
}

- (NSArray*)GetPropertiesNameMethod {
    
    NSMutableArray* properListarray=[[NSMutableArray alloc] init];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            NSString *propertyName = [NSString stringWithCString:propName
                                                        encoding:[NSString defaultCStringEncoding]];

            [properListarray addObject:propertyName];
        }
    }
    free(properties);
    return properListarray;
}


-(NSDictionary *)converToDictionary{
    
    return nil;
}

//-(NSString *)description{
//    return [NSString stringWithFormat:@"%@",[self convertModelToDic].description];
//}

@end
