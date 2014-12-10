//
//  LeftViewController.h
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController <UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *yesterdayStats;
@property (weak, nonatomic) IBOutlet UILabel *maxStats;
@property (weak, nonatomic) IBOutlet UILabel *avregeStats;

@end
