//
//  GraphViewController.m
//  MyFinance
//
//  Created by chronoer on 8/10/12.
//  Copyright (c) 2012 GLuck. All rights reserved.
//

#import "GraphViewController.h"

@interface GraphViewController ()

@end

@implementation GraphViewController
@synthesize myWebView;
@synthesize records;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString * fileURL = [[NSBundle mainBundle] pathForResource:@"graph" ofType:@"html" inDirectory:@"jqplot"];
    NSURL * url = [NSURL URLWithString:[fileURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:urlRequest];
    myWebView.delegate = self;
	// Do any additional setup after loading the view.
}
-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"error r%@", error);
}
- (void)viewDidUnload
{
    [self setMyWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
