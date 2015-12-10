//
//  ViewController.m
//  ZHJBankNumberTextFiled
//
//  Created by Sword on 7/29/15.
//  Copyright (c) 2015 Sword. All rights reserved.
//

#import "ViewController.h"
#import "ZHJBankNumberTextField.h"
#import "ZHJNumberView.h"

@interface ViewController ()<UITextFieldDelegate>
{
    ZHJBankNumberTextField *_bankTextField;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat x = (CGRectGetWidth(self.view.bounds) - 200) / 2;
    _bankTextField = [[ZHJBankNumberTextField alloc] initWithFrame:CGRectMake(x, 100, 200, 30)];
    _bankTextField.borderStyle = UITextBorderStyleRoundedRect;
    _bankTextField.font = [UIFont systemFontOfSize:14];
    _bankTextField.delegate = self;
    _bankTextField.textAlignment = NSTextAlignmentCenter;
    _bankTextField.text = @"65532738";
    [self.view addSubview:_bankTextField];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Console" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:0.8] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, 80, 40);
    button.center = CGPointMake(_bankTextField.center.x, _bankTextField.center.y + 80);
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(get) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    CGRect frame = CGRectMake(40, CGRectGetMaxY(button.frame) + 30, CGRectGetWidth(self.view.bounds) - 80, 35);
    ZHJNumberView *digitField = [[ZHJNumberView alloc] initWithFrame:frame];
    digitField.length = 8;
    [self.view addSubview:digitField];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)get {
    [_bankTextField resignFirstResponder];
    NSLog(@"text %@", _bankTextField.text);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return TRUE;
}
@end
