//
//  AlarmViewController.m
//  TimingAlarm
//
//  Created by Mac on 2018/8/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "AlarmViewController.h"
#import "AlarmAlterView.h"
#import "SleepCycleView.h"

@interface AlarmViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (nonatomic, strong) NSArray *arrayTitle;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, copy) NSString *subtitleAlarmName,*subtitleAlarmTitle,*subtitleSleep;

@property (nonatomic, strong) NSMutableArray *arrayData;

@end

@implementation AlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置闹钟";
    
    self.arrayTitle = @[@"闹钟标题",@"响铃周期",@"小睡设置",@"铃声选择",@"更多设置"];
    
    self.mTableView.tableFooterView = [[UIView alloc] init];
    self.arrayData = [[NSMutableArray alloc] initWithCapacity:0];
}

#pragma mark tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayTitle.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:string];
    }
    cell.textLabel.text = self.arrayTitle[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = self.subtitleAlarmName;
    }else if (indexPath.row == 1){
        cell.detailTextLabel.text = self.subtitleAlarmTitle;
    }else if(indexPath.row == 2){
        cell.detailTextLabel.text = self.subtitleSleep;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"输入闹钟标题" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"OK", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        self.textField = [alert textFieldAtIndex:0];
        self.textField.placeholder = @"起床闹钟";
        self.textField.keyboardType = UIKeyboardTypeNamePhonePad;
        [alert show];
        
    }else if (indexPath.row == 1) {
        
        AlarmAlterView *alarmView = [AlarmAlterView alterView];
        alarmView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight + 400);
        alarmView.topView.backgroundColor = [UIColor clearColor];
        alarmView.backgroundColor = [UIColor clearColor];
        alarmView.arrayData = self.arrayData;
        [shareAppdelegate.window addSubview:alarmView];
        
        __weak typeof(self)weakSelf = self;
        alarmView.blockAlarm = ^(NSString *string, NSMutableArray *array) {
            weakSelf.arrayData = array;
            weakSelf.subtitleAlarmTitle = string;
            [weakSelf.mTableView reloadData];
        };
        
        [UIView animateWithDuration:0.3 animations:^{
            alarmView.top = -400;
            alarmView.topView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.85];
        }];

    }else if (indexPath.row == 2){
        SleepCycleView *alarmView = [SleepCycleView alterView];
        alarmView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight + 400);
        alarmView.topView.backgroundColor = [UIColor clearColor];
        alarmView.backgroundColor = [UIColor clearColor];
        [shareAppdelegate.window addSubview:alarmView];
        
        __weak typeof(self)weakSelf = self;
        alarmView.blockPickerRow = ^(NSString *rowData) {
            weakSelf.subtitleSleep = rowData;
            [weakSelf.mTableView reloadData];
        };
        [UIView animateWithDuration:0.3 animations:^{
            alarmView.top = -400;
            alarmView.topView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.85];
        }];
    }
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView{
    if (self.textField.text.length > 0) {
        return YES;
    }
    return NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        self.subtitleAlarmName = self.textField.text;
        if (self.subtitleAlarmName.length > 0) {
            [self.mTableView reloadData];
        }
    }
}



@end
