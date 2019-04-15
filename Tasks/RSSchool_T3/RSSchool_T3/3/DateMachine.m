#import "DateMachine.h"

@implementation DateMachine


- (void)viewDidLoad {
  [super viewDidLoad];
  // have fun
 
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 300, 20)];
    dateLabel.tag = 1;
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    [dateLabel setText:(@"%@", [dateFormatter stringFromDate:currentDate])];
    [self.view addSubview:dateLabel];
    
    UITextField *startDate =[[UITextField alloc] initWithFrame:CGRectMake(5, 300, 130, 20)];
    UITextField *step =[[UITextField alloc] initWithFrame:CGRectMake(143, 300, 130, 20)];
    UITextField *dateUnit =[[UITextField alloc] initWithFrame:CGRectMake(280, 300, 130, 20)];
    startDate.placeholder=@"Start date";
    startDate.layer.borderColor =[UIColor blackColor].CGColor;
    startDate.layer.borderWidth = 1.f;
    startDate.tag = 2;
    [startDate addTarget:self action:@selector(checkStartDateValue:) forControlEvents:UIControlEventEditingChanged];
    step.layer.borderColor =[UIColor blackColor].CGColor;
    step.placeholder=@"Step";
    step.layer.borderWidth = 1.f;
    step.tag = 3;
    [step addTarget:self action:@selector(checkStepValue:) forControlEvents:UIControlEventEditingChanged];
    dateUnit.layer.borderColor =[UIColor blackColor].CGColor;
    dateUnit.placeholder=@"Date unit";
    dateUnit.layer.borderWidth = 1.f;
    dateUnit.tag = 4;
    [dateUnit addTarget:self action:@selector(checkDateUnitValue:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:startDate];
    [self.view addSubview:step];
    [self.view addSubview:dateUnit];
    
    UIButton *addButton =[[UIButton alloc] initWithFrame:CGRectMake(50, 400, 100, 20)];
    UIButton *subButton =[[UIButton alloc] initWithFrame:CGRectMake(200, 400, 100, 20)];
    addButton.accessibilityValue = @"Add";
    subButton.accessibilityValue = @"Sub";
    [addButton setTitle:@"Add" forState:UIControlStateNormal];
    [subButton setTitle:@"Sub" forState:UIControlStateNormal];
    addButton.layer.backgroundColor = [UIColor grayColor].CGColor;
    subButton.layer.backgroundColor = [UIColor grayColor].CGColor;
    [addButton addTarget:self action:@selector(addOrSubButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [subButton addTarget:self action:@selector(addOrSubButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    [self.view addSubview:subButton];
}

- (void) addOrSubButtonClick:(UIButton*) button {
    
    int n = 0;
    
    if ([button.accessibilityValue isEqualToString:@"Add"]){
        n = 1;
    }
    else{
        n = -1;
    }
    
    UILabel *dateLabel = [self.view viewWithTag:1];
    UITextField *dateUnit = [self.view viewWithTag:4];
    UITextField *step = [self.view viewWithTag:3];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSDate *startDate = [dateFormatter dateFromString:(@"%@", dateLabel.text)];
    if ([dateUnit.text isEqualToString:@"year"]){
        NSDateComponents *yearComponent = [[NSDateComponents alloc] init];
        yearComponent.year = [step.text integerValue]*n;
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:yearComponent toDate:startDate options:0];
        [dateLabel setText:(@"%@", [dateFormatter stringFromDate:nextDate])];        
    }
    if ([dateUnit.text isEqualToString:@"month"]){
        NSDateComponents *monthComponent = [[NSDateComponents alloc] init];
        monthComponent.month = [step.text integerValue]*n;
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:monthComponent toDate:startDate options:0];
        [dateLabel setText:(@"%@", [dateFormatter stringFromDate:nextDate])];
    }
    if ([dateUnit.text isEqualToString:@"week"]){
        NSDateComponents *weekComponent = [[NSDateComponents alloc] init];
        weekComponent.day = [step.text integerValue]*7*n;
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:weekComponent toDate:startDate options:0];
        [dateLabel setText:(@"%@", [dateFormatter stringFromDate:nextDate])];
    }
    if ([dateUnit.text isEqualToString:@"day"]){
        NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
        dayComponent.day = [step.text integerValue]*n;
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:startDate options:0];
        [dateLabel setText:(@"%@", [dateFormatter stringFromDate:nextDate])];
    }
    if ([dateUnit.text isEqualToString:@"hour"]){
        NSDateComponents *hourComponent = [[NSDateComponents alloc] init];
        hourComponent.hour = [step.text integerValue]*n;
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:hourComponent toDate:startDate options:0];
        [dateLabel setText:(@"%@", [dateFormatter stringFromDate:nextDate])];
    }
    if ([dateUnit.text isEqualToString:@"minute"]){
        NSDateComponents *minuteComponent = [[NSDateComponents alloc] init];
        minuteComponent.minute = [step.text integerValue]*n;
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:minuteComponent toDate:startDate options:0];
        [dateLabel setText:(@"%@", [dateFormatter stringFromDate:nextDate])];
    }
}

- (void) checkStartDateValue:(UITextField *)textField{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSDate *startDate = [dateFormatter dateFromString:(@"%@", textField.text)];
    if (startDate!=0){
        UILabel *label = [self.view viewWithTag:1];
        [label setText:(@"%@", [dateFormatter stringFromDate:startDate])];
    }
}

- (void) checkStepValue:(UITextField *)textField{
    NSCharacterSet *numberCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSString *stepStr = textField.text;
    if (stepStr.length>0){
        for (int i=0; i<stepStr.length; i++){
            unichar c = [stepStr characterAtIndex:i];
            if (![numberCharSet characterIsMember:c]) {
                stepStr = [stepStr substringToIndex:i];
                textField.text = stepStr;
            }
        }
    }
}

-(void)checkDateUnitValue:(UITextField *)textField{
    NSString *text = textField.text;
    NSArray *dictionary = @[@"year", @"month", @"week", @"day", @"hour", @"minute"];
    if (![self allowedWords:dictionary :text]){
        textField.text = @"";
    }
}

-(BOOL)allowedWords: (NSArray *) dictionary: (NSString *) text {
    
    for (NSString *word in dictionary){
        if (word.length >= text.length) {
            if ([text isEqualToString:[word substringToIndex:(text.length)]]){
                return YES;
            }
        }
    }
    return NO;
}


@end
