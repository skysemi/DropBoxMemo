//
//  DropBoxMemoAppDelegate.m
//  DropBoxMemo
//
//  Created by おかやん on 2014/08/04.
//  Copyright (c) 2014年 ナノソフトウェア. All rights reserved.
//

#import "DropBoxMemoAppDelegate.h"
#import <DropboxSDK/DropboxSDK.h>

#import "MemoData.h"

@implementation DropBoxMemoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  /*   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int count =(int)[defaults integerForKey:@"MemoDataArrayCount"];
    
    for(int i=0;i<count;i++){
        MemoData *memo;
        memo.MemoContent = [defaults stringForKey:[NSString stringWithFormat:@"%@%d",@"MemoTestContentNo",i]];
        memo.Title       = [defaults stringForKey:[NSString stringWithFormat:@"%@%d",@"MemoTestTitleNo",i]];
        [self.MemoDataArray addObject:memo];
        
    }*/
    [self LoadUserDefault];
	
    
    
    
    
    DBSession* dbSession =
    [[DBSession alloc]
     initWithAppKey:@"xxxxxx"
     appSecret:@"xxxxxx"
     root:kDBRootDropbox]; // either kDBRootAppFolder or kDBRootDropbox
    [DBSession setSharedSession:dbSession];
	
    return YES;
    
    
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

    
}

-(void)SaveToUserDefault
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.MemoDataArray.count forKey:@"MemoDataArrayCount"];
    
    for(int i=0;i<self.MemoDataArray.count;i++){
        MemoData *memo = [self.MemoDataArray objectAtIndex:i];
        
        [defaults setObject:memo.MemoContent forKey:[NSString stringWithFormat:@"%@%d",@"MemoTestContentNo",i]];
        [defaults setObject:memo.Title forKey:[NSString stringWithFormat:@"%@%d",@"MemoTestTitleNo",i]];
        
    }
    [defaults synchronize];
    
}

-(void)LoadUserDefault
{
    if(self.MemoDataArray == nil){
        self.MemoDataArray = [[NSMutableArray alloc] init];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int MemoDataArrayCount = [defaults integerForKey:@"MemoDataArrayCount"];
    
    for(int i=0;i<MemoDataArrayCount;i++){
        MemoData *memo = [[MemoData alloc] init];
        memo.MemoContent = [defaults stringForKey:[NSString stringWithFormat:@"%@%d",@"MemoTestContentNo",i]];
        memo.Title       = [defaults stringForKey:[NSString stringWithFormat:@"%@%d",@"MemoTestTitleNo",i]];
        [self.MemoDataArray addObject:memo];
    }
}



@end
