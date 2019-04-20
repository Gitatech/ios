//
//  ViewController.m
//  RSSchool_T4
//
//  Created by Admin on 20.04.2019.
//  Copyright © 2019 iOSLab. All rights reserved.
//

// ​UIKeyboardType = Phone
//1. Код страны не входит в длину номера телефона
//2. Максимальная длина номера телефона 12 знаков (без форматирования)
//При вводе номера телефона автоматически подставляется “+” перед первым символом если пользователь сам не ввел “+” при наборе номера телефона.
//Если код страны определился то в левой части UITextField должен отобразится флаг страны.

//используем frame/bounds для работы с размерами элементов

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property(weak, nonatomic) UITextField *phoneNumberTextField;
@property(weak, nonatomic) UIImageView *flagImage;

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
    //    NSString *flagName = [[NSString new] autorelease];
    NSMutableString *prefix = [[NSMutableString new] autorelease];
    if (phoneNumber.length >= 3) {
        prefix = [NSMutableString stringWithFormat:@"%@", [phoneNumber substringWithRange:NSMakeRange(0, 3)]];
    }
//    NSLog(@"prefix -> %@", prefix);
    
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
-(void)textFieldDidChange:(UITextField *)textField {
    if ([self.phoneNumberTextField.text hasPrefix:@"+"]) {
        NSString *workNumber = [[NSString new] autorelease];
        workNumber = [self.phoneNumberTextField.text substringFromIndex:1];
        if (workNumber.length < 4) {
            [self defineCountryCode:workNumber];
        }
    } else {
        if (self.phoneNumberTextField.text.length < 4) {
            [self defineCountryCode:self.phoneNumberTextField.text];
        }
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.phoneNumberTextField) {
        NSCharacterSet *charSet = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *specialSet = [NSCharacterSet characterSetWithCharactersInString:@"+"]; // the set for special symbols used in phonenumber like "+"
        
        if (textField.text.length < 16) {
            if ([string rangeOfCharacterFromSet:charSet.invertedSet].location != NSNotFound &&
                [string rangeOfCharacterFromSet:specialSet].location) {
                // TODO: плюс можно только на 1е место
                NSLog(@"wrong symbols");
                return NO;
            }
            return YES;
        } else {
            NSLog(@"limit!");
            return NO;
        }
    }
    return YES;
}

- (void)dealloc
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self
                      name:UITextFieldTextDidChangeNotification
                    object:self.phoneNumberTextField];
    [self phoneNumberTextField];
    [self flagImage];
    [super dealloc];
}

@end
