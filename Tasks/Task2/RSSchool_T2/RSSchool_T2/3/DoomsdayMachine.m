#import "DoomsdayMachine.h"

@implementation DoomsdayMachine

@synthesize days;

@synthesize hours;

@synthesize minutes;

@synthesize months;

@synthesize seconds;

@synthesize weeks;

@synthesize years;

- (id<AssimilationInfo>)assimilationInfoForCurrentDateString:(NSString *)dateString;{
    
    NSDateFormatter *dateFormatterString = [NSDateFormatter new];
    [dateFormatterString setDateFormat:@"yyyy:MM:dd@ss\\mm/HH"];
    
    NSDate *assimilationDate = [dateFormatterString dateFromString:@"2208:08:14@37\\13/03"];
    NSDate *currentDate = [dateFormatterString dateFromString:dateString];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *timeForAssimilation = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth| NSCalendarUnitWeekOfYear| NSCalendarUnitDay| NSCalendarUnitHour|NSCalendarUnitMinute| NSCalendarUnitSecond
                                                        fromDate:currentDate
                                                          toDate:assimilationDate
                                                         options:0];
    
    self->years = timeForAssimilation.year;
    self->months = timeForAssimilation.month;
    self->days = timeForAssimilation.day+timeForAssimilation.weekOfYear*7;
    self->hours = timeForAssimilation.hour;
    self->minutes = timeForAssimilation.minute;
    self->seconds = timeForAssimilation.second;
    
    return self;
}

- (NSString *)doomsdayString;{
    NSDateFormatter *dateFormatterString = [NSDateFormatter new];
    [dateFormatterString setDateFormat:@"yyyy:MM:dd@ss\\mm/HH"];
    
    NSDate *assimilationDate = [dateFormatterString dateFromString:@"2208:08:14@37\\13/03"];
    
    [dateFormatterString setDateFormat:@"EEEE, MMMM dd, yyyy"];
    NSString *humanDate = [dateFormatterString stringFromDate:assimilationDate];

    return humanDate;
}

@end
