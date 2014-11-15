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

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [TimerModel setCurrentTimerState:TimerStop];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startButtonPressed:(id)sender {
    [[TimerManager sharedManager]startTimer];
    
    self.startButton.userInteractionEnabled = NO;
    self.stopButton.userInteractionEnabled = YES;
    self.pauseButton.userInteractionEnabled = YES;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    
    self.startButton.alpha = 0.3;
    self.stopButton.alpha = 1;
    self.pauseButton.alpha = 1;
    
    [UIView commitAnimations];
}

- (IBAction)stopButtonPressed:(id)sender {
    [[TimerManager sharedManager]stopTimer];
    
    self.startButton.userInteractionEnabled = YES;
    self.stopButton.userInteractionEnabled = NO;
    self.pauseButton.userInteractionEnabled = NO;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    
    self.startButton.alpha = 1;
    self.stopButton.alpha = 0.3;
    self.pauseButton.alpha = 0.3;
    
    [UIView commitAnimations];
}

- (IBAction)pauseButtonPressed:(id)sender {
    [[TimerManager sharedManager]pauseTimer];
    
    self.startButton.userInteractionEnabled = YES;
    self.stopButton.userInteractionEnabled = YES;
    self.pauseButton.userInteractionEnabled = NO;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    
    self.startButton.alpha = 1;
    self.stopButton.alpha = 1;
    self.pauseButton.alpha = 0.3;
    
    [UIView commitAnimations];
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
