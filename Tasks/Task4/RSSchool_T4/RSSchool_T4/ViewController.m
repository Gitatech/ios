//
//  ViewController.m
//  RSSchool_T4
//
//  Created by Admin on 20.04.2019.
//  Copyright © 2019 iOSLab. All rights reserved.
//

//1. Код страны не входит в длину номера телефона
//2. Максимальная длина номера телефона 12 знаков (без форматирования)
//используем frame/bounds для работы с размерами элементов

// ​UIKeyboardType = Phone +
//При вводе номера телефона автоматически подставляется “+” перед первым символом если пользователь сам не ввел “+” при наборе номера телефона. +
//Если код страны определился то в левой части UITextField должен отобразится флаг страны. +
// 8 - (xx) xxx-xxx
// 9 - (xx) xxx-xx-xx
//10 - (xxx) xxx xx xx

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property(weak, nonatomic) UITextField *phoneNumberTextField;
@property(weak, nonatomic) UIImageView *flagImage;
@property(copy, nonatomic) NSString *numberFormat;
@property(readwrite, nonatomic) NSInteger numberLength;
// @"long" for 10 character number, @"short" for 8/9 character
// this is some key, cause I didn't imagine how to use Enum in Objective-C yet
//-(instancetype)initWithCountry:(NSString *)formatType numberLength:(NSInteger)lenght;

@end

@implementation ViewController

//-(instancetype)initWithCountry:(NSString *)formatType numberLength:(NSInteger)length {
//    self = [super init];
//    if (self) {
//        _numberFormat = formatType;
//        _numberLength = length;
//    }
//    return self;
//}

//-(void)setCountrySettings:(NSString *)formatType with:(NSInteger)length {
//    if (_numberFormat != formatType) {
//        [_numberFormat release];
//        _numberFormat = [formatType copy];
//    }
//    _numberLength = length;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setCountrySettings:@(0) imageName:@""]; // set default settings
}

-(void)setCountrySettings:(NSNumber *)formatType imageName:(NSString *)name {
    if ([name.lowercaseString isEqualToString:@""]) {
        self.flagImage.image = nil;
    } else {
        self.flagImage.image = [UIImage imageNamed:name];
    }
    
    switch ([formatType intValue]) {
        case 1:
            NSLog(@"ru/kz");
            self.numberLength = 11;
            self.numberFormat = @"ru/kz";
            break;
        case 2:
            NSLog(@"md/am");
            self.numberLength = 11;
            self.numberFormat = @"md/am";
            break;
        default:
            NSLog(@"euro / default");
            self.numberLength = 12;
            break;
    }
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
}

#pragma mark - define the code of the country and setup country flag
-(void)defineCountryCode:(NSString *)phoneNumber {
    NSString *decimalNumber = [self getDecimalStringFromPhoneNumber:phoneNumber];
    NSString *prefix = [NSString stringWithFormat:@"%@", decimalNumber];
    
    if (decimalNumber.length >= 3) {
        prefix = [NSMutableString stringWithFormat:@"%@", [decimalNumber substringWithRange:NSMakeRange(0, 3)]];
        //        prefix = [[phoneNumber substringWithRange:NSMakeRange(0, 3)] mutableCopy];
    }
    
    switch ([prefix intValue]) {
        case 998:
            [self setCountrySettings:@(3) imageName:@"flag_UZ"];
//            self.flagImage.image = [UIImage imageNamed:@"flag_UZ"];
            break;
        case 996:
            [self setCountrySettings:@(3) imageName:@"flag_KG"];
//            self.flagImage.image = [UIImage imageNamed:@"flag_KG"];
            break;
        case 994:
//            self.flagImage.image = [UIImage imageNamed:@"flag_AZ"];
            [self setCountrySettings:@(3) imageName:@"flag_AZ"];
            break;
        case 993:
//            self.flagImage.image = [UIImage imageNamed:@"flag_TM"];
            [self setCountrySettings:@(3) imageName:@"flag_TM"];
            break;
        case 992:
//            self.flagImage.image = [UIImage imageNamed:@"flag_TJ"];
            [self setCountrySettings:@(3) imageName:@"flag_TJ"];
            break;
        case 380:
//            self.flagImage.image = [UIImage imageNamed:@"flag_UA"];
            [self setCountrySettings:@(3) imageName:@"flag_UA"];
            break;
        case 375:
//            self.flagImage.image = [UIImage imageNamed:@"flag_BY"];
            [self setCountrySettings:@(3) imageName:@"flag_BY"];
            break;
        case 374:
            [self setCountrySettings:@(2) imageName:@"flag_AM"];
//            self.flagImage.image = [UIImage imageNamed:@"flag_AM"];
            break;
        case 373:
//            self.flagImage.image = [UIImage imageNamed:@"flag_MD"];
            [self setCountrySettings:@(2) imageName:@"flag_MD"];
            break;
        default:
            if (decimalNumber.length >= 2) {
                prefix = [NSMutableString stringWithFormat:@"%@", [decimalNumber substringWithRange:NSMakeRange(0, 2)]];
            }
            switch ([prefix intValue]) {
                case 77:
                    [self setCountrySettings:@(1) imageName:@"flag_KZ"];
//                    self.flagImage.image = [UIImage imageNamed:@"flag_KZ"];
                    break;
                default:
                    if (decimalNumber.length >= 1) {
                        prefix = [NSMutableString stringWithFormat:@"%@", [decimalNumber substringWithRange:NSMakeRange(0, 1)]];
                    }
                    switch ([prefix intValue]) {
                        case 7:
                            [self setCountrySettings:@(1) imageName:@"flag_RU"];
//                            self.flagImage.image = [UIImage imageNamed:@"flag_RU"];
                            break;
                        default:
//                            self.flagImage.image = nil;
                            [self setCountrySettings:@(0) imageName:@""];
                            break;
                    }
                    break;
            }
            break;
    }
}

#pragma mark - manage UItextFiled behavior
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
        NSLog(@"event log -> %s", "textFieldShouldReturn");
        return YES;
    }
    return NO;
}

// hide keyboard and return value on touching outside
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch.phase == UITouchPhaseBegan) {
        if ([self.phoneNumberTextField isFirstResponder]) {
            NSLog(@"event log -> %s", "touchesBegan");
            [self.phoneNumberTextField resignFirstResponder];
        }
        [self.view endEditing:YES];
    }
}

-(void)textFieldDidChange:(UITextField *)textField {
    if ([self.phoneNumberTextField.text hasPrefix:@"+"]) {
        NSString *workNumber = [[NSString new] autorelease];
        workNumber = [self.phoneNumberTextField.text substringFromIndex:1];
        [self defineCountryCode:workNumber];
    } else {
        [self defineCountryCode:self.phoneNumberTextField.text];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // string - The replacement string for the specified range.
    // During typing, this parameter normally contains only the single new character that was typed, but it may contain more characters if the user is pasting text.
    // When the user deletes one or more characters, the replacement string is empty.
    if (textField == self.phoneNumberTextField) {
        NSCharacterSet *charSet = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *specialSet = [NSCharacterSet characterSetWithCharactersInString:@"+"]; // the set for special symbols used in phonenumber like "+", "(", ")"
        
        // add "+" into the first position of the text field if user ignore it
        if (range.location == 0 && ![string hasPrefix:@"+"]) {
            textField.text = [NSString stringWithFormat:@"+"];
        }
        
        // manage user's input data
        NSInteger countryLimit = self.numberLength;
        NSString *decimalNumber = [self getDecimalStringFromPhoneNumber:textField.text];
        if (decimalNumber.length < (int)countryLimit) {
            if (strcmp([string cStringUsingEncoding:NSUTF8StringEncoding], "\b") == -8) {
                // determine that the delete button was pressed
                NSLog(@"backspace pressed");
                return YES;
            }
            
            if ([string rangeOfCharacterFromSet:charSet.invertedSet].location != NSNotFound &&
                [string rangeOfCharacterFromSet:specialSet].location) {
                NSLog(@"wrong symbols");
                return NO;
            } else
                // check - if user will try to enter "+" in the middle of a phone number - block this
                // TODO: - permit to use delete button
                if ([string rangeOfCharacterFromSet:charSet.invertedSet].location != NSNotFound && range.location != 0) {
                    NSLog(@"No symbols, only decimal");
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
    //    NSString *decimalNumber = [NSString stringWithFormat:@"%@", @"+375(29)-870-72-34"];
    NSString *decimalNumber = [NSString stringWithFormat:@"%@", input];
    decimalNumber = [decimalNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    decimalNumber = [decimalNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    decimalNumber = [decimalNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    decimalNumber = [decimalNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    decimalNumber = [decimalNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"decimalNumber -> %@", decimalNumber);
    return decimalNumber;
}

- (void)dealloc
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self
                      name:UITextFieldTextDidChangeNotification
                    object:self.phoneNumberTextField];
    [self phoneNumberTextField];
    [self flagImage];
    [self numberFormat];
    [self numberLength];
    [super dealloc];
}

@end
