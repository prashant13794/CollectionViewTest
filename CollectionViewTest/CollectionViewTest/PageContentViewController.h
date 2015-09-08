//
//  PageContentViewController.h
//  CollectionViewTest
//
//  Created by Prashant Saini on 06/09/15.
//  Copyright (c) 2015 Prashant Saini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageViewOutlet;
@property (weak, nonatomic) IBOutlet UILabel *titleLabelOutlet;
@property (strong,nonatomic) NSString *imageFile;
@property (strong,nonatomic) NSString *titleText;
@property NSUInteger *pageIndex;
- (IBAction)backButtonAction:(id)sender;

@end
