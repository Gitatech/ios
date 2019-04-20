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
@property(copy, nonatomic) NSString *numberFormat; // @"long" for 10 character number, @"short" for 8/9 character
// this is some key, cause I didn't imagine how to use Enum in Objective-C

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
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
    self.phoneNumberTextField.font = [UIFont boldSystemFontOfSize:21];
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
    NSMutableString *prefix = [[NSMutableString new] autorelease];
    if (phoneNumber.length >= 3) {
        prefix = [NSMutableString stringWithFormat:@"%@", [phoneNumber substringWithRange:NSMakeRange(0, 3)]];
//        prefix = [[phoneNumber substringWithRange:NSMakeRange(0, 3)] mutableCopy];
    }
    
    switch ([prefix intValue]) {
        case 998:
            self.flagImage.image = [UIImage imageNamed:@"flag_UZ"];
            break;
        case 996:
            self.flagImage.image = [UIImage imageNamed:@"flag_KG"];
            break;
        case 994:
            self.flagImage.image = [UIImage imageNamed:@"flag_AZ"];
            break;
        case 993:
            self.flagImage.image = [UIImage imageNamed:@"flag_TM"];
            break;
        case 992:
            self.flagImage.image = [UIImage imageNamed:@"flag_TJ"];
            break;
        case 380:
            self.flagImage.image = [UIImage imageNamed:@"flag_UA"];
            break;
        case 375:
            self.flagImage.image = [UIImage imageNamed:@"flag_BY"];
            break;
        case 374:
            self.flagImage.image = [UIImage imageNamed:@"flag_AM"];
            break;
        case 373:
            self.flagImage.image = [UIImage imageNamed:@"flag_MD"];
            break;
        default:
            if (phoneNumber.length >= 2) {
                prefix = [NSMutableString stringWithFormat:@"%@", [phoneNumber substringWithRange:NSMakeRange(0, 2)]];
            }
            switch ([prefix intValue]) {
                case 77:
                    self.flagImage.image = [UIImage imageNamed:@"flag_KZ"];
                    break;
                default:
                    if (phoneNumber.length >= 1) {
                        prefix = [NSMutableString stringWithFormat:@"%@", [phoneNumber substringWithRange:NSMakeRange(0, 1)]];
                    }
                    switch ([prefix intValue]) {
                        case 7:
                            self.flagImage.image = [UIImage imageNamed:@"flag_RU"];
                            break;
                        default:
                            self.flagImage.image = nil;
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

//-(void)textFieldDidEndEditing:(UITextField *)textField {
//    if ([textField isFirstResponder]) {
//        [textField resignFirstResponder];
//         NSLog(@"event log -> %s", "textFieldDidEndEditing");
//    }
//}

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
        // TODO: нужно считать количество цифр без символов, пробелов и скобок - должно быть 375298707234 <= 12 всегда +
        // 1. отсекаем лишнее содержание +
        // 2. считаем количество цифр и проверяем условие +
        NSString *clearNumber = [self getDecimalStringFromPhoneNumber:textField.text];
        if (clearNumber.length < 12) {
            if ([string rangeOfCharacterFromSet:charSet.invertedSet].location != NSNotFound &&
                [string rangeOfCharacterFromSet:specialSet].location) {
                NSLog(@"wrong symbols");
                return NO;
            } else
                // check - if user will try to enter "+" in the middle of a phone number - block this
                if ([string rangeOfCharacterFromSet:charSet.invertedSet].location != NSNotFound && range.location != 0) {
                    NSLog(@"No symbols, only decimal");
                    return NO;
                }
            
            // add phone number formating - begin
            // TODO: - добавляем скобки
            // 1. remove country code and get number lenght
            // 2. choose the option: 10, 9, 8
            // 3. add "(", ")", " ", "-" on correct positions according to the mask
            // +X (XXX) - only this part
            // russian - +7 (123) 456 78 90
            NSMutableString *formattedNumber = [[clearNumber mutableCopy] autorelease];
            [formattedNumber insertString:@" (" atIndex:1]; // вставляем на позицию 1
            [formattedNumber appendString:@") "]; // добавляем к строке в конце
            NSLog(@"formatted number: %@", formattedNumber);
            textField.text = formattedNumber;
            
            // add phone number formating - end
            return YES;
        } else {
            NSLog(@"limit!");
            return NO;
        }
    }
    return YES;
}


// TODO: - works incorrect!!!
-(NSString *)getDecimalStringFromPhoneNumber:(NSString *)input {
    NSCharacterSet *set = [NSCharacterSet decimalDigitCharacterSet];
    NSString *string = [NSString stringWithFormat:@"%@", [input stringByTrimmingCharactersInSet:set.invertedSet]];
    NSLog(@"str -> %@", string);
    return string;
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
    [super dealloc];
}

@end
