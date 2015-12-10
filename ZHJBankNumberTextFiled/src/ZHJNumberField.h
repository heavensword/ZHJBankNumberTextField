//
//  ZHJNumberField.h
//  ZHJBankNumberTextFiled
//
//  Created by Sword on 12/10/15.
//  Copyright © 2015 Sword. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZHJNumberFieldDelegate;

@interface ZHJNumberField : UITextField

@property (nonatomic, assign) id <ZHJNumberFieldDelegate> numberDelegate;

@end

@protocol ZHJNumberFieldDelegate <NSObject>
@required
- (void)zhjNumberFieldDidBackspace:(ZHJNumberField *)numberField;

@end