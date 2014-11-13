//
//  ViewController.m
//  Pomodoro
//
//  Created by Catalin BORA on 12/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

CGFloat startScrollPozition;

typedef NS_ENUM(NSInteger, VisibleView)
{
    MainView = 1,
    UpView,
    DownView,
    LeftView,
    RightView,
} currentVisibleView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.scrollView.pagingEnabled = NO;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height * 3);
    
    self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    
    // go to the main view
    CGPoint offset = CGPointMake(0,self.scrollView.frame.size.height);
    [self.scrollView setContentOffset:offset animated:NO];
    currentVisibleView = MainView;
    
    UIView *starView = [[UIView alloc] initWithFrame:CGRectMake(0, self.scrollView.frame.size.height, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    starView.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:starView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    CGFloat endScrollPozition = self.scrollView.contentOffset.y;
    if (decelerate == NO) {
        [self snapScrollViewWithEndScrollPosition:endScrollPozition];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat endScrollPozition = self.scrollView.contentOffset.y;
    [self snapScrollViewWithEndScrollPosition:endScrollPozition];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    startScrollPozition = self.scrollView.contentOffset.y;
}

#pragma mark - snaping

-(void)snapScrollViewWithEndScrollPosition:(CGFloat) endScrollPosition{
    
    NSLog(@" startPozition: %f.2 - endPozition: %f.2",startScrollPozition,endScrollPosition);
    CGPoint offset;
    
    // make a 10 points buffer
    if ( startScrollPozition < ( endScrollPosition - 100 ) ) {
        NSLog(@" - scroll down");
        if (currentVisibleView == UpView) {
            // scroll to the main view
            currentVisibleView = MainView;
            offset = CGPointMake(0,self.scrollView.frame.size.height);
            [self.scrollView setContentOffset:offset animated:YES];
        } else if (currentVisibleView == MainView) {
            // scroll to the down view
            currentVisibleView = DownView;
            offset = CGPointMake(0,self.scrollView.frame.size.height*2);
            [self.scrollView setContentOffset:offset animated:YES];
        }
    } else if ( ( startScrollPozition - 100 )  >  endScrollPosition ){
        NSLog(@" - scroll up");
        if (currentVisibleView == DownView) {
            // scroll to the main view
            currentVisibleView = MainView;
            offset = CGPointMake(0,self.scrollView.frame.size.height);
            [self.scrollView setContentOffset:offset animated:YES];
        } else if (currentVisibleView == MainView) {
            // scroll to the down view
            currentVisibleView = UpView;
            offset = CGPointMake(0,0);
            [self.scrollView setContentOffset:offset animated:YES];
        }
    } else {
        //snap back to position
        if (currentVisibleView == UpView) {
            offset = CGPointMake(0,0);
        } else if (currentVisibleView == DownView) {
            offset = CGPointMake(0,self.scrollView.frame.size.height*2);
        } else {
            offset = CGPointMake(0,self.scrollView.frame.size.height);
        }
        [self.scrollView setContentOffset:offset animated:YES];
    }
}
@end
