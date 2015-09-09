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
    NSURL *url = [NSURL URLWithString:self.imageFile];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    [self.titleLabelOutlet setText:self.titleText];
    [self.pageNumberLabelOutlet setText:[NSString stringWithFormat:@"%d",self.pageIndex]];
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
    assert(self.imageData);
    assert([self.imageData length]);
    float progressive = (float)[self.imageData length] / (float)self.totalBytes;
    assert(self.totalBytes > 0);
    assert(self.progressViewOutlet);
    assert(!self.progressViewOutlet.hidden);
    [self.progressViewOutlet setProgress:progressive];
    
}

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
