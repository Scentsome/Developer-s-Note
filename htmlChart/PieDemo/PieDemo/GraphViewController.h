//
//  GraphViewController.h
//  MyFinance
//
//  Created by chronoer on 8/10/12.
//  Copyright (c) 2012 GLuck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong) NSMutableDictionary * sums;
@end
