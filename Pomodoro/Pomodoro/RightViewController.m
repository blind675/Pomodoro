//
//  RightViewController.m
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "RightViewController.h"
#import "TimerModel.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)workingTimeValueChanged:(id)sender { 
    self.workingTimeLabel.text = [TimerModel stringTimeFormatForValue: (unsigned short)[((UISlider *)sender) value]];
}

- (IBAction)shortPauseChanged:(id)sender {
    self.shortPauseTimeLabel.text = [TimerModel stringTimeFormatForValue: (unsigned short)[((UISlider *)sender) value]];
    
}

- (IBAction)longPauseSlider:(id)sender {
    self.longPauseTimeLabel.text = [TimerModel stringTimeFormatForValue: (unsigned short)[((UISlider *)sender) value]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
