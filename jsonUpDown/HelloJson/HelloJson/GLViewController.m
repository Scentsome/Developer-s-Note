//
//  GLViewController.m
//  HelloJson
//
//  Created by chronoer on 9/2/12.
//  Copyright (c) 2012 GLuck. All rights reserved.
//

#import "GLViewController.h"
#define Server @"http://127.0.0.1:8800/json"
#define JITSU @"http://scentsome.course.jit.su/json"
#define APPFOG @"http://course.rs.af.cm/json"
@interface GLViewController (){
    NSURLConnection * getConnection;
    NSURLConnection * sendConnection;
    
}
@property (strong) NSMutableData * upData;
@property (strong) NSMutableData * downData;
@end

@implementation GLViewController
@synthesize upData;
@synthesize downData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.downData = [NSMutableData data];
    self.upData = [NSMutableData data];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (IBAction)sendJson:(id)sender {
    self.upData = [NSMutableData data];
    NSURL * jsonURL = [NSURL URLWithString:Server];
    NSMutableURLRequest * mRequest = [NSMutableURLRequest requestWithURL:jsonURL];
    mRequest.HTTPMethod = @"POST";
    [mRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSMutableData * postBody = [NSMutableData data];
    [postBody appendData:[@"data=" dataUsingEncoding:NSUTF8StringEncoding]];
    NSDictionary * jsonObject = [NSDictionary dictionaryWithObjectsAndKeys:@"michael",@"name",@"1234",@"password", nil];
    [postBody appendData:[NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:NULL]];
    [mRequest setHTTPBody:postBody];
    sendConnection = [NSURLConnection connectionWithRequest:mRequest delegate:self];
}
- (IBAction)getJson:(id)sender {
    self.downData = [NSMutableData  data];
    NSURL  * jsonURL = [NSURL URLWithString:[Server stringByAppendingFormat:@"?data=%@",@"hello"]];
    NSURLRequest * request = [NSURLRequest requestWithURL:jsonURL];
    getConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    if (connection == getConnection) {
        [self.downData appendData:data];
    }
    if (connection == sendConnection) {
        [self.upData appendData:data];
    }
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection{
    if (connection == getConnection) {
        NSDictionary * jsonObject = [NSJSONSerialization JSONObjectWithData:self.downData options:NSJSONWritingPrettyPrinted error:NULL];
        NSLog(@"Got json %@", jsonObject);
    }
    
    if (connection == sendConnection) {
        NSLog(@"Response : %@", [[NSString alloc] initWithData:self.upData encoding:NSUTF8StringEncoding]);
    }
}
@end
