//
//  DropBoxMemoViewController.m
//  DropBoxMemo
//
//  Created by おかやん on 2014/08/04.
//  Copyright (c) 2014年 ナノソフトウェア. All rights reserved.
//

#import "DropBoxMemoViewController.h"

@interface DropBoxMemoViewController ()
@property (weak, nonatomic) IBOutlet UITextView *myMemo;

@end

@implementation DropBoxMemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self LoadMemo];
    
    
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(SaveMemo) userInfo:nil repeats:YES];
}

-(void)SaveMemo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.myMemo.text forKey:@"MemoString"];

}

-(void)LoadMemo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.myMemo.text = [defaults objectForKey:@"MemoString"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
