//
//  PageContentViewController.m
//  CollectionViewTest
//
//  Created by Prashant Saini on 06/09/15.
//  Copyright (c) 2015 Prashant Saini. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()


@end

@implementation PageContentViewController
//@synthesize imageViewOutlet;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.imageViewOutlet setImage:[UIImage imageNamed:self.imageFile]];
    [self.titleLabelOutlet setText:self.titleText];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)backButtonAction:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
