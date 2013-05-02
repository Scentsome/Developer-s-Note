//
//  ViewController.m
//  AuthDemo
//
//  Created by chronoer on 13/4/30.
//  Copyright (c) 2013年 Zencher Co., Ltd. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()<UIAlertViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (strong) NSString * apikey;
@property (strong) NSArray * loggedMessages;
@property (weak, nonatomic) IBOutlet UITableView *listView;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@end

@implementation ViewController
-(void) queryLoggedMessage{
    NSURL * queryURL = [NSURL URLWithString:[AWSServer stringByAppendingFormat:@"/api/posts"]];
    NSURLRequest * request = [NSURLRequest requestWithURL:queryURL];
    AFJSONRequestOperation * operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"JSON Data %@", JSON);
        if (JSON != nil) {
            NSArray * listData = JSON;
            self.loggedMessages = [listData valueForKey:@"text"];
            [self.listView reloadData];
        }
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@", error);
    }];
    
    [operation start ];
    
}
- (void)modifyDisplayLayout:(NSNotification *)note
{
    CGRect endRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect originalRect = self.listView.frame;
    
    
    UIWindow * window = [UIApplication sharedApplication].windows[0];
    CGRect rectInView = [window convertRect:endRect toView:self.view];
    self.inputView.frame = CGRectMake(rectInView.origin.x, rectInView.origin.y-self.inputView.frame.size.height, self.inputView.frame.size.width, self.inputView.frame.size.height);
    
    self.listView.frame = CGRectMake(originalRect.origin.x, originalRect.origin.y, originalRect.size.width, rectInView.origin.y - originalRect.origin.y-self.inputView.frame.size.height);
}
-(void) moveToLatestCell{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:([self.loggedMessages count]-1) inSection:0];
    [self.listView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.loggedMessages = @[@"one",@"two",@"three",@"one",@"two",@"three",@"one",@"two",@"three",@"one",@"two",@"three"];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
//        NSLog(@"%@",note);
        
        
        [self modifyDisplayLayout:note];
        [self moveToLatestCell];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [self modifyDisplayLayout:note];
        [self moveToLatestCell];
    }];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)checkAPIKey {
    if (self.apikey == nil || [self.apikey isEqualToString:@""]) {
        id loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSHTTPCookie *cookie;
    
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [cookieJar cookies]) {
        NSLog(@"%@ %@ %@", cookie.name, cookie.value, cookie.expiresDate);
        
        if ([cookie.name isEqualToString:@"apikey"]) {
            if ([cookie.expiresDate timeIntervalSinceDate:[NSDate date]] <0 ) {
                NSLog(@"cookie expired");
                [cookieJar deleteCookie:cookie];
            }else{
                self.apikey = cookie.value;
            }
            
        }
    }

    [self checkAPIKey];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)validateAccount:(id)sender {
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Validate" message:@"Please enter validation code" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            NSLog(@"Cancel");
            break;
        }
        case 1:{
            NSLog(@"Send validation code");
            NSString * validationCode = [alertView textFieldAtIndex:0].text;
            [self remoteValidateAccount:validationCode];
            break;
        }
        default:
            break;
    }
}
-(void) remoteValidateAccount:(NSString *) vCode{
    NSURL * url = [NSURL URLWithString:[AWSServer stringByAppendingFormat:@"/validateToken?token=%@", vCode]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {
        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *) response;
        NSLog(@"status %d", httpResponse.statusCode);
    }];
    
}

-(void) postMessage:(NSString *) text{
    NSURL * postURL = [NSURL URLWithString:[AWSServer stringByAppendingFormat:@"/api/posts"]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:postURL];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[NSString stringWithFormat:@"text=%@", text] dataUsingEncoding:NSUTF8StringEncoding];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {
        if (!error) {
            NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        }
    }];
}
-(IBAction) backToHome:(UIStoryboardSegue *) sender{
    
}
- (IBAction)updateListData:(id)sender {
    [self queryLoggedMessage];
}
- (IBAction)sendMessage:(id)sender {
    
    [self postMessage:self.inputField.text];
    [self.inputField resignFirstResponder];
}

#pragma mark Table View Data Source
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.loggedMessages count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = self.loggedMessages[indexPath.row];
    return cell;
}
- (IBAction)logout:(id)sender {
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie * cookie in [cookieJar cookies]) {
        NSLog(@"%@ %@ %@", cookie.name, cookie.value, cookie.expiresDate);
        
        if ([cookie.name isEqualToString:@"apikey"]) {
            [cookieJar deleteCookie:cookie];
            self.apikey = nil;
            
        }
    }
    [self checkAPIKey];
}
@end
