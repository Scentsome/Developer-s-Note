//
//  LoginViewController.m
//  AuthDemo
//
//  Created by chronoer on 13/4/30.
//  Copyright (c) 2013年 Zencher Co., Ltd. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"




@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *editingScrollView;
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation LoginViewController

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
    CGRect originalRect = self.editingScrollView.frame;
    self.editingScrollView.contentSize = originalRect.size;
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
//        NSLog(@"%@",note);
     
    
        CGRect endRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGRect originalRect = self.editingScrollView.frame;
        self.editingScrollView.frame = CGRectMake(originalRect.origin.x, originalRect.origin.y, originalRect.size.width, endRect.origin.y - originalRect.origin.y);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        CGRect endRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGRect originalRect = self.editingScrollView.frame;
        self.editingScrollView.frame = CGRectMake(originalRect.origin.x, originalRect.origin.y, originalRect.size.width, endRect.origin.y - originalRect.origin.y);
    }];
	// Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) remoteLogin{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL * url = [NSURL URLWithString:[AWSServer stringByAppendingFormat:@"/login?username=%@&password=%@", self.accountField.text, self.passwordField.text]];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {
        NSLog(@"back message");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (data == nil) {
            NSLog(@"Login error %@", error);
        }else{
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *) response;
            NSLog(@"status %d", httpResponse.statusCode);
            NSInteger statusCode = httpResponse.statusCode;
            dispatch_async(dispatch_get_main_queue(), ^{
                switch (statusCode) {
                    case 200:{
                        self.statusLabel.text = @"Successfully Logged in";
                        break;
                    }
                    case 403:{
                        self.statusLabel.text = @"Invalid Usernam or Password";
                        break;
                    }
                    case 506:{
                        self.statusLabel.text = @"Waiting for validation";
                        break;
                    }
                    default:
                        break;
                }
            });

        }
    }];
}
#pragma mark Text Field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 10) {
        [textField resignFirstResponder];
        [self.passwordField becomeFirstResponder];
        CGRect visiblePass = self.passwordField.frame;
        [self.editingScrollView scrollRectToVisible:CGRectMake(visiblePass.origin.x, visiblePass.origin.y+30, visiblePass.size.width, visiblePass.size.height) animated:YES];
    }
    
    if (textField.tag == 11) {
        [self remoteLogin];
        [textField resignFirstResponder];
    }
    return YES;
}
- (IBAction)login:(id)sender {
    [self remoteLogin];
}
- (IBAction)validateCode:(id)sender {
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

-(IBAction) backToLoginView:(UIStoryboardSegue *)sender{
    
}
@end
