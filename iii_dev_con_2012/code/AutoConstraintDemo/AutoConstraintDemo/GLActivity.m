//
//  GLActivity.m
//  ActivityDemo
//
//  Created by chronoer on 10/2/12.
//  Copyright (c) 2012 chronoer. All rights reserved.
//

#import "GLActivity.h"
#import <Social/Social.h>
@interface GLActivity()
@property (strong, nonatomic) UIImage *customImage;
@property (strong, nonatomic) NSString *customText;
@property (strong, nonatomic) NSURL * customURL;

@end
@implementation GLActivity
- (UIImage *)activityImage {
    return [UIImage imageNamed:@"devNote.png" ];
}
- (NSString *)activityTitle {
    return @"Dev's Note";
}
- (NSString *)activityType {
    return @"com.gluck.activityDemo";
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    for (int i = 0; i < activityItems.count; i++) {
        id item = activityItems[i];
        if ([item class] != [UIImage class] && ![item isKindOfClass:[NSString class]] && [item class] != [NSURL class]){
            return NO;
        }
    }
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (int i = 0; i < activityItems.count; i++) {
        id item = activityItems[i];
        if ([item class] == [UIImage class]) {
            self.customImage = item;
        }
        else if ([item isKindOfClass:[NSString class]]) {
            self.customText = item;
        }
        else if ([item isKindOfClass:[NSURL class]]) {
            self.customURL = item;
        }
    }
}

- (void)performActivity {
    NSLog(@"input text is %@", self.customText);
    NSLog(@"input image is %@", self.customImage);
    NSLog(@"input image is %@", self.customURL);
    
}
@end
