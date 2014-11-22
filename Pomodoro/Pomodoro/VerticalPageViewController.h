//
//  VerticalPageViewController.h
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "HorizontalPageViewController.H"

@interface VerticalPageViewController : BaseViewController <UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageController;
@property (assign, nonatomic) NSInteger indexNumber;
@property (strong ,nonatomic) HorizontalPageViewController* horizontalViewControllerReference;

@end
