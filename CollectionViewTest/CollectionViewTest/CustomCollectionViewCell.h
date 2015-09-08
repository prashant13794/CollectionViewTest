//
//  CustomCollectionViewCell.h
//  CollectionViewTest
//
//  Created by Prashant Saini on 04/09/15.
//  Copyright (c) 2015 Prashant Saini. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomCellButtonProtocol <NSObject>

-(void)buttonWasPressed:(id)sender;

@end

@interface CustomCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *subtitleLabelOutlet;
@property (strong, nonatomic) IBOutlet UIImageView *myImageViewOutlet;
- (IBAction)viewButtonAction:(id)sender;
@property (nonatomic, assign) id <CustomCellButtonProtocol> delegate;
@property (strong, nonatomic) IBOutlet UIButton *viewButtonOutlet;
@end


