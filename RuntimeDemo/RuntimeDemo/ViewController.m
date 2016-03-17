//
//  ViewController.m
//  RuntimeDemo
//
//  Created by XSX on 16/3/15.
//  Copyright © 2016年 hivebox. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "NSObject+Value.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    Person *person = [[Person alloc] init];
    NSDictionary *personInfo = @{@"age":@12,@"ag3":@12,@"name":@"xsx",@"heightg":[NSNumber numberWithFloat:166.0],@"family":@"xu",@"hehe"
                                 :@99};
    
    
//    [person setValuesForKeysWithDictionary:personInfo];
    [person setValue:personInfo];
    
    NSLog(@"person value ==== %@ heiht ==== %f",person,person.heightg);
    
//    class_getName([person class]);
//    unsigned int count ;
//    objc_property_t *vars = class_copyPropertyList([person class], &count);
//    for (NSInteger i = 0; i<count; i++) {
//        objc_property_t single = vars[i];
//        const char *name = property_getName(single);
//        NSString *tureName = [NSString stringWithUTF8String:name];
//        NSLog(@"true Name ==== %@",tureName);
//    }
    
}
- (IBAction)openMobileAuthen:(UIButton *)sender {
    LAContext *lacontext = [[LAContext alloc] init];
    NSError *error =nil;
    if ([lacontext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
       __block  NSString *errorReson = nil;
        [lacontext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"我的测试" reply:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                switch (error.code) {
                    case LAErrorSystemCancel:
                        errorReson = @"系统切换";
                        break;
                    case LAErrorUserCancel:
                        errorReson = @"用户取消";
                        break;
                    case LAErrorUserFallback:
                        errorReson = @"验证失败";
                        break;
                    default:
                        errorReson = @"其他问题";
                        break;
                        
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"验证失败" message:errorReson preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"验证成功" message:@"hahahaha" preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                });

//                [self performSelector:@selector(dismissViewControllerAnimated:completion:) withObject:nil afterDelay:2.0];
//                [alertController dismissViewControllerAnimated:YES completion:nil];
            }

        }];
    }
    
}

- (IBAction)ariDropAction:(UIButton *)sender {
    NSURL *fileUrl = [self fileToURL:@"person_seting@3x.png"];
    NSArray *shareArr = @[fileUrl];
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:shareArr applicationActivities:nil];
    NSArray *excludedActivities = @[
                                    UIActivityTypePostToWeibo,
                                    UIActivityTypeMessage, UIActivityTypeMail,
                                    UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                                    UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,
                                    UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr,
                                    UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo];
    activity.excludedActivityTypes = excludedActivities;
    [self presentViewController:activity animated:YES completion:nil];
}


-(NSURL *)fileToURL:(NSString *)fileName{
    NSArray *fileArr = [fileName componentsSeparatedByString:@"."];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileArr[0] ofType:fileArr[1]];
    return [NSURL fileURLWithPath:filePath];
}

@end
