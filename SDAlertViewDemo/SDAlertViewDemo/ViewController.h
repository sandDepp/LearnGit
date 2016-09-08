//
//  ViewController.h
//  Test
//
//  Created by 沙莎 on 16/9/5.
//  Copyright © 2016年 沙莎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *button;
- (IBAction)click:(id)sender;

@end

