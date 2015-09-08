//
//  PageContentViewController.m
//  CollectionViewTest
//
//  Created by Prashant Saini on 06/09/15.
//  Copyright (c) 2015 Prashant Saini. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()
@property (nonatomic) NSMutableData *imageData;
@property (nonatomic) NSUInteger totalBytes;
@property (nonatomic) NSUInteger receivedBytes;

@end


@implementation PageContentViewController
//@synthesize imageViewOutlet;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSString *url= [NSString stringWithFormat:@"%@",self.imageFile];
//    //Set up Request:
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
//    [request setURL:[NSURL URLWithString:url]];
//    
//    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
//    if ( queue == nil ){
//        queue = [[NSOperationQueue alloc] init];
//    }
//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * resp, NSData     *data, NSError *error)
//     {
//         dispatch_async(dispatch_get_main_queue(),^
//                        {
//                            if ( error == nil && data )
//                            {
//                                UIImage *urlImage = [[UIImage alloc] initWithData:data];
//                               [self.imageViewOutlet setImage:urlImage];
//                            }
//                        });
//     }];
////    NSString *ImageURL = self.imageFile;
////    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
////    [self.imageViewOutlet setImage:[UIImage imageWithData:imageData]];
    NSURL *url = [NSURL URLWithString:self.imageFile];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    [self.titleLabelOutlet setText:self.titleText];
    //self.imageViewOutlet.backgroundColor=[UIColor redColor];
    self.progressViewOutlet.progress=0;
    
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
#pragma mark NSURLConnection delegates
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    NSDictionary *dict = httpResponse.allHeaderFields;
    NSString *lengthString = [dict valueForKey:@"Content-Length"];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *length = [formatter numberFromString:lengthString];
    self.totalBytes = length.unsignedIntegerValue;
    
    self.imageData = [[NSMutableData alloc] initWithCapacity:self.totalBytes];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
//    [self.imageData appendData:data];
//    self.receivedBytes += data.length;
    
    //self.progressViewOutlet.progress=self.receivedBytes/self.totalBytes;
    
    
    
    NSLog(@"into didReceiveData");
    [self.imageData appendData:data];
    assert(self.imageData); // it exists
    assert([self.imageData length]); // it also has some data in it
    
    //self.setting.enabled = NO;
    float progressive = (float)[self.imageData length] / (float)self.totalBytes;
    assert(self.totalBytes > 0);
    //assert(progressive > 0 && progressive <= 1);
    assert(self.progressViewOutlet);
    assert(!self.progressViewOutlet.hidden);
    //assert(!self.progressViewOutlet.alpha > 0.5);
    //assert(self.progressViewOutlet.window);
    [self.progressViewOutlet setProgress:progressive];
//    [NSThread sleepForTimeInterval:self.totalBytes+100];
//    [self performSelectorOnMainThread:@selector(notifyDelegateDidReceiveData:) withObject:data waitUntilDone:NO];
//
}

//-(void)notifyDelegateDidReceiveData:(NSData*)data
//{
//    assert([NSThread isMainThread]);
//    [delegate myConnectionWrapper:self didReceiveData:data];
//}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.imageViewOutlet.image = [UIImage imageWithData:self.imageData];
    self.progressViewOutlet.hidden = YES;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //handle error
}



@end
