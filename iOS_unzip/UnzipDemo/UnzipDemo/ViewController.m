//
//  ViewController.m
//  UnzipDemo
//
//  Created by chronoer on 8/29/12.
//  Copyright (c) 2012 GLuck. All rights reserved.
//

#import "ViewController.h"
#import "ZipArchive.h"

#define SERVER @"http://127.0.0.1:8800/data"
@interface ViewController (){
    NSString * fileName;
    
}
@property (strong) NSMutableData * tmpData;
@end

@implementation ViewController
@synthesize tmpData;
- (IBAction)downZip:(id)sender {
    fileName = @"developer.zip";
    NSURL * fileURL = [NSURL URLWithString:[SERVER stringByAppendingFormat:@"?fileName=%@", fileName]];
    
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:fileURL];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.tmpData appendData:data];
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString * filePath = [[self fakeDoc] stringByAppendingFormat:@"/%@", fileName];
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:self.tmpData attributes:nil];
    [self unzipFile:filePath];
}
-(NSString *) fakeDoc{
    return @"/Users/chronoer/developer";
}

-(void) unzipFile:(NSString * ) zipFilePath{
    ZipArchive *zipArchive = [[ZipArchive alloc] init];
    [zipArchive UnzipOpenFile:zipFilePath ];
    [zipArchive UnzipFileTo:[self fakeDoc] overWrite:YES];
    [zipArchive UnzipCloseFile];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tmpData = [NSMutableData data];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
