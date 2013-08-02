//
//  CardView.h
//  PlayCards
//
//  Created by chronoer on 13/7/31.
//  Copyright (c) 2013年 Zencher Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIImageView

@property UIImage * frontImage;
@property UIImage * backImage;
-(void) changeImage;
-(void) showFront;
-(void) showBack;
-(void) lock;
-(void) unlock;
@end
