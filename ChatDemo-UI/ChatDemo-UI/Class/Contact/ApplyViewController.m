//
//  ApplyViewController.m
//  ChatDemo-UI
//
//  Created by dhcdht on 14-5-15.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import "ApplyViewController.h"

#import "DataManager.h"

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
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        button.layer.cornerRadius = 3.0;
        button.clipsToBounds = YES;
        [button setTitle:@"接受" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(acceptAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[[UIImage imageNamed:@"blueImage"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        button.tag = indexPath.row;
        cell.accessoryView = button;
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

#pragma mark - action

- (void)acceptAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.tag < [self.dataSource count]) {
        NSMutableDictionary *dic = [self.dataSource objectAtIndex:button.tag];
        EMError *error;
        [[EaseMob sharedInstance].chatManager acceptBuddyRequest:[dic objectForKey:@"username"] error:&error];
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

- (void)reloadDataSource
{
    self.dataSource = [[DataManager defaultManager] applyArray];
    [self.tableView reloadData];
}

@end
