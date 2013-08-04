//
//  ViewController.m
//  ShowMenu
//
//  Created by chronoer on 13/8/4.
//  Copyright (c) 2013年 Zencher Co., Ltd. All rights reserved.
//

#import "ViewController.h"
#import "ItemView.h"

#define MENURadius 100
@interface ViewController (){
    NSMutableArray * menu;
}
@property (weak, nonatomic) IBOutlet UITextField *inputField;

@end

@implementation ViewController
- (IBAction)showMenu:(UIButton *)sender {

    [self.inputField resignFirstResponder];
    [self createItemsWithNumber:[self.inputField.text integerValue]];
    CGPoint btCorner = CGPointMake(CGRectGetMinX(sender.frame), CGRectGetMinY(sender.frame)) ;
    CGFloat theta = 2*M_PI/[menu count];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(addItems:) userInfo:@{@"theta":@(theta), @"x":@(btCorner.x),@"y":@(btCorner.y), @"total":@([menu count])} repeats:YES];
    

}

-(void) addItems:(NSTimer *) timer{
    if ([menu count] < 1) {
        [timer invalidate];
    }else{
        NSInteger x = [timer.userInfo[@"x"] integerValue];
        NSInteger y = [timer.userInfo[@"y"] integerValue];
        CGFloat theta = [timer.userInfo[@"theta"] floatValue];
        NSInteger total = [timer.userInfo[@"total"] integerValue];
        NSInteger idx = total - [menu count];
        ItemView * item = [menu lastObject];
        item.frame = CGRectMake(x+10+ MENURadius*cos(theta*idx), y+MENURadius*sin(theta*idx), 50, 50);
        [self.view addSubview:item];
        [item scale];
        [menu removeLastObject];
    }
    
    
    
    
    
}
-(void) createItemsWithNumber:(int) count{
    CGRect frame = CGRectMake(0, 0, 50, 50);
    for (int index = 0 ; index<count; index++) {
        ItemView * item = [ItemView new];
        item.backgroundColor = [UIColor clearColor];
        item.frame = frame;
        [menu addObject:item];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    menu = [NSMutableArray array];
   
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)cleanItems:(id)sender {
    [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isMemberOfClass:[ItemView class]]) {
            [obj removeFromSuperview];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
