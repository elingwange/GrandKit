//
//  GKMainViewController.m
//  GrandKit
//
//  Created by Evan Fang on 2019/1/18.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "GKMainViewController.h"
#import "KCContact.h"
#import "KCContactGroup.h"
#import "UILabel+Manage.h"

@interface GKMainViewController ()<UITableViewDataSource, UITableViewDelegate> { // 类名 () Extension-类扩展
    // Extension是Category的一个特例。类扩展与分类相比只少了分类的名称，所以称之为“匿名分类”
    // 类扩展不仅可以增加方法，还可以增加属性，只是该实例变量默认是@private类型
    // 类扩展不能像类别那样拥有独立的实现部分（@implementation部分），类扩展所声明的方法必须依托对应类的实现部分来实现
    
    UILabel *_lbTitle;
    UITableView *_tableView;
    NSMutableArray *_contactArray;//联系人模型
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
    _contactArray=[[NSMutableArray alloc]init];
    
    KCContact *contact1=[KCContact initWithFirstName:@"Base" andLastName:@"Socket" andPhoneNumber:@"GKSocketBaseViewController"];
    KCContact *contact2=[KCContact initWithFirstName:@"Chat" andLastName:@"Socket" andPhoneNumber:@"GKSocketChatViewController"];
    KCContact *contact3=[KCContact initWithFirstName:@"Http" andLastName:@"Socket" andPhoneNumber:@"GKSocketHttpViewController"];
    KCContactGroup *group1=[KCContactGroup initWithName:@"网络" andDetail:@"" andContacts:[NSMutableArray arrayWithObjects:contact1, contact2, contact3, nil]];
    [_contactArray addObject:group1];
    
    
    
//    KCContact *contact3=[KCContact initWithFirstName:@"Lee" andLastName:@"Terry" andPhoneNumber:@"18500131238"];
//    KCContact *contact4=[KCContact initWithFirstName:@"Lee" andLastName:@"Jack" andPhoneNumber:@"18500131239"];
//    KCContact *contact5=[KCContact initWithFirstName:@"Lee" andLastName:@"Rose" andPhoneNumber:@"18500131240"];
//    KCContactGroup *group2=[KCContactGroup initWithName:@"L" andDetail:@"With names beginning with L" andContacts:[NSMutableArray arrayWithObjects:contact3,contact4,contact5, nil]];
//    [_contactArray addObject:group2];
//
//
//
//    KCContact *contact6=[KCContact initWithFirstName:@"Sun" andLastName:@"Kaoru" andPhoneNumber:@"18500131235"];
//    KCContact *contact7=[KCContact initWithFirstName:@"Sun" andLastName:@"Rosa" andPhoneNumber:@"18500131236"];
//
//    KCContactGroup *group3=[KCContactGroup initWithName:@"S" andDetail:@"With names beginning with S" andContacts:[NSMutableArray arrayWithObjects:contact6,contact7, nil]];
//    [_contactArray addObject:group3];
//
//
//    KCContact *contact8=[KCContact initWithFirstName:@"Wang" andLastName:@"Stephone" andPhoneNumber:@"18500131241"];
//    KCContact *contact9=[KCContact initWithFirstName:@"Wang" andLastName:@"Lucy" andPhoneNumber:@"18500131242"];
//    KCContact *contact10=[KCContact initWithFirstName:@"Wang" andLastName:@"Lily" andPhoneNumber:@"18500131243"];
//    KCContact *contact11=[KCContact initWithFirstName:@"Wang" andLastName:@"Emily" andPhoneNumber:@"18500131244"];
//    KCContact *contact12=[KCContact initWithFirstName:@"Wang" andLastName:@"Andy" andPhoneNumber:@"18500131245"];
//    KCContactGroup *group4=[KCContactGroup initWithName:@"W" andDetail:@"With names beginning with W" andContacts:[NSMutableArray arrayWithObjects:contact8,contact9,contact10,contact11,contact12, nil]];
//    [_contactArray addObject:group4];
//
//
//    KCContact *contact13=[KCContact initWithFirstName:@"Zhang" andLastName:@"Joy" andPhoneNumber:@"18500131246"];
//    KCContact *contact14=[KCContact initWithFirstName:@"Zhang" andLastName:@"Vivan" andPhoneNumber:@"18500131247"];
//    KCContact *contact15=[KCContact initWithFirstName:@"Zhang" andLastName:@"Joyse" andPhoneNumber:@"18500131248"];
//    KCContactGroup *group5=[KCContactGroup initWithName:@"Z" andDetail:@"With names beginning with Z" andContacts:[NSMutableArray arrayWithObjects:contact13,contact14,contact15, nil]];
//    [_contactArray addObject:group5];
    
}

#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    NSLog(@"计算分组数");
    return _contactArray.count;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"计算每组(组%i)行数", (int)section);
    KCContactGroup *group = _contactArray[section];
    return group.contacts.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
//    NSLog(@"生成单元格(组：%i,行%i)", (int)indexPath.section, (int)indexPath.row);
    KCContactGroup *group=_contactArray[indexPath.section];
    KCContact *contact=group.contacts[indexPath.row];
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text=[contact getName];
    cell.detailTextLabel.text=contact.phoneNumber;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark 返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSLog(@"生成组（组%i）名称", (int)section);
    KCContactGroup *group=_contactArray[section];
    return group.name;
}

#pragma mark 返回每组尾部说明
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
//    NSLog(@"生成尾部（组%i）详情", (int)section);
    KCContactGroup *group=_contactArray[section];
    return group.detail;
}

#pragma mark - 代理方法
#pragma mark 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
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
    
    KCContactGroup *group = _contactArray[indexPath.section];
    KCContact *contact = group.contacts[indexPath.row];
    //创建视图控制器的Class
    //使用class间接使用类名，即使不加头文件，也能创建对象。
    //编译器要求直接引用类名等标识符，必须拥有声明。
    Class aVCClass = NSClassFromString(contact.phoneNumber);
    //创建vc对象
    UIViewController * vc = [[aVCClass alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
