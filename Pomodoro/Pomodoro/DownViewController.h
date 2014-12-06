//
//  DownViewController.h
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface DownViewController : BaseViewController

@property (assign, nonatomic) NSInteger indexNumber;
@property (weak, nonatomic) IBOutlet UILabel *shortInfoLabel;

@end
