//
//  ViewController.m
//  NonARCTesting
//
//  Created by chronoer on 12/12/2.
//  Copyright (c) 2012年 DevelopersNote. All rights reserved.
//

#import "ViewController.h"
#import "Car.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)testCar:(id)sender {
    Car * car = [Car new];
    NSLog(@"Car name %@", [car newName]);
    NSLog(@"Car name %@", [car newname]);
}

@end
