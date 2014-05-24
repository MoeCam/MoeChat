//
//  ChatViewController.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-23.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatViewModel.h"
@interface ChatViewController (){
    ChatViewModel *_chatVCModel;
}

@end

@implementation ChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _chatVCModel = [[ChatViewModel alloc] initWithChatVC:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)refreshData{

}

- (void)addChatData:(NSObject *)chatdata{

}

- (void)addChatDatas:(NSArray *)chatdatas{

}
@end
