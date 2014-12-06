//
//  RightViewController.h
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *workingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *shortPauseTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longPauseTimeLabel;

@property (weak, nonatomic) IBOutlet UISlider *workingTimeSlider;
@property (weak, nonatomic) IBOutlet UISlider *shortTimerSlider;
@property (weak, nonatomic) IBOutlet UISlider *longTimerSlider;

@end
