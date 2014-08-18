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
- (IBAction)SaveButtonClick:(UIBarButtonItem *)sender;

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
    //[defaults setObject:self.myMemo forKey:[NSString stringWithFormat:@"%@%d",@"MemoTestNo",self.TabelViewRow]];
    [defaults setInteger:delegate.MemoDataArray.count forKey:@"MemoDataArrayCount"];
    

    
    for(int i=0;i<delegate.MemoDataArray.count;i++){
        MemoData *memo = delegate.MemoDataArray[i];
        [defaults setObject:memo.MemoContent forKey:[NSString stringWithFormat:@"%@%d",@"MemoTestContentNo",i]];
        [defaults setObject:memo.Title forKey:[NSString stringWithFormat:@"%@%d",@"MemoTestTitleNo",i]];
        
    }
    
    [defaults synchronize];
    

}

-(void)LoadMemo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.myMemo = [defaults objectForKey:[NSString stringWithFormat:@"%@%d",@"MemoTestNo",self.TabelViewRow]];
    
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

- (IBAction)SaveButtonClick:(UIBarButtonItem *)sender {
    [self SaveMemo];
}
@end
