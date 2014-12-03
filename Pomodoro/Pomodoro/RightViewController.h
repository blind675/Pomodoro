//
//  RightViewController.h
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface RightViewController : BaseViewController

@property (assign, nonatomic) NSInteger indexNumber;
@property (weak, nonatomic) IBOutlet UILabel *workingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *shortPauseTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longPauseTimeLabel;

@end
