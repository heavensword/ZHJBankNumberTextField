//
//  ZHJNumberField.m
//  ZHJBankNumberTextFiled
//
//  Created by Sword on 12/10/15.
//  Copyright © 2015 Sword. All rights reserved.
//

#import "ZHJNumberField.h"

@implementation ZHJNumberField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.keyboardType = UIKeyboardTypeNumberPad;
        self.borderStyle = UITextBorderStyleNone;
        self.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)deleteBackward {
    BOOL shouldDimiss = TRUE;//(!self.text || [self.text length] <= 0);
    [super deleteBackward];
    if (shouldDimiss) {
        if (_numberDelegate && [_numberDelegate respondsToSelector:@selector(zhjNumberFieldDidBackspace:)]) {
            [_numberDelegate zhjNumberFieldDidBackspace:self];
        }
    }
}

@end
