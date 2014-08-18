//
//  DropBoxMemoTableViewController.m
//  DropBoxMemo
//
//  Created by おかやん on 2014/08/04.
//  Copyright (c) 2014年 ナノソフトウェア. All rights reserved.
//

#import "DropBoxMemoTableViewController.h"

//ユーザーインポート
#import "DropBoxMemoViewController.h"
#import "DropBoxMemoAppDelegate.h"
#import "MemoData.h"

@interface DropBoxMemoTableViewController (){
//MemoData *TargerMemo ;
    int TargetRow;
}
    
@end

@implementation DropBoxMemoTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    DropBoxMemoAppDelegate *delegate = (DropBoxMemoAppDelegate *)[[UIApplication sharedApplication] delegate];
    DropBoxMemoAppDelegate *delegate = (DropBoxMemoAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DropBoxMemoAppDelegate *delegate = (DropBoxMemoAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    // Return the number of rows in the section.
    return delegate.MemoDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemoCell" forIndexPath:indexPath ];
	
//	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemoCell"];
    
    DropBoxMemoAppDelegate *delegate = (DropBoxMemoAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    MemoData *memo = delegate.MemoDataArray[indexPath.row];
    cell.textLabel.text = memo.Title;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // DropBoxMemoAppDelegate *delegate = (DropBoxMemoAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    // Return the number of rows in the section.
    TargetRow = indexPath.row;
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"toMemoSegue"]){
        DropBoxMemoViewController *vc = (DropBoxMemoViewController*)[[segue destinationViewController] topViewController];
        // 移行先の ViewController に画像名を渡す
    vc.TabelViewRow = TargetRow;
       // [(DropBoxMemoViewController*)[segue destinationViewController] ].TabelViewRow = TargetRow;
        
    }
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)AddMemo:(UIBarButtonItem *)sender
{
    
    
    //[UIAlertViewStyleSecureTextInput
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"メモのタイトル" message:@"メモのタイトルを入力してください" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.delegate = self;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
  
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //calcel:作られない
    //OKの場合で文字が入力された　：
    //
    
    DropBoxMemoAppDelegate *delegate = (DropBoxMemoAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    MemoData *addmemo = [[MemoData alloc] init];
    
    if( buttonIndex == alertView.cancelButtonIndex ) { return; }
    
    NSString* textValue = [[alertView textFieldAtIndex:0] text];
    if( [textValue length] > 0 )
    {
        addmemo.Title = textValue;
        
    }else{
        addmemo.Title = @"無題";
    }
//    [delegate.MemoDataArray addObject:addmemo];
	if(delegate.MemoDataArray == nil){
		delegate.MemoDataArray = [[NSMutableArray alloc] init];
	}
	[delegate.MemoDataArray insertObject:addmemo atIndex:0];
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    //ここから次回続き
    
    /*else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"文字を入れてください" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        alert.delegate = self;
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
    }*/

}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
	return YES;
}
@end
