#import "TinyURL.h"

@implementation TinyURL



- (NSURL *)encode:(NSURL *)originalURL;{
    NSString *simbols = @"abcdefghijklmnopqrstuwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomStr =[NSMutableString stringWithCapacity:5];
    for (int i=0; i<5;i++){
        [randomStr appendFormat:@"%C" ,[simbols characterAtIndex: arc4random_uniform([simbols length])]];
    }
    NSLog(@"%@", randomStr);
    [_urls setObject:originalURL forKey:(@"%@", randomStr)];
    NSURL *shortUrl = [NSURL URLWithString:(@"t.url//%@" , randomStr)];
    NSLog(@"%@", shortUrl);
    return shortUrl;
    }

- (NSURL *)decode:(NSURL *)shortenedURL;{
    NSString *hostName = (@"t.url/");
    NSString *param = [shortenedURL.absoluteString stringByReplacingOccurrencesOfString:hostName withString:@""];
    NSLog(@"%@", param);
    NSURL *originalUrl = [_urls objectForKey:param];
    NSLog(@"%@", originalUrl);
    return originalUrl;
}
@end
