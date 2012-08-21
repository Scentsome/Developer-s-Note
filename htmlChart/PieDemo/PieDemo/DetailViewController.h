//
//  DetailViewController.h
//  PieDemo
//
//  Created by chronoer on 8/21/12.
//  Copyright (c) 2012 GLuck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
