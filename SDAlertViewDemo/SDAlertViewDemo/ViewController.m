//
//  ViewController.m
//  Test
//
//  Created by 沙莎 on 16/9/5.
//  Copyright © 2016年 沙莎. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>


static void *SDMyAlertViewKey = @"SDMyAlertViewKey";


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableSet *set = [NSMutableSet new];
    
    NSArray *array = @[@"name",@1];
    
    NSMutableArray *mutableArray = [array mutableCopy];
    
    [set addObject:mutableArray];
    
    
     NSMutableArray *mutableArray1 = [@[@"name",@1] mutableCopy];
    
    [set addObject:mutableArray1];
    
    NSLog(@"-----%@",set);
    
    NSMutableArray *mutableArray2 = [@[@"name"] mutableCopy];
    [set addObject:mutableArray2];
    
    [mutableArray2 addObject:@1];
     NSLog(@"-----%@",set);
    
    
    NSMutableSet *set1  = [set mutableCopy];
    NSLog(@"--set1---%@",set1);
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)click:(id)sender {
    
//    [self alertViewController];
    
    [self askUserAskQuestion];
}


- (void)alertViewController{
    
    /*uialertViewcontrolller*/
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"多多是疯狗吗" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消按钮");
    }];
    UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
        //
        //        UITextField *textField = alertView.textFields.firstObject;
        //        NSLog(@"%@",textField.text);
        NSLog(@"确定");
    }];
    
    //    [alertView addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    //         textField.placeholder = @"登录";
    //    }];
    [alertView addAction:cancelAction];
    [alertView addAction:submitAction];
    
    /*ipad 需要配置location*/
    UIPopoverPresentationController *popover = alertView.popoverPresentationController;
    if (popover){
        popover.sourceView = self.button;
        popover.sourceRect = self.button.bounds;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    
    [self presentViewController:alertView animated:YES completion:nil];
    
}

/**
 *  @author sand, 16-09-07
 *
 *  @brief alert 块的方法
 */
- (void)askUserAskQuestion{
    
    
    UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"温馨提示"
                                                     message:@"多多是乖乖狗"
                                                    delegate:self
                                           cancelButtonTitle:@"取消"
                                           otherButtonTitles:@"确定", nil];
    void (^block)(NSInteger) = ^(NSInteger buttonIndex){
        if (buttonIndex == 0) {
            NSLog(@"取消");
        }else{
            NSLog(@"确定");
        }
    };
    
    objc_setAssociatedObject(alerView,
                             SDMyAlertViewKey,
                             block,
                             OBJC_ASSOCIATION_COPY);
    [alerView show];
    
}

#pragma mark -- alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    void (^block)(NSInteger) = objc_getAssociatedObject(alertView, SDMyAlertViewKey);
    block(buttonIndex);
}
@end
