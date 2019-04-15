#import "DateMachine.h"

@interface DateMachine () <UIScrollViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) UITextField *textField1;
@property (nonatomic, weak) UITextField *textField2;
@property (nonatomic, weak) UITextField *textField3;
@property (nonatomic, weak) UIButton *addButton;
@property (nonatomic, weak) UIButton *subButton;
@property (nonatomic,weak) UIColor *customBlue;
@property (nonatomic,weak) UIColor *customOrange;

@end

@implementation DateMachine
double const itemHeight = 50.0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setColors];
    [self generateUIView];
}

#pragma mark - UIView generation
-(void)generateUIView {
    self.view.backgroundColor = self.customBlue;
    // UILabel
    [self generateUILabel];
    // TextFields
    [self generateUITextFields];
    // generate UIButtons
    [self generateUIButtons];
}

#pragma mark - set basic colors for UIView
-(void)setColors {
    self.customBlue = [UIColor colorWithRed:0.0 green:0.38 blue:0.54 alpha:1.0];
    self.customOrange = [UIColor colorWithRed:0.93 green:0.41 blue:0.03 alpha:1.0];
}

#pragma mark - UILabel generation
-(void)generateUILabel{
    CGRect labelRect = CGRectMake(0, 0, 0, 0);
    self.dateLabel = [[[UILabel alloc] initWithFrame:labelRect] autorelease];
    self.dateLabel.textColor = UIColor.whiteColor;
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    self.dateLabel.font = [UIFont fontWithName:@"Arial" size:40];
    self.dateLabel.numberOfLines = 0;
    [self.dateLabel setText:[self getCurrentDate]];
    self.dateLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:self.dateLabel];
    
    // manage autolayout constraints for UILabel
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.dateLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:150.0].active = YES;
    [self.dateLabel.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:10.0].active = YES;
    [self.dateLabel.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-10.0].active = YES;
}

#pragma mark - UITextFields generation
-(void)generateUITextFields {
    // 1st UITextField
    self.textField1 = [[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
    self.textField1.borderStyle = UITextBorderStyleRoundedRect;
    self.textField1.font =[UIFont fontWithName:@"Arial" size:20];
    [self.textField1 setPlaceholder:@"Start date"];
    self.textField1.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField1.keyboardType = UIKeyboardTypeDefault;
    self.textField1.keyboardAppearance = UIKeyboardAppearanceDefault;
    self.textField1.backgroundColor = UIColor.whiteColor;
    self.textField1.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField1.alpha = 0.9f;
    self.textField1.delegate = self;
    [self.view addSubview:self.textField1];
    
    // manage autolayout constraints for UITextField1
    self.textField1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.textField1.topAnchor constraintEqualToAnchor:self.dateLabel.bottomAnchor constant:40.0].active = YES;
    [self.textField1.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20.0].active = YES;
    [self.textField1.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20.0].active = YES;
    [self.textField1.heightAnchor constraintEqualToConstant:itemHeight].active = YES;
    
    // 2nd UITExtField
    self.textField2 = [[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
    self.textField2.borderStyle = UITextBorderStyleRoundedRect;
    self.textField2.font =[UIFont fontWithName:@"Arial" size:20];
    [self.textField2 setPlaceholder:@"Step"];
    self.textField2.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField2.keyboardType = UIKeyboardTypeNumberPad;
    self.textField2.keyboardAppearance = UIKeyboardAppearanceDefault;
    self.textField2.backgroundColor = UIColor.whiteColor;
    self.textField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField2.alpha = 0.9f;
    self.textField2.delegate = self;
    [self.view addSubview:self.textField2];
    
    // manage autolayout constraints for UITextField2
    self.textField2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.textField2.topAnchor constraintEqualToAnchor:self.textField1.bottomAnchor constant:20.0].active = YES;
    [self.textField2.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20.0].active = YES;
    [self.textField2.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20.0].active = YES;
    [self.textField2.heightAnchor constraintEqualToConstant:itemHeight].active = YES;
    
    // 3rd UITExtField
    self.textField3 = [[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
    self.textField3.borderStyle = UITextBorderStyleRoundedRect;
    self.textField3.font =[UIFont fontWithName:@"Arial" size:20];
    [self.textField3 setPlaceholder:@"Date unit"];
    self.textField3.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField3.keyboardType = UIKeyboardTypeDefault;
    self.textField3.keyboardAppearance = UIKeyboardAppearanceDefault;
    self.textField3.backgroundColor = UIColor.whiteColor;
    self.textField3.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField3.alpha = 0.9f;
    self.textField3.delegate = self;
    [self.view addSubview:self.textField3];
    
    // manage autolayout constraints for UITextField2
    self.textField3.translatesAutoresizingMaskIntoConstraints = NO;
    [self.textField3.topAnchor constraintEqualToAnchor:self.textField2.bottomAnchor constant:20.0].active = YES;
    [self.textField3.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20.0].active = YES;
    [self.textField3.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20.0].active = YES;
    [self.textField3.heightAnchor constraintEqualToConstant:itemHeight].active = YES;
    
    // set padding for all UITextFields
    [self setPadding];
}

#pragma mark - set padding for UITextFields
-(void)setPadding {
    // set padding for UITextField from the left side
    UIView *paddingView1 = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)] autorelease];
    self.textField1.leftView = paddingView1;
    self.textField1.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)] autorelease];
    self.textField2.leftView = paddingView2;
    self.textField2.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView3 = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)] autorelease];
    self.textField3.leftView = paddingView3;
    self.textField3.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark - UIButtons generation
-(void)generateUIButtons{
    // 1st UIButton
    self.addButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
    [self.addButton setTitle:@"Add" forState:UIControlStateNormal];
    self.addButton.backgroundColor = self.customOrange;
    self.dateLabel.font = [UIFont fontWithName:@"Arial" size:25];
    [self.addButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addButton];
    
    // manage autolayout constraints for UIButton1
    self.addButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.addButton.topAnchor constraintEqualToAnchor:self.textField3.bottomAnchor constant:30.0].active = YES;
    [self.addButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20.0].active = YES;
    [self.addButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20.0].active = YES;
    [self.addButton.heightAnchor constraintEqualToConstant:itemHeight].active = YES;
    
    // 2nd UIButton
    self.subButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
    [self.subButton setTitle:@"Sub" forState:UIControlStateNormal];
    self.subButton.backgroundColor = self.customOrange;
    self.dateLabel.font = [UIFont fontWithName:@"Arial" size:25];
    [self.subButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.subButton];
    
    // add tags
    self.addButton.tag = 111;
    self.subButton.tag = 222;
    
    // manage autolayout constraints for UIButton2
    self.subButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.subButton.topAnchor constraintEqualToAnchor:self.addButton.bottomAnchor constant:20.0].active = YES;
    [self.subButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20.0].active = YES;
    [self.subButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20.0].active = YES;
    [self.subButton.heightAnchor constraintEqualToConstant:itemHeight].active = YES;
}

#pragma mark - get current Time and return it in NSString format
-(NSString *)getCurrentDate {
    NSDate *currentDate = [[[NSDate alloc] initWithTimeIntervalSinceNow:0] autorelease];
    NSDateFormatter *dateFormatter = [[NSDateFormatter new] autorelease];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    return [dateFormatter stringFromDate:currentDate];
}

#pragma mark - Button click selectors
-(void)buttonClick:(id)sender {
    NSArray *dates = @[@"year", @"month", @"week", @"day", @"hour", @"minute"];
    if (![dates containsObject: self.textField3.text.lowercaseString]) {
        self.dateLabel.text = @"Invalid value";
        self.textField2.text = @"";
        self.textField3.text = @"";
    }
    
    // for operations of addition and subtraction of the dates we could use NSCalendar components
    NSInteger stepValue = [self.textField2.text integerValue];
    switch (((UIButton *)sender).tag){
        case 111:
            NSLog(@"addButton");
            break;
        case 222:
            NSLog(@"subButton");
            stepValue = (-1)*stepValue;
            break;
        default:
            break;
    }
    NSLog(@"%li", (long)stepValue);
    
    NSCalendarUnit unit;
    int item = (int)[dates indexOfObject:self.textField3.text.lowercaseString];
    switch (item) {
        case 0:
            // year
            unit = NSCalendarUnitYear;
            break;
        case 1:
            // month
            unit = NSCalendarUnitMonth;
            break;
        case 2: {
            // week
            unit = NSCalendarUnitWeekOfYear;
            break;
        }
        case 3:
            // day
            unit = NSCalendarUnitDay;
            break;
        case 4:
            // hour
            unit = NSCalendarUnitHour;
            break;
        case 5:
            // minute
            unit = NSCalendarUnitMinute;
            break;
        default:
            return;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter new] autorelease];
    dateFormatter.dateFormat = @"dd/MM/yyyy HH:mm";
    
    NSCalendar *grgCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [dateFormatter dateFromString: self.dateLabel.text.lowercaseString];
    NSDate *setupDate = [grgCalendar dateByAddingUnit:unit value:(int)stepValue toDate:currentDate options: 0];
    self.dateLabel.text = [dateFormatter stringFromDate: setupDate];
    NSLog(@"Button  was clicked");
}

#pragma mark - UITextField methods
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.textField1) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter new] autorelease];
        dateFormatter.dateFormat = @"dd/MM/yyyy HH:mm";
        NSString *inputDate = [textField.text stringByReplacingCharactersInRange:range withString:string];
        // if we could get real date from input string - we'll show it
        if ([dateFormatter dateFromString: inputDate]) {
            self.dateLabel.text = inputDate;
        }
        return YES;
    }
    
    if (textField == self.textField2) {
        NSCharacterSet *charSet = [NSCharacterSet decimalDigitCharacterSet];
        if ([string rangeOfCharacterFromSet: charSet.invertedSet].location != NSNotFound) {
            return NO;
        }
        return YES;
    }
    
    if (textField == self.textField3) {
        NSCharacterSet *charSet = [NSCharacterSet letterCharacterSet];
        if ([string rangeOfCharacterFromSet: charSet.invertedSet].location != NSNotFound) {
            return NO;
        }
        return YES;
    }
    return YES;
}

- (void)dealloc
{
    [super dealloc];
}

@end
