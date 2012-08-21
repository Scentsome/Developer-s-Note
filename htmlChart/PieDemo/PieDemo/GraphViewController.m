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
@synthesize sums;
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
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(testJS)];
    self.navigationItem.rightBarButtonItem = addButton;
    NSString * fileURL = [[NSBundle mainBundle] pathForResource:@"graph" ofType:@"html" inDirectory:@"jqplot"];
    NSURL * url = [NSURL URLWithString:[fileURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:urlRequest];
    myWebView.delegate = self;
   
   
    
    
	// Do any additional setup after loading the view.
}
-(void) testJS{
    [myWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"gotData('%@','%@');", @"hello", @"world"]];
}
-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"error r%@", error);
}
-(void) webViewDidFinishLoad:(UIWebView *)webView{
    NSMutableArray * catArray = [NSMutableArray array];
    NSMutableArray * valueArray = [NSMutableArray array];
    [self.sums enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [catArray addObject:key];
        [valueArray addObject:obj];
    }];
 
    NSString * jsonArray = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:catArray options:NSJSONWritingPrettyPrinted error:NULL] encoding:NSUTF8StringEncoding];
    NSString * jsonValue = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:valueArray options:NSJSONWritingPrettyPrinted error:NULL] encoding:NSUTF8StringEncoding];
    NSLog(@"json Array %@", jsonArray);
    NSLog(@"value array %@", jsonValue);
    [myWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"gotData(%@,%@); drawPie();",jsonArray ,jsonValue]];
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
