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
@property (strong,nonatomic) NSArray *aboutTextsArray;
@property (nonatomic) BOOL didTheViewActuallyDisappear;
@end

@implementation DownViewController

- (CGRect)calculateFrameForText:(NSString*)text {

    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenBound.size.width - 32;
    
    CGSize maximumLabelSize = CGSizeMake(screenWidth, MAXFLOAT);
    
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin;
    
    NSDictionary *attr = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};
    CGRect labelBounds = [text boundingRectWithSize:maximumLabelSize
                                              options:options
                                           attributes:attr
                                              context:nil];
    
    return labelBounds;
}

- (void)viewDidLoad {
    
    NSLog(@"Loaded   - Down View Controller");
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.shineDescriptionLabel = [[RQShineLabel alloc] initWithFrame:[self calculateFrameForText:kAboutDescription1]];
    self.shineDescriptionLabel.numberOfLines = 0;
    self.shineDescriptionLabel.text = kAboutDescription1;
    self.shineDescriptionLabel.textColor = [UIColor blackColor];
    self.shineDescriptionLabel.backgroundColor = [UIColor clearColor];
    self.shineDescriptionLabel.center = self.view.center;
    [self.view addSubview:self.shineDescriptionLabel];
    
    // populate the about array
    self.aboutTextsArray = @[kAboutDescription7,kAboutDescription4,kAboutDescription1,kAboutDescription6,kAboutDescription3,kAboutDescription5,kAboutDescription2];
    
    self.didTheViewActuallyDisappear = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    // this is called for every little page view movement
    if (self.didTheViewActuallyDisappear == YES) {
        [super viewWillAppear:animated];

        NSString *randomText = self.aboutTextsArray[arc4random_uniform(7)];

        self.shineDescriptionLabel.frame = [self calculateFrameForText:randomText];
        self.shineDescriptionLabel.center = self.view.center;
        self.shineDescriptionLabel.text = randomText;
    
        self.didTheViewActuallyDisappear = NO;
        
        [self.shineDescriptionLabel shine];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.shineDescriptionLabel instantFade];
    
    self.didTheViewActuallyDisappear = YES;

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
