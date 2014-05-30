//
//  ApplyViewController.m
//  ChatDemo-UI
//
//  Created by dhcdht on 14-5-15.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import "ApplyViewController.h"

@interface ApplyViewController ()

@end

@implementation ApplyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.title = @"好友申请";
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
    // Return the number of rows in the section.
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UILabel *addLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        addLabel.clipsToBounds = YES;
        addLabel.backgroundColor = [UIColor colorWithRed:14 / 255.0 green:115 / 255.0 blue:213 / 255.0 alpha:1.0];
        addLabel.textAlignment = NSTextAlignmentCenter;
        addLabel.text = @"接受";
        addLabel.textColor = [UIColor whiteColor];
        addLabel.font = [UIFont systemFontOfSize:13.0];
        addLabel.layer.cornerRadius = 3.0;
        cell.accessoryView = addLabel;
    }
    
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    if (dic) {
        cell.textLabel.text = [dic objectForKey:@"username"];
        cell.accessoryView.hidden = [[dic objectForKey:@"acceptState"] boolValue];
    }
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self acceptAtIndexPath:indexPath];
}

#pragma mark - action

- (void)acceptAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.dataSource count]) {
        [self showHudInView:self.view hint:@"正在发送申请..."];
        NSMutableDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
        EMError *error;
        [[EaseMob sharedInstance].chatManager acceptBuddyRequest:[dic objectForKey:@"username"] error:&error];
        [self hideHud];
        if (!error) {
            [dic setObject:@YES forKey:@"acceptState"];
            [self.tableView reloadData];
            [self showHint:@"添加好友成功"];
        }
        else{
            [self showHint:@"添加好友失败"];
        }
    }
}

#pragma mark - data

@end
