#import "DateMachine.h"

@interface DateMachine ()

@end

@implementation DateMachine
static NSString *message = @"Loading...";

- (void)viewDidLoad {
  [super viewDidLoad];
    [self generateUIView];
}

-(void)generateUIView {
    // generate UILabel
    CGRect labelRect = CGRectMake(20, 40, 300, 50);
    UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
    [label setCenter:CGPointMake(self.view.center.x, 150)];
    label.textColor = UIColor.blackColor;
    label.backgroundColor = UIColor.redColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Arial" size:30];
    label.numberOfLines = 0;
    [label setText:message];
    label.lineBreakMode = NSLineBreakByWordWrapping;
//    [label sizeToFit];
    [self.view addSubview:label];
    [label release];
    
    // generate TextFields
    CGRect textFieldRect1 = CGRectMake(20, 100, 300, 50);
    UITextField *textField1 = [[UITextField alloc] initWithFrame:textFieldRect1];
    textField1.borderStyle = UITextBorderStyleRoundedRect;
    textField1.font =[UIFont fontWithName:@"Arial" size:20];
    [textField1 setText:message];
    [textField1 setPlaceholder:@"Enter the text"];
    [textField1 setCenter:CGPointMake(self.view.center.x, 210)];
    textField1.autocorrectionType = UITextAutocorrectionTypeNo;
    textField1.keyboardType = UIKeyboardTypeDefault;
    textField1.keyboardAppearance = UIKeyboardAppearanceDefault;
    textField1.backgroundColor = UIColor.orangeColor;
//    textField1.delegate = self;
    [self.view addSubview:textField1];
    [textField1 release];
    
    CGRect textFieldRect2 = CGRectMake(20, 100, 300, 50);
    UITextField *textField2 = [[UITextField alloc] initWithFrame:textFieldRect2];
    textField2.borderStyle = UITextBorderStyleRoundedRect;
    textField2.font =[UIFont fontWithName:@"Arial" size:20];
    [textField2 setText:message];
    [textField2 setPlaceholder:@"Enter the text"];
    [textField2 setCenter:CGPointMake(self.view.center.x, 270)];
    textField2.autocorrectionType = UITextAutocorrectionTypeNo;
    textField2.keyboardType = UIKeyboardTypeDefault;
    textField2.keyboardAppearance = UIKeyboardAppearanceDefault;
    textField2.backgroundColor = UIColor.greenColor;
//    textField2.delegate = self;
    [self.view addSubview:textField2];
    [textField2 release];
    
    CGRect textFieldRect3 = CGRectMake(20, 100, 300, 50);
    UITextField *textField3 = [[UITextField alloc] initWithFrame:textFieldRect3];
    textField3.borderStyle = UITextBorderStyleRoundedRect;
    textField3.font =[UIFont fontWithName:@"Arial" size:20];
    [textField3 setText:message];
    [textField3 setPlaceholder:@"Enter the text"];
    [textField3 setCenter:CGPointMake(self.view.center.x, 330)];
    textField3.autocorrectionType = UITextAutocorrectionTypeNo;
    textField3.keyboardType = UIKeyboardTypeDefault;
    textField3.keyboardAppearance = UIKeyboardAppearanceDefault;
    textField3.backgroundColor = UIColor.greenColor;
    //    textField3.delegate = self;
    [self.view addSubview:textField3];
    [textField3 release];
    
    // set padding for UITextField from the left side
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textField1.leftView = paddingView1;
    textField1.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textField2.leftView = paddingView2;
    textField2.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    textField3.leftView = paddingView3;
    textField3.leftViewMode = UITextFieldViewModeAlways;
    
    // generate UIButtons
    CGRect buttonRect1 = CGRectMake(20, 100, 300, 50);
    UIButton *button1 = [[UIButton alloc] initWithFrame:buttonRect1];
    [button1 setCenter:CGPointMake(self.view.center.x, 390)];
    [button1 setTitle:@"Button1" forState:UIControlStateNormal];
    button1.backgroundColor = UIColor.blueColor;
    // TODO: add events on button press
    [self.view addSubview:button1];
    [button1 release];
    
    CGRect buttonRect2 = CGRectMake(20, 100, 300, 50);
    UIButton *button2 = [[UIButton alloc] initWithFrame:buttonRect2];
    [button2 setCenter:CGPointMake(self.view.center.x, 450)];
    [button2 setTitle:@"Button2" forState:UIControlStateNormal];
    button2.backgroundColor = UIColor.blueColor;
    // TODO: add events on button press
    [self.view addSubview:button2];
    [button2 release];
}

@end
