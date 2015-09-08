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
{
    UIActivityIndicatorView *spinner;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"RecipeImages" ofType:@"plist"];
    
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSMutableArray *tempArray=[[NSMutableArray alloc] initWithArray:[dict objectForKey:@"recipeNames"]];
    self.recipeImages = tempArray;
    [self.myCollectionViewOutlet registerNib:[UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CustomCollectionViewCell"];
    
    //self.edgesForExtendedLayout = UIRectEdgeNone;
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
    
    if(indexPath.row<[self.recipeImages count])
    {
        NSMutableDictionary *dict=[self.recipeImages objectAtIndex:indexPath.row];
        cell.myImageViewOutlet.backgroundColor=[UIColor redColor];
        
        NSString *url= [NSString stringWithFormat:@"%@",dict[@"URL"]];
        //Set up Request:
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        [request setURL:[NSURL URLWithString:url]];
        
        NSOperationQueue *queue=[[NSOperationQueue alloc] init];
        if ( queue == nil ){
            queue = [[NSOperationQueue alloc] init];
        }
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * resp, NSData     *data, NSError *error)
         {
             dispatch_async(dispatch_get_main_queue(),^
                            {
                                if ( error == nil && data )
                                {
                                    UIImage *urlImage = [[UIImage alloc] initWithData:data];
                                    [cell.myImageViewOutlet setImage:urlImage];
                                }
                            });
         }];

//        NSString *ImageURL = dict[@"URL"];
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
//        [cell.myImageViewOutlet setImage:[UIImage imageWithData:imageData]];
//        
        
        //[cell.myImageViewOutlet setImage:[UIImage imageNamed:[self.recipeImages objectAtIndex:indexPath.row]]];
        [cell.subtitleLabelOutlet setText:dict[@"name"]];
        cell.viewButtonOutlet.tag=indexPath.row;
        cell.delegate=self;
    }    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((collectionView.frame.size.width/2)-10, 150);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:indexPath.row];
    
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    //self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    self.pageViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:self.pageViewController];
    navigationController.navigationBar.translucent=NO;
    navigationController.navigationBar.backgroundColor=[UIColor grayColor];
    //navigationController.navigationItem.backBarButtonItem.enabled=YES;
    //now present this navigation controller modally
    [self presentViewController:navigationController
                       animated:YES
                     completion:nil];
    //[self presentViewController:self.pageViewController animated:YES completion:nil];
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [self.myCollectionViewOutlet dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionHeaderView" forIndexPath:indexPath];
        
        UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
        view.backgroundColor = [UIColor grayColor];
        UILabel *headerTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        headerTitle.text=@"Recipe Images";
        headerTitle.textAlignment=NSTextAlignmentCenter;
        
        [view addSubview:headerTitle];
        [headerView addSubview:view];
        
        return headerView;
    }
    return nil;
}

#pragma mark Page View Controller delegates
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
    NSMutableDictionary *dict=[self.recipeImages objectAtIndex:index];
    
    pageContentViewController.imageFile= dict[@"URL"] ;
    pageContentViewController.titleText = dict[@"name"];
    pageContentViewController.pageIndex = index;
    //pageContentViewController.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
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



//Custom delegate for View Button from inside custom cell to display pop-up View
-(void) buttonWasPressed:(id)sender{
    
    
    NSMutableDictionary *dict=[self.recipeImages objectAtIndex:[sender tag]];
    NSString *ImageURL = dict[@"URL"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    UIView *popupView=[[UIView alloc] init];
    CGRect viewFrame=popupView.frame;
    viewFrame.size.width=300;
    viewFrame.size.height=300;
    popupView.frame=viewFrame;
    popupView.center=self.view.center;
    // popupView.center=[self.view convertPoint:self.view.center fromView:self.view];
    UIImageView *popImageView=[[UIImageView alloc] initWithImage:[UIImage imageWithData:imageData]];
    //self.imageViewInsideUIViewOutlet.image=[UIImage imageNamed:[self.recipeImages objectAtIndex:[sender tag]]];
    viewFrame.size.height=popupView.frame.size.height-30;
    popImageView.frame=viewFrame;
    [popupView addSubview:popImageView];
    CGRect labelRect=CGRectMake(0, popImageView.frame.size.height, popupView.frame.size.width, 30);
    UILabel *titleLabel=[[UILabel alloc] init];
    titleLabel.frame=labelRect;
    titleLabel.text=dict[@"name"];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [popupView addSubview:titleLabel];
    
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cancelButton addTarget:self action:@selector(exitButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setFrame:CGRectMake(0, 0, 32, 32)];
    [cancelButton setTitle:@"x" forState:UIControlStateNormal];
    cancelButton.backgroundColor=[UIColor blackColor];
    popupView.backgroundColor=[UIColor blackColor];
    [popupView addSubview:cancelButton];
    popupView.tag=999;
    
    [[self.view subviews]
     makeObjectsPerformSelector:@selector(setUserInteractionEnabled:)
     withObject:[NSNumber numberWithBool:FALSE]];
    
    
    [popupView setAlpha:0];
    [self.view addSubview:popupView];
    
    [UIView beginAnimations:@"FadeIn" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [popupView setAlpha:1];
    [UIView commitAnimations];
    for (UIView * v in [self.view subviews]) {
        if(v.tag==999)
            v.alpha=1;
        else
            v.alpha=0.4;
    }
    
}
//selector for "touch up inside" event of exit(x) button of pop-up view
-(void) exitButtonPressed{
    
    
  
    UIView * subview = [self.view viewWithTag:999];
    
    float fadeDuration = 0.5;
    [UIView beginAnimations:@"FadeOut" context:nil];
    [UIView setAnimationDuration:fadeDuration ];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [subview setAlpha:0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeView)];
    [UIView commitAnimations];
    
}
-(void)removeView{
    UIView * popupView = [self.view viewWithTag:999];
    [popupView removeFromSuperview];
    for (UIView * v in [self.view subviews]) {
        v.userInteractionEnabled=YES;
        v.alpha=1;
    }
}




#pragma mark pagination:
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //if (!self.loading) {
    float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (endScrolling >= scrollView.contentSize.height)
    {
        [self performSelector:@selector(loadDataDelayed) withObject:nil afterDelay:1];
        spinner= [[UIActivityIndicatorView alloc] init];
        spinner.center=self.view.center;
        CGAffineTransform transform = CGAffineTransformMakeScale(3.0f, 3.0f);
        spinner.transform = transform;
        spinner.color = [UIColor whiteColor];
        [self.view addSubview:spinner];
        [spinner startAnimating];
        
        //NSLog(@"at end of scrollview");
    }
    // }
    
}

-(void)loadDataDelayed{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    for (int i=0; i<10 ; i++) {
        //NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:@"id",@"1",@"name",@"", nil];
        [array addObject:[self.recipeImages objectAtIndex:i]];
    }
    [self.recipeImages addObjectsFromArray:array];
    [self.myCollectionViewOutlet reloadData];
    [spinner removeFromSuperview];
}

@end
