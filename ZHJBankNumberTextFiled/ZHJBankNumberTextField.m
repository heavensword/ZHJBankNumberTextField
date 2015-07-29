//
//  ZHJBankNumberTextField.m
//  ZHJBankNumberTextFiled
//
//  Created by Sword on 7/29/15.
//  Copyright (c) 2015 Sword. All rights reserved.
//

#import "ZHJBankNumberTextField.h"

const NSInteger zhj_banknumber_max_length = 23;

@implementation ZHJBankNumberTextField

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initlization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initlization];
    }
    return self;
}

- (void)initlization {
    self.keyboardType = UIKeyboardTypeDecimalPad;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textValueDidChange)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textValueDidChange];
}

- (void)textValueDidChange {
    NSString *text = [self text];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    if (newString.length >= zhj_banknumber_max_length) {
        newString = [newString substringWithRange:NSMakeRange(0, zhj_banknumber_max_length)];
    }
    [super setText:newString];
}

- (NSString *)text {
    NSString *text = [super text];
    return [text stringByReplacingOccurrencesOfString:@" " withString:@""];
}
@end
