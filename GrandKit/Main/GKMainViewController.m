//
//  GKMainViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/1/18.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKMainViewController.h"
#import "UILabel+Manage.h"
#import "GKPoint.h"
#import "GKGroup.h"

@interface GKMainViewController ()<UITableViewDataSource, UITableViewDelegate> { // 类名 () Extension-类扩展
    // Extension是Category的一个特例。类扩展与分类相比只少了分类的名称，所以称之为“匿名分类”
    // 类扩展不仅可以增加方法，还可以增加属性，只是该实例变量默认是@private类型
    // 类扩展不能像类别那样拥有独立的实现部分（@implementation部分），类扩展所声明的方法必须依托对应类的实现部分来实现
    
    UILabel *_lbTitle;
    UITableView *_tableView;
    NSMutableArray *_groupArray;
    NSIndexPath *_selectedIndexPath;//当前选中的组和行
}

@end


@implementation GKMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_FromRGB(0xEFEFF4);
    
    [self initTitle];
    
    //初始化数据
    [self initData];
    
    //创建一个分组样式的UITableView
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, Size(80), Width, Height - Size(80)) style:UITableViewStyleGrouped];
    
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)initTitle {
    _lbTitle = [UILabel creatWithTextColor:Color_FromRGB(0x263238) font:[UIFont fontWithName:@"PingFangSC-Semibold" size:Size(22)]];
    _lbTitle.frame = CGRectMake(Size(15), Size(40), Width, Size(30));
    _lbTitle.text = @"GrandKit";
    [self.view addSubview:_lbTitle];
}

#pragma mark 加载数据
-(void)initData{
    _groupArray=[[NSMutableArray alloc]init];
    
    GKPoint *point61 = [GKPoint initWithName:@"ImagePicker Default" andClass:@"EFImagePickerViewController2"];
    GKPoint *point62 = [GKPoint initWithName:@"ImagePicker Custom" andClass:@"ImagePickerDemoViewController"];
    GKGroup *group6 = [GKGroup initWithName:@"UI" andDetail:@"" andPoints:[NSMutableArray arrayWithObjects:point61, point62, nil]];
    [_groupArray addObject:group6];
    
    GKPoint *point1 = [GKPoint initWithName:@"Base" andClass:@"GKSocketBaseViewController"];
    GKPoint *point2 = [GKPoint initWithName:@"Chat" andClass:@"GKSocketChatViewController"];
    GKPoint *point3 = [GKPoint initWithName:@"Http" andClass:@"GKSocketHttpViewController"];
    GKGroup *group1 = [GKGroup initWithName:@"Socket" andDetail:@"" andPoints:[NSMutableArray arrayWithObjects:point1, point2, point3, nil]];
    [_groupArray addObject:group1];
    
    GKPoint *point21 = [GKPoint initWithName:@"Base Download" andClass:@"GKURLConnectionDownloadViewController"];
    GKPoint *point22 = [GKPoint initWithName:@"Delegate Download" andClass:@"GKURLConnectionDeligateDownloadViewController"];
    GKPoint *point23 = [GKPoint initWithName:@"Delegate2 Download" andClass:@"GKURLConnectionDeligateDownload2ViewController"];
    GKPoint *point24 = [GKPoint initWithName:@"Delegate3 Download" andClass:@"GKURLConnectionDeligateDownload3ViewController"];
    GKGroup *group2 = [GKGroup initWithName:@"NSURLConnection" andDetail:@"" andPoints:[NSMutableArray arrayWithObjects:point21, point22, point23, point24, nil]];
    [_groupArray addObject:group2];
    
    GKPoint *point31 = [GKPoint initWithName:@"Base" andClass:@"GKURLSessionViewController"];
    GKPoint *point32 = [GKPoint initWithName:@"DownloadDelegate" andClass:@"GKURLSessionDeligateDownloadViewController"];
    GKPoint *point33 = [GKPoint initWithName:@"DownloadDelegate Resume" andClass:@"GKURLSessionDeligateDownloadResumeViewController"];
    GKGroup *group3 = [GKGroup initWithName:@"NSURLSession" andDetail:@"" andPoints:[NSMutableArray arrayWithObjects:point31, point32, point33, nil]];
    [_groupArray addObject:group3];
    
    GKPoint *point41 = [GKPoint initWithName:@"Get" andClass:@"GKHttpGetViewController"];
    GKPoint *point42 = [GKPoint initWithName:@"Post" andClass:@"GKHttpPostViewController"];
    GKPoint *point43 = [GKPoint initWithName:@"Upload" andClass:@"GKHttpUploadViewController"];
    GKPoint *point44 = [GKPoint initWithName:@"Upload AFN" andClass:@"GKAFNUploadViewController"];
    GKGroup *group4 = [GKGroup initWithName:@"HTTP" andDetail:@"" andPoints:[NSMutableArray arrayWithObjects:point41, point42, point43, point44, nil]];
    [_groupArray addObject:group4];
    
    GKPoint *point51 = [GKPoint initWithName:@"Delegate" andClass:@"GKDelegateBaseViewController"];
    GKGroup *group5 = [GKGroup initWithName:@"Syntax" andDetail:@"" andPoints:[NSMutableArray arrayWithObjects:point51, nil]];
    [_groupArray addObject:group5];
}

#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    NSLog(@"计算分组数");
    return _groupArray.count;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"计算每组(组%i)行数", (int)section);
    GKGroup *group = _groupArray[section];
    return group.points.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
//    NSLog(@"生成单元格(组：%i,行%i)", (int)indexPath.section, (int)indexPath.row);
    GKGroup *group = _groupArray[indexPath.section];
    GKPoint *point = group.points[indexPath.row];
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = point.name;
//    cell.detailTextLabel.text = point.phoneNumber;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark 返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSLog(@"生成组（组%i）名称", (int)section);
    GKGroup *group = _groupArray[section];
    return group.name;
}

#pragma mark 返回每组尾部说明
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
//    NSLog(@"生成尾部（组%i）详情", (int)section);
    GKGroup *group = _groupArray[section];
    return group.detail;
}

#pragma mark - 代理方法
#pragma mark 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0) {
        return 30;
    }
    return 40;
}

#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

#pragma mark 设置尾部说明内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}

#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    GKGroup *group = _groupArray[indexPath.section];
    GKPoint *point = group.points[indexPath.row];
    //创建视图控制器的Class
    //使用class间接使用类名，即使不加头文件，也能创建对象。
    //编译器要求直接引用类名等标识符，必须拥有声明。
    Class aVCClass = NSClassFromString(point.className);
    //创建vc对象
    UIViewController * vc = [[aVCClass alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
