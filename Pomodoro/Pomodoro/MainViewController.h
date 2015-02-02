//
//  MainViewController.h
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSideImageConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSideImageConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightSideImageCostraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSideImageConstraint;

@end