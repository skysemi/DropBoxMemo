//
//  DropBoxMemoViewController.h
//  DropBoxMemo
//
//  Created by おかやん on 2014/08/04.
//  Copyright (c) 2014年 ナノソフトウェア. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>


#import "MemoData.h"

@interface DropBoxMemoViewController : UIViewController<DBRestClientDelegate>

@property (strong, nonatomic) DBRestClient* restClient;


@property (strong,nonatomic) MemoData *PushMemoData;
@property (nonatomic)int TabelViewRow;

@end
