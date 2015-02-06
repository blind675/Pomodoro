//
//  LeftViewController.m
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "LeftViewController.h"
#import "CollectionViewCell.h"
#import "StatisticsModel.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    
    NSLog(@"Loaded   - Left View Controller");
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.yesterdayStats.text = [NSString stringWithFormat:@"%hu", [StatisticsModel yesterdayPomodoro]];
    self.maxStats.text = [NSString stringWithFormat:@"%hu", [StatisticsModel maxPomodoro]];
    self.avregeStats.text = [NSString stringWithFormat:@"%hu", [StatisticsModel averagePomodoro]];
    
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 32;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *tomatoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tomatoCel" forIndexPath:indexPath];
    
//    if (indexPath.item < 10) {
//        tomatoCell.tomatoImageView.image = [UIImage imageNamed:@"tomato-red.png"];
//    } else if (indexPath.item <15) {
//        tomatoCell.tomatoImageView.image = [UIImage imageNamed:@"tomato-orange.png"];
//    } else if (indexPath.item <20) {
//        tomatoCell.tomatoImageView.image = [UIImage imageNamed:@"tomato-green.png"];
//    } else if (indexPath.item <25) {
//        tomatoCell.tomatoImageView.image = [UIImage imageNamed:@"tomato-dark-green.png"];
//    } else if (indexPath.item <30) {
//        tomatoCell.tomatoImageView.image = [UIImage imageNamed:@"tomato-blue.png"];
//    } else {
        tomatoCell.tomatoImageView.image = [UIImage imageNamed:@"tomato-contur.png"];
//    }

    if ([StatisticsModel todaysPomodoro] > indexPath.item) {
        if (indexPath.item < 5) {
            tomatoCell.tomatoImageView.image = [UIImage imageNamed:@"tomato-green.png"];
        } else if (indexPath.item < 30) {
            tomatoCell.tomatoImageView.image = [UIImage imageNamed:@"tomato-orange.png"];
        } else {
            tomatoCell.tomatoImageView.image = [UIImage imageNamed:@"tomato-red.png"];
        }
    }
    return tomatoCell;
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
