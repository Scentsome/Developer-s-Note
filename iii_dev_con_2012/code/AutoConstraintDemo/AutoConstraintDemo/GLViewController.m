//
//  GLViewController.m
//  AutoContraintDemo
//
//  Created by chronoer on 9/23/12.
//  Copyright (c) 2012 chronoer. All rights reserved.
//

#import "GLViewController.h"
#import <Social/Social.h>
#import "GLActivity.h"
@interface UIWindow (AutoLayoutDebug)
+ (UIWindow *)keyWindow;
- (NSString *)_autolayoutTrace;
@end

@interface GLViewController (){
    UIButton *button1;
}

@end

@implementation GLViewController

- (void)handyWriting
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0];
    [self.view addConstraint:constraint];
    
    
    constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f
                                               constant:-20.0f];
    [self.view addConstraint:constraint];
    
    
    
    constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f
                                               constant:300.0f];
    constraint.priority = 999;
    [button1 addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f
                                               constant:60.0f];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f
                                               constant:-60.0f];
    [self.view addConstraint:constraint];
}
-(void) virtualForm{
    NSDictionary * bindingDict = NSDictionaryOfVariableBindings(button1);
    NSArray * constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-(60)-[button1(200)]-(60)-|" options:0 metrics:nil views:bindingDict];
    
    [self.view addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[button1]-(20)-|" options:0 metrics:nil views:bindingDict];
    
    [self.view addConstraints:constraints];
    
}

-(void) finalVirtual{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0];
    [self.view addConstraint:constraint];
    NSDictionary * bindingDict = NSDictionaryOfVariableBindings(button1);
    NSArray * constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-(>=60)-[button1(300@999)]-(>=60)-|" options:0 metrics:nil views:bindingDict];
    
    [self.view addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[button1]-(20)-|" options:0 metrics:nil views:bindingDict];
    
    [self.view addConstraints:constraints];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 setTitle:@"Button 1" forState:UIControlStateNormal];
    [button1 sizeToFit];
    button1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button1];
    
    
    NSLog(@"UIButton is %@", button1);
    [button1 addTarget:button1 action:@selector(exerciseAmbiguityInLayout)
      forControlEvents:UIControlEventTouchUpInside];
    
    //    [self handyWriting];
    //    [self virtualForm];
    [self finalVirtual];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewWillLayoutSubviews{
    NSLog(@"view will auto layout");
}
-(BOOL) shouldAutorotate{
    return YES;
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%@", [[UIWindow keyWindow] _autolayoutTrace]);
}
- (void)didRotateFromInterfaceOrientation: (UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:
     fromInterfaceOrientation];
    NSLog(@"%@", [[UIWindow keyWindow] _autolayoutTrace]);
}
- (IBAction)sayHello:(id)sender {
    
//    
//    SLComposeViewController * composer = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook] ;
//    [composer setInitialText:@"This Page is Great!!"];
//    [composer addImage:[UIImage imageNamed:@"pageIcon.png"]];
//    [composer addURL:[NSURL URLWithString:@"http://www.facebook.com/pages/Developers-note/226724001803"]];
    
    GLActivity * myActivity = [GLActivity new];
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[@"This Page is Great!!",[UIImage imageNamed:@"pageIcon.png"], [NSURL URLWithString:@"http://www.facebook.com/pages/Developers-note/226724001803"]] applicationActivities:@[myActivity]];
    [self presentViewController:activityViewController animated:YES completion:nil];
//    [self presentViewController:composer animated:YES completion:nil];
}

-(IBAction) dismissCon:(UIStoryboardSegue *) segue{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
