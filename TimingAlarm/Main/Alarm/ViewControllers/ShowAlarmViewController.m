//
//  ShowAlarmViewController.m
//  TimingAlarm
//
//  Created by Mac on 2018/8/23.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ShowAlarmViewController.h"
#import "ShowAlarmOneTableViewCell.h"
#import "ShowAlarmTwoTableViewCell.h"

@interface ShowAlarmViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (nonatomic, strong) UIImageView *myImageView;

@end

@implementation ShowAlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.mTableView registerNib:[UINib nibWithNibName:@"ShowAlarmTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"ShowAlarmTwoTableViewCell"];
    [self.mTableView registerNib:[UINib nibWithNibName:@"ShowAlarmOneTableViewCell" bundle:nil] forCellReuseIdentifier:@"ShowAlarmOneTableViewCell"];
    self.mTableView.tableFooterView = [UIView new];
    self.mTableView.rowHeight = 60;
    
    self.mTableView.contentInset=UIEdgeInsetsMake(kScreenHeight * 0.2, 0, 0, 0);
    
    self.myImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, - kScreenHeight * 0.2, kScreenWidth, kScreenHeight * 0.2)];
    self.myImageView.contentMode=UIViewContentModeScaleAspectFill;
    self.myImageView.image=[UIImage imageNamed:@"tableViewHeader"];
    self.myImageView.layer.masksToBounds = YES;
    
    [self.mTableView addSubview:self.myImageView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShowAlarmOneTableViewCell *cellOne = [tableView dequeueReusableCellWithIdentifier:@"ShowAlarmOneTableViewCell"];
    return cellOne;
}


#pragma mark- 当TableView被拖动时就会触发父类ScrollView的方法，可以在这里实现图片的放大及缩小
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point=scrollView.contentOffset;
    if (point.y<0) {
        CGRect rect=self.myImageView.frame;
        rect.origin.y=point.y;
        rect.size.height=-point.y;
        self.myImageView.frame=rect;
    }
}


@end
