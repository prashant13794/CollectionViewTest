//
//  PageViewController.h
//  CollectionViewTest
//
//  Created by Prashant Saini on 06/09/15.
//  Copyright (c) 2015 Prashant Saini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPageViewController : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
    
}
@property (strong,nonatomic) NSString *mystring;
@property (strong,nonatomic) NSMutableArray *recipeImages1;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property NSInteger *curIndex;
@end
