//
//  ZHJDigitTextField.m
//  ZHJBankNumberTextFiled
//
//  Created by Sword on 12/10/15.
//  Copyright © 2015 Sword. All rights reserved.
//

#import "ZHJNumberView.h"
#import "ZHJNumberField.h"

@interface ZHJNumberView()<UITextFieldDelegate, ZHJNumberFieldDelegate>

@property (nonatomic, strong) NSMutableArray *textFileds;
@property (nonatomic, strong) NSMutableArray *visibleTextFileds;

@end

@implementation ZHJNumberView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config {
    _textFileds = [[NSMutableArray alloc] init];
    _visibleTextFileds = [[NSMutableArray alloc] init];
    self.layer.masksToBounds = TRUE;
    self.layer.cornerRadius = 4;
    self.layer.borderColor = [UIColor greenColor].CGColor;
    self.layer.borderWidth = 0.5;
    [self registerObservers];
}

- (void)setLength:(NSInteger)length {
    _length = length;
    [self layoutvisibleTextFileds];
}

- (ZHJNumberField *)anyTextField {
    ZHJNumberField *numerFiled = nil;
    if ([_textFileds count]) {
        numerFiled = [_textFileds firstObject];
        [_textFileds removeObject:numerFiled];
    }
    return numerFiled;
}

- (void)recyleNumberFields {
    for (ZHJNumberField *textField in _visibleTextFileds) {
        if (![_textFileds containsObject:textField]) {
            textField.delegate = nil;
            textField.numberDelegate = nil;
            [_textFileds addObject:textField];
        }
    }
    [_visibleTextFileds removeAllObjects];
}

- (void)layoutvisibleTextFileds {
    [self recyleNumberFields];
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat marginX = 0;
    CGFloat gridWidth = (width - 2 * marginX) / _length;
    CGFloat gridHeight = height;
    CGFloat x = marginX;
    NSString *key;
    CGRect frame;
    for (NSInteger i = 0; i < _length; i++) {
        key = [NSString stringWithFormat:@"_keyfile%d", i];
        ZHJNumberField *numberField = [self anyTextField];
        if (!numberField) {
            numberField = [[ZHJNumberField alloc] initWithFrame:frame];
        }
        numberField.delegate = self;
        numberField.numberDelegate = self;
        numberField.tag = i;
        frame = CGRectMake(x, 0, gridWidth, gridHeight);
        numberField.frame = frame;
        [_visibleTextFileds addObject:numberField];
        [self addSubview:numberField];
        
        UIView *verticalLineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(numberField.frame), 0, 0.5, CGRectGetHeight(numberField.frame))];
        verticalLineView.backgroundColor = [UIColor colorWithCGColor:self.layer.borderColor];
        [self addSubview:verticalLineView];
        
        x += gridWidth;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [textField.text length] + [string length] <= 1;
}

- (void)registerObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (BOOL)containsTextFiled:(UITextField *)textField {
    if (textField) {
        BOOL contains = FALSE;
        for (UITextField *numberTextField in _visibleTextFileds) {
            if (numberTextField == textField) {
                contains = TRUE;
                break;
            }
        }
        return contains;
    }
    else {
        return FALSE;
    }
}

#pragma mark - notifications
- (void)textFiledTextDidChange:(NSNotification *)notification {
    if ([notification.object isKindOfClass:[UITextField class]]) {
        UITextField *textField = notification.object;
        /*
         *由于UITextField的UITextFieldTextDidChangeNotification是全局通知
         *需要判断是否是自身的UITextField发出的
         */
        if ([self containsTextFiled:textField]) {
            if ([textField.text length]) {
                if (textField.tag + 1 < [_visibleTextFileds count]) {
                    UITextField *nextTextField = _visibleTextFileds[textField.tag + 1];
                    NSInteger length = [nextTextField.text length];
                    if (length <= 0) {
                        [nextTextField becomeFirstResponder];
                    }
                }
            }
        }
    }
}

#pragma mark - ZHJNumberFieldDelegate
- (void)zhjNumberFieldDidBackspace:(ZHJNumberField *)numberField {
    if (numberField.tag - 1 >= 0) {
        ZHJNumberField *preTextField = _visibleTextFileds[numberField.tag - 1];
        [preTextField becomeFirstResponder];
    }
    
}
@end
