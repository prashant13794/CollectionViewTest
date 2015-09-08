//
//  ViewController.h
//  CollectionViewTest
//
//  Created by Prashant Saini on 04/09/15.
//  Copyright (c) 2015 Prashant Saini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCollectionViewCell.h"
@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIPageViewControllerDelegate,UIPageViewControllerDataSource,CustomCellButtonProtocol>

@property (strong,nonatomic) NSMutableArray * recipeImages;
@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionViewOutlet;

@property (strong, nonatomic) UIPageViewController *pageViewController;
//@property (strong, nonatomic) IBOutlet UIImageView *imgviewoutlet;
@property (strong, nonatomic) IBOutlet UIView *myUIViewOutlet;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewInsideUIViewOutlet;

@end

