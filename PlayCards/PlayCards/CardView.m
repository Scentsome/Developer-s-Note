//
//  CardView.m
//  PlayCards
//
//  Created by chronoer on 13/7/31.
//  Copyright (c) 2013年 Zencher Co., Ltd. All rights reserved.
//

#import "CardView.h"
#import <QuartzCore/QuartzCore.h>

@interface CardView()
@property BOOL isLocked;
@property BOOL isFront;
@end
@implementation CardView



-(void) changeImage{
    if (self.isLocked) {
        return;
    }
    if (self.isFront) {
        [self showBack];
    }else{
        [self showFront];
    }
    
}
-(void) showFront{
    if (self.isLocked) {
        return;
    }
    self.image = self.frontImage;
    self.isFront = YES;
}
-(void) showBack{
    if (self.isLocked) {
        return;
    }
    self.image = self.backImage;
    self.isFront = NO;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)lock {
    self.isLocked = YES;
    self.layer.borderColor = [[UIColor blueColor]CGColor];
    self.layer.borderWidth = 5.0;
    
}



- (void)unlock {
    self.isLocked = NO;
    self.layer.borderColor = [[UIColor blackColor]CGColor];
    self.layer.borderWidth = 1.0;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    if (self.isLocked) {
        [self unlock];
    }else{
        [self lock];
    }
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
