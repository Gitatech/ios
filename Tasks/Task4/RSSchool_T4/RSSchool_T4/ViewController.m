//
//  ViewController.m
//  RSSchool_T4
//
//  Created by Admin on 20.04.2019.
//  Copyright © 2019 iOSLab. All rights reserved.
//

// 8 - (xx) xxx-xxx
// 9 - (xx) xxx-xx-xx
//10 - (xxx) xxx xx xx

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property(weak, nonatomic) UITextField *phoneNumberTextField;
@property(weak, nonatomic) UIImageView *flagImage;
@property(weak, nonatomic) CALayer *bottomLine;
@property(copy, nonatomic) NSString *numberFormat;
@property(readwrite, nonatomic) NSInteger numberLength;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
    // set default settings
    [self setCountrySettings:@(0) imageName:@""];
}

#pragma mark - setup UI
-(void)setupView {
    self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.38 blue:0.54 alpha:0.9];
    [self setupTextFieldAppearance];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChange:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.phoneNumberTextField];
}

-(void)setupTextFieldAppearance {
    CGRect textFieldSize = CGRectMake(20, 40, self.view.frame.size.width - 40, 60);
    self.phoneNumberTextField = [[[UITextField alloc] initWithFrame:textFieldSize] autorelease];
    self.phoneNumberTextField.font = [UIFont boldSystemFontOfSize:20];
    self.phoneNumberTextField.textColor = UIColor.blackColor;
    self.phoneNumberTextField.placeholder = @"Enter the phone number";
    self.phoneNumberTextField.backgroundColor = UIColor.whiteColor;
    self.phoneNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    self.phoneNumberTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.phoneNumberTextField.keyboardType = UIKeyboardTypePhonePad;
    self.phoneNumberTextField.returnKeyType = UIReturnKeyDone;
    self.phoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneNumberTextField.delegate = self;
    self.phoneNumberTextField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:self.phoneNumberTextField];
    
    UIView *imageContainer = [[[UIView alloc] initWithFrame:CGRectMake(self.phoneNumberTextField.frame.origin.x,
                                                                       self.phoneNumberTextField.frame.origin.y,
                                                                       self.phoneNumberTextField.frame.size.width/4,
                                                                       self.phoneNumberTextField.frame.size.height - 10)] autorelease];
    self.flagImage = [[[UIImageView alloc] initWithFrame:CGRectMake(5, 0,
                                                                    imageContainer.frame.size.height,
                                                                    imageContainer.frame.size.height)] autorelease];
    self.flagImage.contentMode = UIViewContentModeScaleToFill;
    [imageContainer addSubview:self.flagImage];
    self.phoneNumberTextField.leftView = imageContainer;
    [self drawTheLine];
}

-(void)drawTheLine {
    self.bottomLine  = [CALayer layer];
    self.bottomLine.borderWidth = 1.f;
    self.bottomLine.borderColor = UIColor.blackColor.CGColor;
    self.bottomLine.frame = CGRectMake(self.phoneNumberTextField.bounds.origin.x + self.phoneNumberTextField.frame.size.width/4,
                                  self.phoneNumberTextField.bounds.origin.y + self.phoneNumberTextField.frame.size.height/4*3,
                                  self.phoneNumberTextField.frame.size.width/4*3-30,
                                  1.f);
    [self.phoneNumberTextField.layer addSublayer:self.bottomLine];
    [self.bottomLine setHidden:YES];
}

#pragma mark - define the code of the country and setup country flag
-(void)defineCountryCode:(NSString *)phoneNumber {
    NSString *decimalNumber = [self getDecimalStringFromPhoneNumber:phoneNumber];
    NSString *prefix = [NSString stringWithFormat:@"%@", decimalNumber];
    
    if (decimalNumber.length >= 3) {
        prefix = [decimalNumber substringWithRange:NSMakeRange(0, 3)];
    }
    
    switch ([prefix intValue]) {
        case 998:
            [self setCountrySettings:@(3) imageName:@"flag_UZ"];
            break;
        case 996:
            [self setCountrySettings:@(3) imageName:@"flag_KG"];
            break;
        case 994:
            [self setCountrySettings:@(3) imageName:@"flag_AZ"];
            break;
        case 993:
            [self setCountrySettings:@(3) imageName:@"flag_TM"];
            break;
        case 992:
            [self setCountrySettings:@(3) imageName:@"flag_TJ"];
            break;
        case 380:
            [self setCountrySettings:@(3) imageName:@"flag_UA"];
            break;
        case 375:
            [self setCountrySettings:@(3) imageName:@"flag_BY"];
            break;
        case 374:
            [self setCountrySettings:@(2) imageName:@"flag_AM"];
            break;
        case 373:
            [self setCountrySettings:@(2) imageName:@"flag_MD"];
            break;
        default:
            if (decimalNumber.length >= 2) {
                prefix = [decimalNumber substringWithRange:NSMakeRange(0, 2)];
            }
            switch ([prefix intValue]) {
                case 77:
                    [self setCountrySettings:@(1) imageName:@"flag_KZ"];
                    break;
                default:
                    if (decimalNumber.length >= 1) {
                        prefix = [decimalNumber substringWithRange:NSMakeRange(0, 1)];
                    }
                    switch ([prefix intValue]) {
                        case 7:
                            [self setCountrySettings:@(1) imageName:@"flag_RU"];
                            break;
                        default:
                            [self setCountrySettings:@(0) imageName:@""];
                            break;
                    }
                    break;
            }
            break;
    }
}

#pragma mark - set country for correct formatting
-(void)setCountrySettings:(NSNumber *)formatType imageName:(NSString *)name {
    if ([name.lowercaseString isEqualToString:@""]) {
        self.flagImage.image = nil;
    } else {
        self.flagImage.image = [UIImage imageNamed:name];
    }
    
    switch ([formatType intValue]) {
        case 1:
            self.numberLength = 11;
            self.numberFormat = @"ru/kz";
            break;
        case 2:
            self.numberLength = 11;
            self.numberFormat = @"md/am";
            break;
        default:
            self.numberFormat = @"";
            self.numberLength = 12;
            break;
    }
}

#pragma mark - hide keyboard and return value on touching outside
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch.phase == UITouchPhaseBegan) {
        if ([self.phoneNumberTextField isFirstResponder]) {
            [self.phoneNumberTextField resignFirstResponder];
        }
        [self.view endEditing:YES];
    }
}

#pragma mark - manage UItextFiled behavior
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
}

-(void)textFieldDidChange:(UITextField *)textField {
    if ([self.phoneNumberTextField.text hasPrefix:@"+"]) {
        NSString *workNumber = [self.phoneNumberTextField.text substringFromIndex:1];
        [self defineCountryCode:workNumber];
    } else {
        [self defineCountryCode:self.phoneNumberTextField.text];
    }
    
    if (self.phoneNumberTextField.text.length > 0) {
        [self.bottomLine setHidden:NO];
    } else [self.bottomLine setHidden:YES];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.phoneNumberTextField) {
        NSCharacterSet *charSet = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *specialSet = [NSCharacterSet characterSetWithCharactersInString:@"+"]; // the set for special symbols used in phonenumber like "+"
        
        // add "+" into the first position of the text field if user ignore it
        if (range.location == 0 && ![string hasPrefix:@"+"]) {
            textField.text = @"+";
        }
        
        // manage user's input data
        NSInteger countryLimit = self.numberLength;
        NSString *decimalNumber = [self getDecimalStringFromPhoneNumber:textField.text];
        if (decimalNumber.length < (int)countryLimit) {
            if (strcmp([string cStringUsingEncoding:NSUTF8StringEncoding], "\b") == -8) {
                // determine that the delete button was pressed
                return YES;
            }
            
            if ([string rangeOfCharacterFromSet:charSet.invertedSet].location != NSNotFound && [string rangeOfCharacterFromSet:specialSet].location) {
                return NO;
            } else
                // check - if user will try to enter "+" in the middle of a phone number - block this
                if ([string rangeOfCharacterFromSet:charSet.invertedSet].location != NSNotFound && range.location != 0) {
                    return NO;
                }
            
            // add phone number formating - begin
            if ([self.numberFormat.lowercaseString isEqualToString:@"ru/kz"]) {
                // only ru/kz - +7 (123) 456 78 90
                NSMutableString *tempNumber = [NSMutableString stringWithFormat:@"+%@", decimalNumber];
                if (decimalNumber.length == 4) {
                    [tempNumber insertString:@" (" atIndex:2];
                    [tempNumber insertString:@") " atIndex:7];
                    textField.text = tempNumber;
                } else
                    if (decimalNumber.length == 8) {
                        [tempNumber insertString:@" (" atIndex:2];
                        [tempNumber insertString:@") " atIndex:7];
                        [tempNumber insertString:@" " atIndex:12];
                        textField.text = tempNumber;
                    } else
                        if (decimalNumber.length > 9) {
                            [tempNumber insertString:@" (" atIndex:2];
                            [tempNumber insertString:@") " atIndex:7];
                            [tempNumber insertString:@" " atIndex:12];
                            [tempNumber insertString:@" " atIndex:15];
                            textField.text = tempNumber;
                        }
            } else
                if ([self.numberFormat.lowercaseString isEqualToString:@"md/am"]) {
                    // only md/am +373 (98) 987-654
                    NSMutableString *tempNumber = [NSMutableString stringWithFormat:@"+%@", decimalNumber];
                    if (decimalNumber.length == 5) {
                        [tempNumber insertString:@" (" atIndex:4];
                        [tempNumber insertString:@") " atIndex:8];
                        textField.text = tempNumber;
                    } else
                        if (decimalNumber.length > 8) {
                            [tempNumber insertString:@" (" atIndex:4];
                            [tempNumber insertString:@") " atIndex:8];
                            [tempNumber insertString:@"-" atIndex:13];
                            textField.text = tempNumber;
                        }
                } else {
                    // only euro - +375 (29) 870-72-34
                    NSMutableString *tempNumber = [NSMutableString stringWithFormat:@"+%@", decimalNumber];
                    if (decimalNumber.length == 5) {
                        [tempNumber insertString:@" (" atIndex:4];
                        [tempNumber insertString:@") " atIndex:8];
                        textField.text = tempNumber;
                    } else
                        if (decimalNumber.length == 8) {
                            [tempNumber insertString:@" (" atIndex:4];
                            [tempNumber insertString:@") " atIndex:8];
                            [tempNumber insertString:@"-" atIndex:13];
                            textField.text = tempNumber;
                        } else
                            if (decimalNumber.length > 10) {
                                [tempNumber insertString:@" (" atIndex:4];
                                [tempNumber insertString:@") " atIndex:8];
                                [tempNumber insertString:@"-" atIndex:13];
                                [tempNumber insertString:@"-" atIndex:16];
                                textField.text = tempNumber;
                            }
                }
            // add phone number formating - end
            return YES;
        } else {
            if (strcmp([string cStringUsingEncoding:NSUTF8StringEncoding], "\b") == -8) {
                // determine that the delete button was pressed
                return YES;
            }
            NSLog(@"Limit! This number already containts %lu digits!", (unsigned long)decimalNumber.length);
            return NO;
        }
    }
    return YES;
}

-(NSString *)getDecimalStringFromPhoneNumber:(NSString *)input {
    NSString *decimalNumber = [NSString stringWithFormat:@"%@", input];
    decimalNumber = [decimalNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    decimalNumber = [decimalNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    decimalNumber = [decimalNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    decimalNumber = [decimalNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    decimalNumber = [decimalNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    return decimalNumber;
}

- (void)dealloc
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self
                      name:UITextFieldTextDidChangeNotification
                    object:self.phoneNumberTextField];
    [_numberFormat release];
    [super dealloc];
}

@end
