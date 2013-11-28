//
//  ViewController.m
//  moniting
//
//  Created by xcstream on 11/28/13.
//  Copyright (c) 2013 xcstream. All rights reserved.
//
#import "ViewController.h"
@interface ViewController ()
@end

@implementation ViewController{
    NSDate *date1,*date2;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage* img=[UIImage imageNamed:@"jkl"] ;
    [self.updatenow setBackgroundImage:img forState:UIControlStateNormal];
	date1 = [NSDate dateWithTimeIntervalSinceNow:0];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(update)  userInfo:nil repeats:YES];
    [self update];

    // Do any additional setup after loading the view, typically from a nib.
}

-(void)update {
    
    if (!self.sw.on) {
        return;
        
        
        
    }
    int secs[] = {5,10,30,60,180};
    int index = self.sect.selectedSegmentIndex;
    int currentsec = secs[index];
    
    
    date2 = [NSDate dateWithTimeIntervalSinceNow:0];
    
    int interval =  [date2 timeIntervalSinceDate:date1];
    
    if (interval<currentsec) {
        return;
    }
    
    
    [self.updatenow setTitle:@"updating..." forState:UIControlStateNormal];
    dispatch_async(dispatch_queue_create("a", DISPATCH_QUEUE_PRIORITY_DEFAULT),^{
    NSURL *urlbtc = [NSURL URLWithString:@"https://www.okcoin.com/api/ticker.do" ];
    NSURL *urlltc = [NSURL URLWithString:@"https://www.okcoin.com/api/ticker.do?symbol=ltc_cny"];
    NSError *err1 = nil;
    NSError *err2 = nil;
    NSData *btcdata = [NSData dataWithContentsOfURL:urlbtc options:NSDataReadingUncached error:&err1];
    NSData *ltcdata = [NSData dataWithContentsOfURL:urlltc options:NSDataReadingUncached error:&err2];
    dispatch_async(dispatch_get_main_queue()
                       , ^{
                           if (err1 == nil) {
                               NSError* error = nil;
                               NSDictionary *json = [NSJSONSerialization JSONObjectWithData:btcdata options:kNilOptions error:&error];
                               if (error == nil) {
                                   self.btcprice.text = json[@"ticker"][@"buy"];
                               }
                           }

                           if (err2 ==nil) {
                               NSError* error;
                               NSDictionary *json = [NSJSONSerialization JSONObjectWithData:ltcdata options:kNilOptions error:&error];
                               if (error == nil) {
                                   self.ltcprice.text = json[@"ticker"][@"buy"];
                               }
                           }
                           
                           
                           [self.updatenow setTitle:@"update now" forState:UIControlStateNormal];
                           
                           NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                           [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                           NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
                           self.la.text =  currentDateStr;

                       });
    });
    
    date1 = [NSDate dateWithTimeIntervalSinceNow:0];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nowupdate:(id)sender {
    [self update];
}
@end
