//
//  ViewController.m
//  CollectionViewTest
//
//  Created by Prashant Saini on 04/09/15.
//  Copyright (c) 2015 Prashant Saini. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewCell.h"
#import "PageContentViewController.h"
#import "PopUpViewController.h"
//#import "CustomPageViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.recipeImages = [NSMutableArray arrayWithObjects:@"angry_birds_cake", @"creme_brelee", @"egg_benedict", @"full_breakfast", @"green_tea", @"ham_and_cheese_panini", @"creme_brelee", @"hamburger", @"instant_noodle_with_egg", @"japanese_noodle_with_pork", @"mushroom_risotto", @"noodle_with_bbq_pork", @"starbucks_coffee", @"creme_brelee", @"vegetable_curry", nil];
    [self.myCollectionViewOutlet registerNib:[UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CustomCollectionViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Collection delegates

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.recipeImages.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier =@"CustomCollectionViewCell";
    CustomCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if(cell==nil){
        //[collectionView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellWithReuseIdentifier:identifier];
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        }

    
    //cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame.png"]];
    cell.myImageViewOutlet.backgroundColor=[UIColor redColor];
    //cell.myImageViewOutlet.image=[UIImage imageNamed:@"angry_birds_cake.png"];
    [cell.myImageViewOutlet setImage:[UIImage imageNamed:[self.recipeImages objectAtIndex:indexPath.row]]];
    [cell.subtitleLabelOutlet setText:[self.recipeImages objectAtIndex:indexPath.row]];
    //cell.tag=indexPath.row;
    cell.viewButtonOutlet.tag=indexPath.row;
    cell.delegate=self;
    NSLog([self.recipeImages objectAtIndex:indexPath.row]);
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((collectionView.frame.size.width/2)-10, 100);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //[self performSegueWithIdentifier:@"pageViewControllerSegue" sender:indexPath];
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:indexPath.row];
    
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    //self.pageViewController.modalPresentationStyle=UIModalPresentationFormSheet;
    [self presentModalViewController:self.pageViewController animated:YES];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.recipeImages count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.recipeImages count] == 0) || (index >= [self.recipeImages count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile =self.recipeImages[index];
    pageContentViewController.titleText = self.recipeImages[index];
    pageContentViewController.pageIndex = index;
    //pageContentViewController.modalPresentationStyle=UIModalPresentationFormSheet;
    return pageContentViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.recipeImages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}
-(void) buttonWasPressed:(id)sender{
    PopUpViewController *page = [self.storyboard instantiateViewControllerWithIdentifier:@"PopUpViewController"];
       CGRect pageFrame=page.view.frame;
    pageFrame.size.width=300;
    pageFrame.size.height=300;
    page.view.frame=pageFrame;
    page.view.center=self.view.center;

    //page.view.frame.size = CGSizeMake(<#CGFloat width#>, <#CGFloat height#>)
    page.modalPresentationStyle = UIModalPresentationFormSheet;
    page.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [page.popUpImageViewOutlet setImage:[UIImage imageNamed:[self.recipeImages objectAtIndex:[sender tag]]]];
    page.titleLabelOutlet.text=[self.recipeImages objectAtIndex:[sender tag]];
    //page.view.
    
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cancelButton addTarget:self action:@selector(exitButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setFrame:CGRectMake(0, 0, 32, 32)];
    [cancelButton setTitle:@"x" forState:UIControlStateNormal];
    cancelButton.backgroundColor=[UIColor blackColor];
    page.view.backgroundColor=[UIColor yellowColor];
    [page.view addSubview:cancelButton];
    //[page.exitButtonOutlet targetForAction:@selector(exitButtonPressed:) withSender:self];
    [page.view setTag:999];
    //[self.view setAlpha:0.5];
    [self.view addSubview:page.view];
    
//    [[self.view subviews]
//     makeObjectsPerformSelector:@selector(setBackgroundColor:)
//     withObject:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]];
    [[self.view subviews]
     makeObjectsPerformSelector:@selector(setUserInteractionEnabled:)
     withObject:[NSNumber numberWithBool:FALSE]];
    //self.view.userInteractionEnabled=NO;
    [self.view viewWithTag:999].userInteractionEnabled=TRUE;
    //[self.view viewWithTag:999].alpha=1;
    
    //[self presentModalViewController:page animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    
}
-(void) exitButtonPressed{
    
    
//    [[self.view subviews]
//     makeObjectsPerformSelector:@selector(setUserInteractionEnabled:)
//     withObject:[NSNumber numberWithBool:TRUE]];
    UIView * subview = [self.view viewWithTag:999];
    //NSLog(@"%@",NSStringFromClass([self view].class));
    
    [subview removeFromSuperview];
    self.view.userInteractionEnabled=YES;
    for (UIView * v in [self.view subviews]) {
        v.userInteractionEnabled=YES;
    }
    //[self.view setAlpha:1];
}
@end
