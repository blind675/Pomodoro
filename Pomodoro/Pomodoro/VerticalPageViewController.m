//
//  VerticalPageViewController.m
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "VerticalPageViewController.h"
#import "Constants.h"
#import "MainViewController.h"
#import "UpViewController.h"
#import "DownViewController.h"

@interface VerticalPageViewController ()

@property (strong,nonatomic) NSArray *viewControllersList;

@end

@implementation VerticalPageViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    
    NSLog(@"Loaded   - Vertical View Controller");
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // set the view controllers array
    UpViewController *upViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"upView"];
    MainViewController *mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
    DownViewController *downViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"downView"];
   
    self.viewControllersList = @[upViewController,mainViewController,downViewController];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:nil];
    
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    NSArray *viewControllers = @[self.viewControllersList[1]];

    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
}

#pragma  - UIPageViewController Methods
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[MainViewController class]]) {
        // the up view contrller
        return self.viewControllersList[0];
    } else if ( [viewController isKindOfClass:[DownViewController class]]){
        // the main view controller
        return self.viewControllersList[1];
    }
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[MainViewController class]]) {
        // the down view contrller
        return self.viewControllersList[2];
    } else if ( [viewController isKindOfClass:[UpViewController class]]){
        // the main view controller
        return self.viewControllersList[1];
    }
    
    return nil;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    UIViewController *vc = [pageViewController.viewControllers lastObject];
 
    if ([vc isKindOfClass:[MainViewController class]]) {
        [self.horizontalViewControllerReference validatePageViewController];
    } else {
        [self.horizontalViewControllerReference invalidatePageViewController];
    }
}

@end
