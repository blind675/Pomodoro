//
//  RightViewController.m
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "RightViewController.h"
#import "TimerModel.h"
#import "Constants.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    
    NSLog(@"Loaded   - Right View Controller");
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.workingTimeLabel.text = [TimerModel stringTimeFormatForValue:[TimerModel workingTime]];
    self.workingTimeSlider.value = (float)[TimerModel workingTime];
    
    self.shortPauseTimeLabel.text = [TimerModel stringTimeFormatForValue:[TimerModel shortPauseTime]];
    self.shortTimerSlider.value = (float)[TimerModel shortPauseTime];
    
    self.longPauseTimeLabel.text = [TimerModel stringTimeFormatForValue:[TimerModel longPauseTime]];
    self.longTimerSlider.value = (float)[TimerModel longPauseTime];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self updateAllLabels];
}

-(void)updateAllLabels{
    
    self.workingTimeLabel.text = [TimerModel stringTimeFormatForValue:[TimerModel workingTime]];
    self.workingTimeSlider.value = (float)[TimerModel workingTime];
    
    self.shortPauseTimeLabel.text = [TimerModel stringTimeFormatForValue:[TimerModel shortPauseTime]];
    self.shortTimerSlider.value = (float)[TimerModel shortPauseTime];
    
    self.longPauseTimeLabel.text = [TimerModel stringTimeFormatForValue:[TimerModel longPauseTime]];
    self.longTimerSlider.value = (float)[TimerModel longPauseTime];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)workingTimeValueChanged:(id)sender {
    self.workingTimeLabel.text = [TimerModel stringTimeFormatForValue: (unsigned short)[((UISlider *)sender) value]];
}
- (IBAction)workingValueEnded:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:(unsigned short)[((UISlider *)sender) value] forKey:kWorkingTimeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // if it's in the working time cicle
    if ([TimerModel currentTimingIntervalType] == WorkingTime) {
        // reset timer
        [[NSNotificationCenter defaultCenter] postNotificationName:kResetTimersDuration object:self];
    }
}

- (IBAction)shortPauseChanged:(id)sender {
    self.shortPauseTimeLabel.text = [TimerModel stringTimeFormatForValue: (unsigned short)[((UISlider *)sender) value]];
    
}
- (IBAction)shortPauseEnded:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:(unsigned short)[((UISlider *)sender) value] forKey:kShortPauseTimeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // if it's in the short pause cicle
    if ([TimerModel currentTimingIntervalType] == ShortPause) {
        // reset timer
        [[NSNotificationCenter defaultCenter] postNotificationName:kResetTimersDuration object:self];
    }
}

- (IBAction)longPauseSlider:(id)sender {
    self.longPauseTimeLabel.text = [TimerModel stringTimeFormatForValue: (unsigned short)[((UISlider *)sender) value]];
}
- (IBAction)longPauseEnded:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:(unsigned short)[((UISlider *)sender) value] forKey:kLongPauseTimeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // if it's in the long pause cicle
    if ([TimerModel currentTimingIntervalType] == LongPause) {
        // reset timer
        [[NSNotificationCenter defaultCenter] postNotificationName:kResetTimersDuration object:self];
    }
}


- (IBAction)resetButtonPressed:(id)sender {
    // 1500 = 25 min
    //  300 =  5 min
    //  900 = 15 min
    
    [[NSUserDefaults standardUserDefaults] setInteger:(unsigned short)1500 forKey:kWorkingTimeKey];
    [[NSUserDefaults standardUserDefaults] setInteger:(unsigned short)300 forKey:kShortPauseTimeKey];
    [[NSUserDefaults standardUserDefaults] setInteger:(unsigned short)900 forKey:kLongPauseTimeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self updateAllLabels];
    
    // reset timer
    [[NSNotificationCenter defaultCenter] postNotificationName:kResetTimersDuration object:self];
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
