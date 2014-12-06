//
//  DownViewController.m
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "DownViewController.h"
#import "RQShineLabel.h"
#import "Constants.h"

@interface DownViewController ()
@property (strong,nonatomic) RQShineLabel *shineDescriptionLabel;
@end

@implementation DownViewController

- (CGRect)calculateFrame {

    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenBound.size.width - 32;
    
    CGSize maximumLabelSize = CGSizeMake(screenWidth, MAXFLOAT);
    
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin;
    
    NSDictionary *attr = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};
    CGRect labelBounds = [kAboutDescription boundingRectWithSize:maximumLabelSize
                                              options:options
                                           attributes:attr
                                              context:nil];
    
    return labelBounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.shineDescriptionLabel = [[RQShineLabel alloc] initWithFrame:[self calculateFrame]];
    self.shineDescriptionLabel.numberOfLines = 0;
    self.shineDescriptionLabel.text = kAboutDescription;
    self.shineDescriptionLabel.textColor = [UIColor blackColor];
    self.shineDescriptionLabel.backgroundColor = [UIColor clearColor];
    self.shineDescriptionLabel.center = self.view.center;
    [self.view addSubview:self.shineDescriptionLabel];
    
    [self.shineDescriptionLabel sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.shineDescriptionLabel shine];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.shineDescriptionLabel instantFade];
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
