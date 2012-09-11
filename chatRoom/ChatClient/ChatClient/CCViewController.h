//
//  CCViewController.h
//  ChatClient
//
//  Created by chronoer on 9/11/12.
//  Copyright (c) 2012 GLuck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketIO.h"

@interface CCViewController : UIViewController<SocketIODelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;

@end
