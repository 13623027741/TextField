//
//  ViewController.m
//  TextField
//
//  Created by Mac on 2017/11/8.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "KDTextField.h"

@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    KDTextField *textField = [[KDTextField alloc] initWithFrame:CGRectMake(40, 200, [UIScreen mainScreen].bounds.size.width - 80, 40)];
    textField.placeholder = @"用户名";
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    [self.view addSubview:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
