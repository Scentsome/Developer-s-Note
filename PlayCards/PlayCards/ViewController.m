//
//  ViewController.m
//  PlayCards
//
//  Created by chronoer on 13/7/31.
//  Copyright (c) 2013年 Zencher Co., Ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)prepareImages
{
    [self.cards makeObjectsPerformSelector:@selector(setBackImage:) withObject:[UIImage imageNamed:@"back"] ];
    
    [self.cards enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CardView * cardImage = obj;
        cardImage.frontImage = [UIImage imageNamed:[NSString stringWithFormat:@"front%d.png",idx]];
    }];
    [self.cards makeObjectsPerformSelector:@selector(showBack) ];
}
-(void) testShowFront{
    CardView * card = [CardView new];
    card.frontImage = [UIImage imageNamed:@"front0.png"];
    [card showFront];
    if( ![card.frontImage isEqual:card.image]){
        NSLog(@"show front not works");
    }
}
-(void) testShowFrontWhenLock{
    CardView * card = [CardView new];
    card.frontImage = [UIImage imageNamed:@"front0.png"];
    card.backImage = [UIImage imageNamed:@"back.png"];
    [card showFront];
    [card lock];
    [card showBack];
    if( ![card.frontImage isEqual:card.image]){
        NSLog(@"lock not works");
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self testShowFront];
    [self testShowFrontWhenLock];
//    NSLog(@"%@", self.cards);
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) viewWillAppear:(BOOL)animated{
    
}

-(void) viewDidAppear:(BOOL)animated{
//    NSLog(@"origin array %@",self.cards);
    [super viewDidAppear:animated];
    self.cards = [self.cards sortedArrayUsingComparator:^NSComparisonResult(id view1, id view2) {
        if ([view1 frame].origin.y < [view2 frame].origin.y) return NSOrderedAscending;
        else if ([view1 frame].origin.y > [view2 frame].origin.y) return NSOrderedDescending;
        else{
            if ([view1 frame].origin.x < [view2 frame].origin.x) {
                return NSOrderedAscending;
            }
            else if([view1 frame].origin.x > [view2 frame].origin.x){
                return NSOrderedDescending;
            }
            return NSOrderedSame;
        }
        
    }];
    [self prepareImages];

}
- (IBAction)changeImages:(id)sender {
    [self.cards makeObjectsPerformSelector:@selector(changeImage)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)lockSome:(UISegmentedControl *)sender {
    NSInteger lockedIndex = sender.selectedSegmentIndex;
    
    CardView * cardView = self.cards[lockedIndex];
    [cardView lock];
}
- (IBAction)unlockAll:(id)sender {
    [self.cards makeObjectsPerformSelector:@selector(unlock)];
}

@end
