//
//  UpViewController.m
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "UpViewController.h"
#import "DFPBannerView.h"
#import "GADRequest.h"

@interface UpViewController ()

@end

@implementation UpViewController

- (void)viewDidLoad {
    
    NSLog(@"Loaded   - Up View Controller");
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.bannerView.adUnitID = @"ca-app-pub-4761990429695317/6628430382";
    self.bannerView.rootViewController = self;
    
    [self.bannerView loadRequest:[GADRequest request]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
