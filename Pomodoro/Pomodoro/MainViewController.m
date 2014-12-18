//
//  MainViewController.m
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "MainViewController.h"
#import "TimerModel.h"
#import "TimerManager.h"
#import "Constants.h"

@interface MainViewController (){
    unsigned short countDownValue;
    NSTimer *generalTimer;
}

@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation MainViewController

- (void)viewDidLoad {
    
    NSLog(@"Loaded   - Main View Controller");
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [TimerModel setCurrentTimerState:TimerStop];
    // reset the display
    self.timeLabel.text = [TimerModel stringTimeFormatForValue:[TimerModel workingTime]];
    
    NSLog(@"working time:%hd",[TimerModel workingTime]);
    NSLog(@"short time:%hd",[TimerModel shortPauseTime]);
    NSLog(@"long time:%hd",[TimerModel longPauseTime]);
    
    // just like pressing the stop button
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopButtonPressed:)
                                                 name:kResetTimersDuration
                                               object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startButtonPressed:(id)sender {
    countDownValue = [[TimerManager sharedInstance] startTimer];
    
    [self takeCareOfTheUI];
    
    // create a general timer that trigers once every second
    generalTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTicked) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:generalTimer forMode:NSDefaultRunLoopMode];
}

- (IBAction)stopButtonPressed:(id)sender {
    
    // clear the timer
    [generalTimer invalidate];
    generalTimer = nil;
    
    [[TimerManager sharedInstance] stopTimer];
    [self takeCareOfTheUI];
    
    // also reset the
}

- (IBAction)pauseButtonPressed:(id)sender {
    
    // clear the timer
    [generalTimer invalidate];
    generalTimer = nil;
    
    [[TimerManager sharedInstance] pauseTimerAtValue:countDownValue];
    [self takeCareOfTheUI];
}

#pragma mark - UI part

-(void)takeCareOfTheUI {
    
    switch ([TimerModel currentTimerState]) {
        case TimerStart:
            
            [self updateStatusLabel];
            
            self.startButton.userInteractionEnabled = NO;
            self.stopButton.userInteractionEnabled = YES;
            self.pauseButton.userInteractionEnabled = YES;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.2];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [UIView setAnimationDelegate:self];
            
            self.startButton.alpha = 0.3;
            self.stopButton.alpha = 1;
            self.pauseButton.alpha = 1;
            self.statusLabel.alpha = 1;
            
            [UIView commitAnimations];
            
            break;
        
        case TimerPause:
            
            self.startButton.userInteractionEnabled = YES;
            self.stopButton.userInteractionEnabled = YES;
            self.pauseButton.userInteractionEnabled = NO;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.2];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [UIView setAnimationDelegate:self];
            
            self.startButton.alpha = 1;
            self.stopButton.alpha = 1;
            self.pauseButton.alpha = 0.3;
            self.statusLabel.alpha = 0.6;
            
            [UIView commitAnimations];
            
            break;
        
        case TimerStop:
            
            self.startButton.userInteractionEnabled = YES;
            self.stopButton.userInteractionEnabled = NO;
            self.pauseButton.userInteractionEnabled = NO;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.2];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [UIView setAnimationDelegate:self];
            
            self.startButton.alpha = 1;
            self.stopButton.alpha = 0.3;
            self.pauseButton.alpha = 0.3;
            self.statusLabel.alpha = 0;
            
            [UIView commitAnimations];
            
            // reset the display
            self.timeLabel.text = [TimerModel stringTimeFormatForValue:[TimerModel workingTime]];
            
            break;
            
        default:
            break;
    }
}

-(void)updateStatusLabel {
    
    switch ([TimerModel currentTimingIntervalType]) {
        case WorkingTime:
            self.statusLabel.text = @"Working Time";
            break;
        case ShortPause:
            self.statusLabel.text = @"Short Break Time";
            break;
        case LongPause:
            self.statusLabel.text = @"Long Break Time";
            break;
        default:
            self.statusLabel.text = @"";
            break;
    }
}

#pragma mark - timer part

-(void)timerTicked {
    
    if (countDownValue == 0) {
        countDownValue = [[TimerManager sharedInstance] moveToTheNextIntervalType];
        [self updateStatusLabel];
    }
    
    countDownValue--;
    self.timeLabel.text = [TimerModel stringTimeFormatForValue:countDownValue];
}

- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
