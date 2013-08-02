//
//  ViewController.h
//  PlayCards
//
//  Created by chronoer on 13/7/31.
//  Copyright (c) 2013年 Zencher Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"
@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(CardView) NSArray *cards;

@end
