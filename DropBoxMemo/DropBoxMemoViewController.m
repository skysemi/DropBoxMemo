//
//  DropBoxMemoViewController.m
//  DropBoxMemo
//
//  Created by おかやん on 2014/08/04.
//  Copyright (c) 2014年 ナノソフトウェア. All rights reserved.
//

#import "DropBoxMemoViewController.h"
#import <DropboxSDK/DropboxSDK.h>


#import "DropBoxMemoAppDelegate.h"
#import "MemoData.h"

@interface DropBoxMemoViewController (){
    DropBoxMemoAppDelegate *delegate;
}
@property (weak, nonatomic) IBOutlet UITextView *myMemo;
- (IBAction)ReturnButton:(UIBarButtonItem *)sender;

@end

@implementation DropBoxMemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    delegate= (DropBoxMemoAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self LoadFromMemoDataArray];

    
    
    
    
    [self LoadMemo];
    
    
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(SaveMemo) userInfo:nil repeats:YES];
}

-(void)LoadFromMemoDataArray
{
    MemoData *TargetMemoData = [delegate.MemoDataArray objectAtIndex:self.TabelViewRow];
    
    self.myMemo.text = TargetMemoData.MemoContent;
    
    
}

-(void)SaveToMemoDataArray
{
    
    MemoData *TargetMemoData = [delegate.MemoDataArray objectAtIndex:self.TabelViewRow];
    TargetMemoData.MemoContent = self.myMemo.text;
    
}


-(void)SaveMemo
{
    [self  SaveToMemoDataArray];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.myMemo.text forKey:@"MemoString"];

}

-(void)LoadMemo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.myMemo.text = [defaults objectForKey:@"MemoString"];
    
}

- (DBRestClient *)restClient
{
    if (_restClient == nil) {
        if ( [[DBSession sharedSession].userIds count] ) {
            _restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
            _restClient.delegate = self;
        }
    }
	
    return _restClient;
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ReturnButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
