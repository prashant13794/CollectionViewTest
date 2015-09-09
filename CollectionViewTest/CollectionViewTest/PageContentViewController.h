//
//  PageContentViewController.h
//  CollectionViewTest
//
//  Created by Prashant Saini on 06/09/15.
//  Copyright (c) 2015 Prashant Saini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController<NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageViewOutlet;
@property (weak, nonatomic) IBOutlet UILabel *titleLabelOutlet;
@property (strong,nonatomic) NSString *imageFile;
@property (strong,nonatomic) NSString *titleText;
@property NSUInteger *pageIndex;
- (IBAction)backButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIProgressView *progressViewOutlet;
@property (strong, nonatomic) IBOutlet UILabel *pageNumberLabelOutlet;

@end
