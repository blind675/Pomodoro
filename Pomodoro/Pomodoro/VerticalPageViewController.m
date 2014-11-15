//
//  VerticalPageViewController.m
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "VerticalPageViewController.h"
#import "BaseViewController.h"
#import "Constants.h"

@interface VerticalPageViewController ()

@end

@implementation VerticalPageViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:nil];
    
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    NSArray *viewControllers = @[[self viewControllerAtIndex:4]];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
}

#pragma  - UIPageViewController Methods
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(BaseViewController *)viewController indexNumber];
    if (index == 3) {
        return nil;
    }
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(BaseViewController *)viewController indexNumber];
    index++;
    if (index == 6) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (BaseViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    BaseViewController *childViewController;
    
    if (index == 3) {
        childViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"upView"];
        childViewController.indexNumber = 3;
    } else if(index == 4){
        childViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
        childViewController.indexNumber = 4;
    } else {
        childViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"downView"];
        childViewController.indexNumber = 5;
    }
    
    return childViewController;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    UIViewController *vc = [pageViewController.viewControllers lastObject];
    // All instances of TestClass will be notified
    NSNumber *number = [NSNumber numberWithLong:[(BaseViewController *)vc indexNumber]];
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:number forKey:kVisibleControllerIndex];
    [[NSNotificationCenter defaultCenter] postNotificationName:kInactivatePages object:self userInfo:dataDict];

}

@end
