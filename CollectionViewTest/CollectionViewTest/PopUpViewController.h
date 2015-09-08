//
//  PopUpViewController.h
//  CollectionViewTest
//
//  Created by Prashant Saini on 07/09/15.
//  Copyright (c) 2015 Prashant Saini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopUpViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *popUpImageViewOutlet;
@property (strong, nonatomic) IBOutlet UILabel *titleLabelOutlet;
- (IBAction)exitButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *exitButtonOutlet;

@end
