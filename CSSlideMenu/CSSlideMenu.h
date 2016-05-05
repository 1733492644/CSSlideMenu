//
//  CSMenu.h
//  CSMenu
//
//  Created by 徐呈赛 on 16/5/4.
//  Copyright © 2016年 XuhuiCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSSlideMenu : UIView

/**
 *  创建侧滑菜单
 *
 *  @param rect   菜单frame
 *  @param superView   菜单要加入哪个UIView里
 *  @param gesturesView 拖拽手势要加入哪个UIView里
 */
-(instancetype)initWithFrame:(CGRect)rect SuperView:(UIView *)superView GesturesView:(UIView *)gesturesView;

/**
 *  是否右移出遮盖
 *
 *  @param state   YES代表右移，NO代表隐藏
 */
-(void)appearMenuViewWithState:(BOOL)state;


//菜单右移或隐藏的动画时长
@property (nonatomic,assign) float animateTime;
//黑色遮盖的透明度
@property (nonatomic,assign) float coverViewalpha;
@end
