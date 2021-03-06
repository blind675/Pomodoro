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
#import "StatisticsModel.h"

@interface MainViewController (){
    unsigned short countDownValue;
    NSTimer *generalTimer;
    BOOL zoomAnimationDone;
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
    
    zoomAnimationDone = NO;
    
    // just like pressing the stop button
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopButtonPressed:)
                                                 name:kResetTimersDuration
                                               object:nil];
    
    // app entered background
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(saveTheTimerState)
                                                 name:kApplicationEnteredBackgroundKey
                                               object:nil];
    
    // app started background
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resetApplicationState:)
                                                 name:kApplicationStartedKey
                                               object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!zoomAnimationDone) {
        
        zoomAnimationDone = YES;
        
        [self.view layoutIfNeeded];
        
        UIImageView *auxView = [[UIImageView alloc] initWithFrame:self.backgroundImage.frame];
        auxView.image = [UIImage imageNamed:@"splashImageSet"];
        
        self.backgroundImage.hidden = YES;
        [self.view insertSubview:auxView aboveSubview:self.backgroundImage];
        
        [UIView animateWithDuration:1 animations:^{
            
            auxView.frame = CGRectMake(- self.backgroundImage.frame.size.width , - self.backgroundImage.frame.size.height ,self.backgroundImage.frame.size.width * 3, self.backgroundImage.frame.size.height *3 );
            
        } completion:^(BOOL finished){
            
            self.backgroundImage.hidden = NO;
            [auxView removeFromSuperview];
            
        }];
    }
    
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

- (void)timerTicked {
    
    if (countDownValue == 0) {
        countDownValue = [[TimerManager sharedInstance] moveToTheNextIntervalType];
        [self updateStatusLabel];
    }
    
    countDownValue--;
    self.timeLabel.text = [TimerModel stringTimeFormatForValue:countDownValue];
}

- (void)dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)saveTheTimerState {
    
    NSLog(@" SAVE STATE ");
    
    NSLog(@"  - seconds left until next state change:%hu",countDownValue);
    NSLog(@"  - current date:%@", [NSDate date]);
    NSLog(@"  - current state:%u",[TimerModel currentTimerState]);
    NSLog(@"  - curent interval type:%u",[TimerModel currentTimingIntervalType]);
    
    // save the timer internal state
    [[NSUserDefaults standardUserDefaults] setInteger:[TimerModel currentTimerState] forKey:kTimerStateAtBackgroundEntryKey];
    [[NSUserDefaults standardUserDefaults] setInteger:[TimerModel currentTimingIntervalType] forKey:kTimerIntervalTypeAtBackgroundEntryKey];
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:kLastTimeAppEnteredBackgroundTimestampKey];
    // save time left
    [[NSUserDefaults standardUserDefaults] setInteger:countDownValue forKey:kTimeLeftUntilNextStateKey];
    
    //stop the timer
    [generalTimer invalidate];
    generalTimer = nil;
}

- (void)resetApplicationState:(NSNotification*)notification {
    
    NSLog(@"Restart Application State");
    
    // check if all the pomodoro are done and if yes deactivate all buttons
    unsigned short maxPomodori = abs((kWarningHours * 60 * 60) / [TimerModel workingTime] + [TimerModel shortPauseTime]);
    
    if ([StatisticsModel todaysPomodoro] >= maxPomodori) {
        self.startButton.enabled = NO;
        self.stopButton.enabled = NO;
        self.pauseButton.enabled = NO;
    } if ([TimerModel currentTimerState] == TimerStart ) {
        
        // check the state of the player and if running update the state.
        NSDictionary* userInfo = notification.userInfo;
        NSNumber* timeLeft = (NSNumber*)userInfo[@"timeLeft"];
        NSLog (@"Successfully received test notification! %i", timeLeft.unsignedShortValue);
        
        [[TimerManager sharedInstance] pauseTimerAtValue:timeLeft.unsignedShortValue];
        
        countDownValue = [[TimerManager sharedInstance] startTimer];
        
        [self takeCareOfTheUI];
        
        // create a general timer that trigers once every second
        generalTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTicked) userInfo:nil repeats:YES];
    }
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
