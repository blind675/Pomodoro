//
//  PageViewController.m
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "HorizontalPageViewController.h"
#import "VerticalPageViewController.h"
#import "RightViewController.h"
#import "LeftViewController.h"
#import "Constants.h"

@interface HorizontalPageViewController ()

@property (strong,nonatomic) NSArray *viewControllersList;

@end

@implementation HorizontalPageViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    
    NSLog(@"Loaded   - Horizontal View Controller");
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    RightViewController* rightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"rightView"];
    VerticalPageViewController* verticalViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"verticalPageView"];
    verticalViewController.horizontalViewControllerReference = self;
    LeftViewController* leftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leftView"];
    
    self.viewControllersList = @[leftViewController,verticalViewController,rightViewController];
    
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    NSArray *viewControllers = @[self.viewControllersList[1]];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    
}

#pragma  - UIPageViewController Methods
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[VerticalPageViewController class]]) {
        // the left view contrller
        return self.viewControllersList[0];
    } else if ( [viewController isKindOfClass:[RightViewController class]]){
        // the main view controller
        return self.viewControllersList[1];
    }
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[VerticalPageViewController class]]) {
        // the right view contrller
        return self.viewControllersList[2];
    } else if ( [viewController isKindOfClass:[LeftViewController class]]){
        // the main view controller
        return self.viewControllersList[1];
    }
    
    return nil;
}

- (void)invalidatePageViewController {
    self.pageController.dataSource = nil;
}

- (void)validatePageViewController {
    self.pageController.dataSource = self;
}

- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
}

@end
