//
//  CSMenu.m
//  CSMenu
//
//  Created by 徐呈赛 on 16/5/4.
//  Copyright © 2016年 XuhuiCompany. All rights reserved.
//

#import "CSSlideMenu.h"
//#import "UIView+Extension.h"



@interface CSSlideMenu ()

//遮盖
@property (nonatomic,strong) UIButton *CoverView;
//判断是否需要拖拽
@property (nonatomic,assign) BOOL determine;

@end

@implementation CSSlideMenu
-(instancetype)initWithFrame:(CGRect)rect SuperView:(UIView *)superView GesturesView:(UIView *)gesturesView
{
    if (self = [super initWithFrame:rect]) {
        
        self.animateTime = 0.2;
        self.coverViewalpha = 0.4;
        //添加遮盖
        _CoverView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _CoverView.backgroundColor = [UIColor blackColor];
        _CoverView.alpha = 0;
        _CoverView.enabled = NO;
        [_CoverView addTarget:self action:@selector(coverViewClick) forControlEvents:UIControlEventTouchUpInside];
        [superView addSubview:_CoverView];
     
        //设置拖拽时遮盖的透明度
        _CoverView.alpha = (self.x + self.width) / self.width * self.coverViewalpha;
        if (_CoverView.alpha > 0) {
            _CoverView.enabled = YES;
        }

        self.backgroundColor = [UIColor whiteColor];
        
        
        //给侧滑菜单添加拖拽手势
        UIPanGestureRecognizer *menuPanGest = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGest:)];
        [self addGestureRecognizer:menuPanGest];
        
        //给手势UIView添加手势
        UIPanGestureRecognizer *GesturesViewPanGest = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(GesturesViewPanGest:)];
        [gesturesView addGestureRecognizer:GesturesViewPanGest];
        
    }
    
    return self;
}

//View拖拽
-(void)panGest:(UIPanGestureRecognizer *)panGest
{
    CGRect tempFrame = self.CoverView.frame;
    tempFrame.origin.x = 0;
    self.CoverView.frame = tempFrame;
    //获得当前拖拽的距离（累加）
    CGPoint poin = [panGest translationInView:panGest.view];
    
    
    if (panGest.state == UIGestureRecognizerStateBegan) {//开始手势
        
        if (poin.x > 0) {//往右移动
            
            if (self.frame.origin.x >= 0)return;
            
            //设置图片的中心点坐标
            CGPoint pointt = self.center;
            pointt.x += poin.x;
            self.center = pointt;
            
        }
    }else if (panGest.state == UIGestureRecognizerStateChanged){//拖拽中
        
        if (poin.x > 0) {//往右移动
            
            if (self.x + poin.x > 0){
                
            }else{
                
                //设置图片的中心点坐标
                CGPoint pointt = self.center;
                pointt.x += poin.x;
                self.center = pointt;
                
            }
            
            
            
        }else{//往左移
            
            //设置图片的中心点坐标
            CGPoint pointt = self.center;
            pointt.x += poin.x;
            self.center = pointt;
            
        }
        
        
        //设置拖拽时遮盖的透明度
        self.CoverView.alpha = (self.x + self.width) / self.width * self.coverViewalpha;
        
        
    }else if (panGest.state == UIGestureRecognizerStateEnded){//拖拽结束
        
        if ((self.x + self.width) < self.width * 0.5) {//缩回去
            
            [UIView animateWithDuration:self.animateTime animations:^{
                
                self.x = -self.width;
                self.CoverView.alpha = 0;
                
            } completion:^(BOOL finished) {
                
                self.CoverView.enabled = NO;
            }];
        }else{//完全出来
            
            self.CoverView.enabled = YES;
            [UIView animateWithDuration:self.animateTime animations:^{
                
                self.x = 0;
                self.CoverView.alpha = self.coverViewalpha;
            }];
            
        }
        
    }
    
    
    
    //清除拖拽距离的累加
    [panGest setTranslation:CGPointZero inView:panGest.view];
    
    
}

//手势View拖拽
-(void)GesturesViewPanGest:(UIPanGestureRecognizer *)panGest
{
    //获得当前拖拽的距离（累加）
    CGPoint poin = [panGest translationInView:panGest.view];
    
    
    if (panGest.state == UIGestureRecognizerStateChanged){//正在拖拽
        
        
        if (poin.x > 0 && [panGest locationInView:panGest.view].x <= 50) {//往右移动
            
            self.determine = YES;
        }
        
        
        if (self.determine) {
            
            [self panGest:panGest];
        }
        
    }else if (panGest.state == UIGestureRecognizerStateEnded){//结束拖拽
        
        
        if (self.determine) {
            
            [self panGest:panGest];
        }
        
        self.determine = NO;
    }
    //清除拖拽距离的累加
    [panGest setTranslation:CGPointZero inView:panGest.view];

}

//遮盖被点击，隐藏左边更多View
-(void)coverViewClick
{
    
    
    [UIView animateWithDuration:self.animateTime animations:^{
        
        self.x = -self.width;
        self.CoverView.alpha = 0;
    } completion:^(BOOL finished) {
        
        self.CoverView.enabled = NO;
    }];
    
    
}

//是否右移出遮盖，YES代表右移，NO代表隐藏
-(void)appearMenuViewWithState:(BOOL)state
{
    if (state == YES) {
        self.CoverView.enabled = YES;
        
        
        self.x -= 1;
        [UIView animateWithDuration:self.animateTime animations:^{
            
            self.x = 0;
            self.CoverView.alpha = self.coverViewalpha;
        }];
        
    }else{
    
        [UIView animateWithDuration:self.animateTime animations:^{
            
            self.x = -self.width;
            self.CoverView.alpha = 0;
        } completion:^(BOOL finished) {
            self.CoverView.enabled = NO;
        }];
    }
}


- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}
@end
