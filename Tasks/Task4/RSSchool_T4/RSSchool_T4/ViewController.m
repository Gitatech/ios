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

-(void)setupView {
    self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.38 blue:0.54 alpha:1.0];
    NSLog(@"ViewController was setuped");
    [self setupTextFieldAppearance];
}

-(void)setupTextFieldAppearance {
    CGRect textFieldSize = CGRectMake(20, 40, self.view.frame.size.width - 40, 60);
    self.phoneNumberTextField = [[[UITextField alloc] initWithFrame:textFieldSize]autorelease];
    self.phoneNumberTextField.font = [UIFont boldSystemFontOfSize:15];
    self.phoneNumberTextField.textColor = UIColor.blackColor;
    self.phoneNumberTextField.placeholder = @"Enter the phone number";
    self.phoneNumberTextField.backgroundColor = UIColor.lightGrayColor;
    self.phoneNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    self.phoneNumberTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.phoneNumberTextField.keyboardType = UIKeyboardTypePhonePad;
    self.phoneNumberTextField.returnKeyType = UIReturnKeyDone;
    self.phoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneNumberTextField.delegate = self;
    self.phoneNumberTextField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:self.phoneNumberTextField];

    UIView *imageContainer = [[UIView alloc] initWithFrame:CGRectMake(self.phoneNumberTextField.frame.origin.x,
                                                                      self.phoneNumberTextField.frame.origin.y,
                                                                      self.phoneNumberTextField.frame.size.width/4,
                                                                      self.phoneNumberTextField.frame.size.height - 10)];
    self.flagImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0,
                                                                   imageContainer.frame.size.height,
                                                                   imageContainer.frame.size.height)];
//    self.flagImage.image = [UIImage imageNamed:@""];
    self.flagImage.contentMode = UIViewContentModeScaleToFill;
    [imageContainer addSubview:self.flagImage];
    self.phoneNumberTextField.leftView = imageContainer;
}

- (void)dealloc
{
    [super dealloc];
}

@end
