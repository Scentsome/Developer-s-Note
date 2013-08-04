//
//  ItemView.m
//  ShowMenu
//
//  Created by chronoer on 13/8/4.
//  Copyright (c) 2013年 Zencher Co., Ltd. All rights reserved.
//

#import "ItemView.h"

@implementation ItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor blueColor] set];
    CGRect smallerRect = CGRectMake(rect.origin.x+5, rect.origin.y+5, rect.size.width-10, rect.size.height-10);
    CGContextAddEllipseInRect(context, smallerRect);
    CGContextDrawPath(context, kCGPathFillStroke);
}
-(void) scale{
    CGRect originBounds = self.bounds;
    CGRect smallBounds = CGRectMake(self.bounds.origin.x,self.bounds.origin.y,CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
    [UIView animateWithDuration:0.2 animations:^{
        self.bounds = smallBounds;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.bounds = originBounds;
        }];
    }];
    
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self scale];
}

@end
