//
//  ViewController.m
//  CSSlideMenu
//
//  Created by 徐呈赛 on 16/5/5.
//  Copyright © 2016年 XuhuiCompany. All rights reserved.
//

#import "ViewController.h"
#import "CSSlideMenu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建侧滑菜单
    CGRect frame = CGRectMake(-250, 0, 250, self.view.frame.size.height);
    CSSlideMenu *menu = [[CSSlideMenu alloc]initWithFrame:frame SuperView:self.view GesturesView:self.view];
    [self.view addSubview:menu];
    
    //添加自己需要的内容UIView
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(15, 50, 100, 100);
    [menu addSubview:view];
}

@end
