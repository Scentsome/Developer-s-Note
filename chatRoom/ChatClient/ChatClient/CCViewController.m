//
//  CCViewController.m
//  ChatClient
//
//  Created by chronoer on 9/11/12.
//  Copyright (c) 2012 GLuck. All rights reserved.
//

#import "CCViewController.h"

@interface CCViewController (){
    NSMutableString * resultString;
    SocketIO *socketIO;
}


@end

@implementation CCViewController
@synthesize inputTextField;
@synthesize resultTextView;
- (IBAction)login:(id)sender {
    UIAlertView * nameAlert = [[UIAlertView alloc] initWithTitle:@"Welcome to ChatRoom" message:@"Who are you" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    nameAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [nameAlert show];
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString * inputName = [alertView textFieldAtIndex:0].text;
    
    [socketIO connectToHost:@"localhost" onPort:8124];
    NSDictionary * hello = [NSDictionary dictionaryWithObjectsAndKeys:inputName,@"name", nil];
    [socketIO sendEvent:@"addme" withData:hello ];
}

- (IBAction)sendText:(id)sender {
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    socketIO = [[SocketIO alloc] initWithDelegate:self];
    resultString = [[NSMutableString alloc] initWithCapacity:10];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setInputTextField:nil];
    [self setResultTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
