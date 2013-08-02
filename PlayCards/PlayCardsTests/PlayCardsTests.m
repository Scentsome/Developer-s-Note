//
//  PlayCardsTests.m
//  PlayCardsTests
//
//  Created by chronoer on 13/7/31.
//  Copyright (c) 2013年 Zencher Co., Ltd. All rights reserved.
//

#import "PlayCardsTests.h"
#import "CardView.h"
@implementation PlayCardsTests{
    CardView * card;
}

- (void)setUp
{
    [super setUp];
    card = [CardView new];
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
//    STFail(@"Unit tests are not implemented yet in PlayCardsTests");
}


-(void) testSetFrontImage{
    UIImage * frontImage = [UIImage imageNamed:@"front0.png"];
    card.frontImage = frontImage;
    
    STAssertEqualObjects(frontImage, card.frontImage, @"Should be front0");
}
-(void) testBackImage{
    UIImage * backImage = [UIImage imageNamed:@"back.png"];
    card.backImage = backImage;
    
    STAssertEqualObjects(backImage, card.backImage, @"Should be back");
}
-(void) testShowFront{
    card.frontImage = [UIImage imageNamed:@"front0.png"];
    [card showFront];
    STAssertEqualObjects(card.image, card.frontImage, @"showing image should be front");
}

-(void) testShowBack{
    card.backImage = [UIImage imageNamed:@"back.png"];
    [card showBack];
    STAssertEqualObjects(card.image, card.backImage, @"showing image should be front");
}

-(void) testShowFrontWhenLock{
    card.frontImage = [UIImage imageNamed:@"front0.png"];
    card.backImage = [UIImage imageNamed:@"back.png"];
    [card showFront];
    [card lock];
    [card showBack];
    STAssertEqualObjects(card.image, card.frontImage, @"showing image should be front");
}
-(void) testChangeCardImage{
    card.frontImage = [UIImage imageNamed:@"front0"];
    UIImage * backImage = [UIImage imageNamed:@"back"];
    card.backImage = backImage;
    [card unlock];
    [card showFront];
    [card changeImage];
    
    
    STAssertEqualObjects(backImage, card.image, @"Should be back");
   
    
}

@end
