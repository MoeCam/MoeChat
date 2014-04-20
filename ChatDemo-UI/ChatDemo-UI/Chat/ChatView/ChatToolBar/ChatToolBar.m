//
//  ChatToolBar.m
//  TestKeyBoard
//
//  Created by dujiepeng on 14-2-14.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import "ChatToolBar.h"

@interface ChatToolBar () <UITextViewDelegate,HPGrowingTextViewDelegate>{
    UIView *_shareMoreView;
    UIView *_emojiView;
    UIView *_recordView;
    UITableView *_showTableView;
    UIButton *_textFieldButton;
    NSString *_saveMessage;
}


@property (weak, nonatomic) IBOutlet UIImageView *inputBarBgImage;
@property (weak, nonatomic) IBOutlet UIButton *shareMoreButton;
@property (weak, nonatomic) IBOutlet UIButton *faceButton;
@property (weak, nonatomic) IBOutlet UIButton *speakerButton;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIButton *otherButton;


- (IBAction)shareMoreButtonPressed:(UIButton *)sender;
- (IBAction)faceButtonPressed:(id)sender;
- (IBAction)speakerButtonPressed:(id)sender;
- (IBAction)otherButtonPressed:(id)sender;

-(IBAction)recordButtonTouchDown:(UIButton *)sender;
-(IBAction)recordButtonTouchUpInside:(UIButton *)sender;
-(IBAction)recordButtonTouchUpOutside:(UIButton *)sender;
-(IBAction)recordButtonDragInside:(UIButton *)sender;
-(IBAction)recordButtonDragOutside:(UIButton *)sender;

-(void)registerNotifications;
-(void)unregisterNotifications;

@end

@implementation ChatToolBar


-(id)initWithViewController:(UIViewController <ChatToolBarDelegate> *)viewController {
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatToolBar" owner:self options:nil];
    self = [nib objectAtIndex:0];
    if (self) {
        // 得到对应要显示的元素
        _subViewController = viewController;
        _shareMoreView = [_subViewController shareMoreView];
        _emojiView = [_subViewController emojiActionView];
        _showTableView = [_subViewController showTableView];
        _recordView = [_subViewController recordView];
        
        // 调整位置到最下
        CGRect frame = self.frame;
        self.frame = CGRectMake(self.frame.origin.x,
                                _subViewController.view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
        frame.origin.y = _subViewController.view.frame.size.height - self.frame.size.height;
        self.frame = frame;
        [_subViewController.view addSubview:self];
        
        self.textView.delegate = self;
        _textFieldButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_textFieldButton setFrame:self.textView.frame];
        [_textFieldButton addTarget:self action:@selector(textFieldButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_textFieldButton];
        [_textFieldButton setHidden:YES];
        
        _textView.isScrollable = NO;
        _textView.contentInset = UIEdgeInsetsMake(0, 3, 0, 3);
        
        _textView.minNumberOfLines = 1;
        _textView.maxNumberOfLines = 5;
        _textView.returnKeyType = UIReturnKeySend;
        _textView.font = [UIFont systemFontOfSize:15.0f];
        _textView.delegate = self;
        _textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(3, 0, 3, 0);
        _textView.backgroundColor = [UIColor whiteColor];
        [_textView.layer setCornerRadius:6.0];
        [_textView.layer setMasksToBounds:YES];
        [_textView.layer setBorderWidth:0.5];
        [_textView.layer setBorderColor:[UIColor
                                         colorWithRed:.2
                                         green:.6
                                         blue:1.0
                                         alpha:1].CGColor];
        
        
        _recordButton.frame = self.textView.frame;
        
        [_recordButton setTitleColor:[UIColor colorWithRed:.2
                                                     green:.6
                                                      blue:1.0
                                                     alpha:1]
                            forState:UIControlStateNormal];
        
        [_recordButton.layer setCornerRadius:6.0];
        [_recordButton.layer setMasksToBounds:YES];
        [_recordButton.layer setBorderWidth:0.5];
        [_recordButton.layer setBorderColor:[UIColor
                                             colorWithRed:.2
                                             green:.6
                                             blue:1.0
                                             alpha:1].CGColor];
        
        [_recordButton setHidden:YES];
        
        if (_recordView) {
            [_subViewController.view addSubview:_recordView];
            [_recordView setHidden:YES];
        }
        
        [self registerNotifications];
    }
    return self;
}

- (IBAction)shareMoreButtonPressed:(UIButton *)sender {
    
    if (_subViewController && [_subViewController
                               respondsToSelector:@selector(shareMoreButtonPressed)]) {
        [_subViewController shareMoreButtonPressed];
    }
    [self.recordButton setHidden:YES];
    [self decideInputView:_shareMoreView];
}

- (IBAction)faceButtonPressed:(UIButton *)sender {
    if (_subViewController && [_subViewController
                               respondsToSelector:@selector(faceButtonPressed)]) {
        [_subViewController faceButtonPressed];
    }
    [self.recordButton setHidden:YES];
    [self decideInputView:_emojiView];
}

// 此处为扬声器小喇叭
- (IBAction)speakerButtonPressed:(UIButton *)sender{
    if (_subViewController && [_subViewController
                               respondsToSelector:@selector(speakerButtonPressed)]) {
        [_subViewController speakerButtonPressed];
    }
    [_textFieldButton setHidden:YES];
    if (self.recordButton.hidden) {
        [self.recordButton setHidden:NO];
        _saveMessage = _textView.text;
        _textView.text = @"";
        [_textView resignFirstResponder];
    }else {
        [self.recordButton setHidden:YES];
        _textView.text = _saveMessage;
        [_textView becomeFirstResponder];
    }
}


- (IBAction)otherButtonPressed:(UIButton *)sender{
    if (_subViewController && [_subViewController
                               respondsToSelector:@selector(otherButtonPressed)]) {
        [_subViewController otherButtonPressed];
    }
}


// 用于点击textField内部时调用
-(void)textFieldButtonPressed:(UIButton *)sender{
    [_textFieldButton setHidden:YES];
    [self.textView.internalTextView setInputView:nil];
    [self.textView.internalTextView reloadInputViews];
    [self.textView.internalTextView becomeFirstResponder];
}

-(IBAction)recordButtonTouchDown:(UIButton *)sender{
    [self recordButtonPressed];
    if (_subViewController && [_subViewController
                               respondsToSelector:@selector(recordButtonTouchDown:)]) {
        [_subViewController recordButtonTouchDown:_recordView];
    }
    if (_recordView) {
        [_recordView setHidden:NO];
    }
}

-(IBAction)recordButtonTouchUpInside:(UIButton *)sender{
    [self recordButtonUp];
    if (_subViewController && [_subViewController
                               respondsToSelector:@selector(recordButtonTouchUpInside:)]) {
        [_subViewController recordButtonTouchUpInside:_recordView];
    }
    if (_recordView) {
        [_recordView setHidden:YES];
    }
}

-(IBAction)recordButtonTouchUpOutside:(UIButton *)sender{
    [self recordButtonUp];
    if (_subViewController && [_subViewController
                               respondsToSelector:@selector(recordButtonTouchUpOutside:)]) {
        [_subViewController recordButtonTouchUpOutside:_recordView];
    }
    if (_recordView) {
        [_recordView setHidden:YES];
    }
}

-(IBAction)recordButtonDragInside:(UIButton *)sender{
    [self recordButtonPressed];
    if (_subViewController && [_subViewController
                               respondsToSelector:@selector(recordButtonDragInside:)]) {
        [_subViewController recordButtonDragInside:_recordView];
    }
}

-(IBAction)recordButtonDragOutside:(UIButton *)sender{
    [self recordButtonUp];
    if (_subViewController && [_subViewController
                               respondsToSelector:@selector(recordButtonDragOutside:)]) {
        [_subViewController recordButtonDragOutside:_recordView];
    }
}

-(void)recordButtonPressed{
    [_recordButton setBackgroundColor:[UIColor colorWithRed:.2 green:.6 blue:1.0 alpha:1]];
    [_recordButton setTitle:@"松开发送" forState:UIControlStateNormal];
    [_recordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)recordButtonUp{
    [_recordButton setBackgroundColor:[UIColor whiteColor]];
    [_recordButton setTitle:@"按住说话" forState:UIControlStateNormal];
    [_recordButton setTitleColor:[UIColor colorWithRed:.2 green:.6 blue:1.0 alpha:1]
                        forState:UIControlStateNormal];
}

-(void)decideInputView:(UIView *)usedView{
    if (self.textView.internalTextView.inputView == usedView) {
        [_textFieldButton setHidden:YES];
        self.textView.internalTextView.inputView = nil;
    }else if (self.textView.internalTextView.inputView == nil){
        [_textFieldButton setHidden:NO];
        self.textView.internalTextView.inputView = usedView;
    }else if (self.textView.internalTextView.inputView == _shareMoreView){
        [_textFieldButton setHidden:NO];
        self.textView.internalTextView.inputView = _emojiView;
    }else{
        [_textFieldButton setHidden:NO];
        self.textView.internalTextView.inputView = _shareMoreView;
    }
    _textFieldButton.frame = _textView.frame;
    [self.textView.internalTextView reloadInputViews];
    [self.textView.internalTextView becomeFirstResponder];
}


-(void)showTableOffSetChangeByInputViewChange:(CGFloat)height{
    // 根据是否遮挡，以及遮挡多少来判断tableOffset移动多少
    if (_showTableView) {
        CGFloat keyBoardHegiht = CGRectGetHeight( _subViewController.view.frame) - self.frame.origin.y;
        CGFloat tableHeight = CGRectGetHeight(_showTableView.frame);
        CGFloat tableContentHeight = _showTableView.contentSize.height;
        if (tableContentHeight > tableHeight) {
            _showTableView.contentOffset = CGPointMake(0, _showTableView.contentOffset.y - height);
        }else if (tableHeight > tableContentHeight && tableHeight - tableContentHeight < keyBoardHegiht){
            CGFloat mostHeight = keyBoardHegiht + tableContentHeight - tableHeight;
            if (mostHeight > height) {
                _showTableView.contentOffset = CGPointMake(0, _showTableView.contentOffset.y - height);
            }
        }
    }
    
}

#pragma mark - HPGrowingTextViewDelegate;
- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
	CGRect r = self.frame;
    r.size.height -= diff;
    r.origin.y += diff;
	self.frame = r;
    [self showTableOffSetChangeByInputViewChange:diff];
}

- (BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView{
    if ([_subViewController respondsToSelector:@selector(chatBarTextShouldReturn)]) {
        [_subViewController chatBarTextShouldReturn];
    }
    _textView.text = @"";
    return YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)keyboardWillShow:(NSNotification *)aNotification
{
    NSValue *animationDurationValue = [aNotification.userInfo
                                       objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    //获取到键盘frame变化之后的frame
    NSValue *keyboardEndBounds = [[aNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect endRect = [keyboardEndBounds CGRectValue];
    
    CGFloat keyBoardHeight = CGRectGetHeight(endRect) + CGRectGetHeight(self.frame) - 44;
    
    // 得到变化时间
    CGFloat duration = [[[aNotification userInfo]
                         objectForKey:UIKeyboardAnimationDurationUserInfoKey]
                        floatValue];
    if (duration <= 0) {
        // 是否加额外动画时间补偿
    }
    
	[UIView animateWithDuration:duration animations:^(){
        // bar位置变换
        CGRect frame = self.frame;
        frame.origin.y = CGRectGetHeight(_subViewController.view.frame) - CGRectGetHeight(endRect) - CGRectGetHeight(self.frame);
        self.frame = frame;
        
        if (_showTableView) {
            UIEdgeInsets contentInsets;
            CGFloat tableHeight = CGRectGetHeight(_showTableView.frame);
            CGFloat tableContentHeight = _showTableView.contentSize.height;
            
            // 1. 全部遮挡 contentSize.height > tableView的高度
            if (tableContentHeight > tableHeight) {
                _showTableView.contentOffset = CGPointMake(0, _showTableView.contentOffset.y + keyBoardHeight);
                // 2. 部分遮挡  0 < tableHeight - contentHeight < 键盘的高度
            }else if(tableHeight > tableContentHeight &&
                     tableHeight - tableContentHeight < keyBoardHeight){
                // 计算需要移动的距离
                CGFloat changeHeight = tableContentHeight + keyBoardHeight - tableHeight;
                _showTableView.contentOffset = CGPointMake(0,  _showTableView.contentOffset.y + changeHeight);
            }
            contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyBoardHeight, 0.0);
            _showTableView.contentInset = contentInsets;
            _showTableView.scrollIndicatorInsets = contentInsets;
        }
    } completion:^(BOOL finish){
        
    }];
}

-(void)keyboardWillHide:(NSNotification *)aNotification{
    
    CGFloat duration = [[[aNotification userInfo]
                         objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //获取到键盘frame变化之后的frame
    NSValue *keyboardEndBounds = [[aNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect endRect = [keyboardEndBounds CGRectValue];
    
    CGFloat keyBoardHeight = CGRectGetHeight(self.frame) + CGRectGetHeight(endRect) - 44;
    
   	[UIView animateWithDuration:duration animations:^(){
        CGRect frame = self.frame;
        frame.origin.y = CGRectGetHeight( _subViewController.view.frame) - frame.size.height;
        self.frame = frame;
        
        if (_showTableView) {
            CGFloat tableHeight = CGRectGetHeight(_showTableView.frame);
            CGFloat tableContentHeight = _showTableView.contentSize.height;
            
            // 1.完全遮挡 contentHeight > tableHeight
            if (tableContentHeight > tableHeight) {
                // 判断是否需要移动table
                if (_showTableView.contentOffset.y >= keyBoardHeight) {
                    _showTableView.contentOffset = CGPointMake(0, _showTableView.contentOffset.y - keyBoardHeight);
                }
                // 2.部分遮挡 tableHeight > contentHeight && tableHeight - contentHeight > keyBoardHeight
            }else if (tableHeight > tableContentHeight && tableHeight - tableContentHeight < keyBoardHeight){
                // 计算需要移动的距离
                CGFloat changeHeight = tableContentHeight + keyBoardHeight - tableHeight;
                _showTableView.contentOffset = CGPointMake(0, _showTableView.contentOffset.y - changeHeight);
            }
            _showTableView.contentInset = UIEdgeInsetsZero;
            _showTableView.scrollIndicatorInsets = UIEdgeInsetsZero;
        }
    } completion:^(BOOL finish){
        
    }];
}

// textView变化引起的tableView的变化
-(void)setTableViewByTextViewChangeHeight:(CGFloat)height{
    if (height == 0) {
        return;
    }
    if (_showTableView) {
        // 动画之前，先判断 是否要移动该table
        CGFloat keyBoardHeight = CGRectGetHeight(_showTableView.frame) - self.frame.origin.y;
        if (keyBoardHeight + _showTableView.contentSize.height > CGRectGetHeight(_showTableView.frame)) {
            [UIView animateWithDuration:0 animations:^(){
                _showTableView.contentOffset = CGPointMake(0, _showTableView.contentOffset.y + height);
                UIEdgeInsets contentInset = UIEdgeInsetsMake(0.0, 0.0, _showTableView.contentInset.bottom + height, 0.0);;
                _showTableView.contentInset = contentInset;
                _showTableView.scrollIndicatorInsets = contentInset;
                
            } completion:^(BOOL finish){
                
            }];
        }
    }
}

-(void)dealloc {
    NSLog(@"chatToolBar dealloc");
    [self unregisterNotifications];
}

-(void)registerNotifications{
    [self unregisterNotifications];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillShow:)
                                                name:UIKeyboardWillShowNotification
                                              object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)unregisterNotifications{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIKeyboardWillShowNotification
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIKeyboardWillHideNotification
                                                 object:nil];
}

@end
