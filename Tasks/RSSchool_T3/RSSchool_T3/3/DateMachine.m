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
    [startDate setText:@"Start date"];
    startDate.accessibilityValue=@"Start date";
    startDate.layer.borderColor =[UIColor blackColor].CGColor;
    startDate.layer.borderWidth = 1.f;
    startDate.tag = 2;
    [startDate addTarget:self action:@selector(checkStartDateValue) forControlEvents:UIControlEventEditingChanged];
    [startDate addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    step.layer.borderColor =[UIColor blackColor].CGColor;
    [step setText:@"Step"];
    step.accessibilityValue=@"Step";
    step.layer.borderWidth = 1.f;
    step.tag = 3;
    [step addTarget:self action:@selector(checkStepValue) forControlEvents:UIControlEventEditingChanged];
    [step addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    dateUnit.layer.borderColor =[UIColor blackColor].CGColor;
    [dateUnit setText:@"Date unit"];
    dateUnit.accessibilityValue=@"Date unit";
    dateUnit.layer.borderWidth = 1.f;
    dateUnit.tag = 4;
    [dateUnit addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self.view addSubview:startDate];
    [self.view addSubview:step];
    [self.view addSubview:dateUnit];
    
    UIButton *addButton =[[UIButton alloc] initWithFrame:CGRectMake(50, 400, 100, 20)];
    UIButton *subButton =[[UIButton alloc] initWithFrame:CGRectMake(200, 400, 100, 20)];
    [addButton setTitle:@"Add" forState:UIControlStateNormal];
    [subButton setTitle:@"Sub" forState:UIControlStateNormal];
    addButton.layer.backgroundColor = [UIColor grayColor].CGColor;
    subButton.layer.backgroundColor = [UIColor grayColor].CGColor;
    [addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [subButton addTarget:self action:@selector(subButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    [self.view addSubview:subButton];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.text = @"";
}

- (void) addButtonClick:(id)sender {
    UILabel *dateLabel = [self.view viewWithTag:1];
    UITextField *dateUnit = [self.view viewWithTag:4];
    UITextField *step = [self.view viewWithTag:3];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSDate *startDate = [dateFormatter dateFromString:(@"%@", dateLabel.text)];
    if ([dateUnit.text isEqualToString:@"year"]){
        NSDateComponents *yearComponent = [[NSDateComponents alloc] init];
        yearComponent.year = [step.text integerValue];
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:yearComponent toDate:startDate options:0];
        [dateLabel setText:(@"%@", [dateFormatter stringFromDate:nextDate])];        
    }
    if ([dateUnit.text isEqualToString:@"month"]){
        NSDateComponents *monthComponent = [[NSDateComponents alloc] init];
        monthComponent.month = [step.text integerValue];
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:monthComponent toDate:startDate options:0];
        [dateLabel setText:(@"%@", [dateFormatter stringFromDate:nextDate])];
    }
    if ([dateUnit.text isEqualToString:@"week"]){
        NSDateComponents *weekComponent = [[NSDateComponents alloc] init];
        weekComponent.day = [step.text integerValue]*7;
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:weekComponent toDate:startDate options:0];
        [dateLabel setText:(@"%@", [dateFormatter stringFromDate:nextDate])];
    }
    if ([dateUnit.text isEqualToString:@"day"]){
        NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
        dayComponent.day = [step.text integerValue];
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:startDate options:0];
        [dateLabel setText:(@"%@", [dateFormatter stringFromDate:nextDate])];
    }
    if ([dateUnit.text isEqualToString:@"hour"]){
        NSDateComponents *hourComponent = [[NSDateComponents alloc] init];
        hourComponent.hour = [step.text integerValue];
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:hourComponent toDate:startDate options:0];
        [dateLabel setText:(@"%@", [dateFormatter stringFromDate:nextDate])];
    }
    if ([dateUnit.text isEqualToString:@"minute"]){
        NSDateComponents *minuteComponent = [[NSDateComponents alloc] init];
        minuteComponent.minute = [step.text integerValue];
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:minuteComponent toDate:startDate options:0];
        [dateLabel setText:(@"%@", [dateFormatter stringFromDate:nextDate])];
    }
}

- (void) subButtonClick:(id)sender {
    UILabel *dateLabel = [self.view viewWithTag:1];
    UITextField *dateUnit = [self.view viewWithTag:4];
    UITextField *step = [self.view viewWithTag:3];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSDate *startDate = [dateFormatter dateFromString:(@"%@", dateLabel.text)];
    //year, month, week, day, hour, minute.
    if ([dateUnit.text isEqualToString:@"year"]){
        NSDateComponents *yearComponent = [[NSDateComponents alloc] init];
        yearComponent.year = -[step.text integerValue];
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:yearComponent toDate:startDate options:0];
        [dateLabel setText:(@"%@", [dateFormatter stringFromDate:nextDate])];
    }
    if ([dateUnit.text isEqualToString:@"month"]){
        NSDateComponents *monthComponent = [[NSDateComponents alloc] init];
        monthComponent.month = -[step.text integerValue];
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:monthComponent toDate:startDate options:0];
        [dateLabel setText:(@"%@", [dateFormatter stringFromDate:nextDate])];
    }
    if ([dateUnit.text isEqualToString:@"week"]){
        NSDateComponents *weekComponent = [[NSDateComponents alloc] init];
        weekComponent.day = -[step.text integerValue]*7;
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:weekComponent toDate:startDate options:0];
        [dateLabel setText:(@"%@", [dateFormatter stringFromDate:nextDate])];
    }
    if ([dateUnit.text isEqualToString:@"day"]){
        NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
        dayComponent.day = -[step.text integerValue];
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:startDate options:0];
        [dateLabel setText:(@"%@", [dateFormatter stringFromDate:nextDate])];
    }
    if ([dateUnit.text isEqualToString:@"hour"]){
        NSDateComponents *hourComponent = [[NSDateComponents alloc] init];
        hourComponent.hour = -[step.text integerValue];
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:hourComponent toDate:startDate options:0];
        [dateLabel setText:(@"%@", [dateFormatter stringFromDate:nextDate])];
    }
    if ([dateUnit.text isEqualToString:@"minute"]){
        NSDateComponents *minuteComponent = [[NSDateComponents alloc] init];
        minuteComponent.minute = -[step.text integerValue];
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *nextDate = [theCalendar dateByAddingComponents:minuteComponent toDate:startDate options:0];
        [dateLabel setText:(@"%@", [dateFormatter stringFromDate:nextDate])];
    }
}



- (void) checkStartDateValue{
    UITextField *startDateText = [self.view viewWithTag:2];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSDate *startDate = [dateFormatter dateFromString:(@"%@", startDateText.text)];
    if (startDate!=0){
        UILabel *label = [self.view viewWithTag:1];
        [label setText:(@"%@", [dateFormatter stringFromDate:startDate])];
    }
}

- (void) checkStepValue{
    UITextField *step = [self.view viewWithTag:3];
    NSCharacterSet *numberCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSString *stepStr = step.text;
    if (stepStr.length>0){
        unichar c = [stepStr characterAtIndex:(stepStr.length-1)];
        if (![numberCharSet characterIsMember:c]) {
            stepStr = [stepStr substringToIndex:(stepStr.length - 1)];
            step.text = stepStr;
        }
    }
}

@end
