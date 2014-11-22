//
//  PageViewController.m
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "HorizontalPageViewController.h"
#import "VerticalPageViewController.h"
#import "BaseViewController.h"
#import "Constants.h"

@interface HorizontalPageViewController ()

@end

@implementation HorizontalPageViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    NSArray *viewControllers = @[[self viewControllerAtIndex:1]];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    
}

#pragma  - UIPageViewController Methods
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(BaseViewController *)viewController indexNumber];
    if (index == 0) {
        return nil;
    }
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(BaseViewController *)viewController indexNumber];
    index++;
    if (index == 3) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (BaseViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    BaseViewController *childViewController;
    
    if (index == 0) {
        childViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leftView"];
        childViewController.indexNumber = 0;
    } else if(index == 1){
        VerticalPageViewController* verticalControllerReference = [self.storyboard instantiateViewControllerWithIdentifier:@"verticalPageView"];
        verticalControllerReference.horizontalViewControllerReference = self;
        
        childViewController = (BaseViewController *)verticalControllerReference;
        childViewController.indexNumber = 1;
    } else {
        childViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"rightView"];
        childViewController.indexNumber = 2;
    }
    
    return childViewController;
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
