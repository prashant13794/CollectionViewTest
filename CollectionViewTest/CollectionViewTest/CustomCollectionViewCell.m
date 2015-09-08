//
//  CustomCollectionViewCell.m
//  CollectionViewTest
//
//  Created by Prashant Saini on 04/09/15.
//  Copyright (c) 2015 Prashant Saini. All rights reserved.
//

#import "CustomCollectionViewCell.h"
#import "PageContentViewController.h"
@implementation CustomCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)viewButtonAction:(id)sender {
    
    
    [self.delegate buttonWasPressed:sender];
   // UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
//    [self presentViewController:page animated:YES completion:nil];
//    page.view.superview.frame = CGRectMake(0, 0, 540, 620); //it's important to do this after presentModalViewController
    //page.view.superview.center = self.view.center;
    //[V1 release];
}
@end
