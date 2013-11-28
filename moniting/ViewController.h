//
//  ViewController.h
//  moniting
//
//  Created by xcstream on 11/28/13.
//  Copyright (c) 2013 xcstream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *btcprice;
@property (weak, nonatomic) IBOutlet UILabel *ltcprice;
@property (weak, nonatomic) IBOutlet UIButton *updatenow;
- (IBAction)nowupdate:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *la;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sect;
@property (weak, nonatomic) IBOutlet UISwitch *sw;

@end
