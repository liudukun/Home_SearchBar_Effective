//
//  ViewController.m
//  Home_Effective
//
//  Created by liudukun on 16/5/31.
//  Copyright © 2016年 liudukun. All rights reserved.
//

#import "ViewController.h"

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<UIScrollViewDelegate>
{
    UIView * viewNav;
    UIScrollView * viewScroll;
    UITextField * field;
    CGFloat  bgHeight;
    UIView * bgView ;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setCustomView];
    
}

-(void)setCustomView{
    //navbar bg
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height/5*2)];
    bgView.backgroundColor = [UIColor greenColor];
    
    //textfield
    field = [[UITextField alloc]initWithFrame:CGRectMake(20, Screen_Height/5*2-45-10, Screen_Width-40, 45)];
    field.layer.borderColor = [UIColor whiteColor].CGColor;
    field.layer.borderWidth = 2.f;
    field.layer.cornerRadius = 4.f;
    field.placeholder = @"搜索吧";
    [bgView addSubview:field];
    
    //scrollview
    viewScroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    viewScroll.backgroundColor = [UIColor grayColor];
    viewScroll.delegate = self;
    viewScroll.contentSize = CGSizeMake(Screen_Width, Screen_Height + Screen_Height);
    
    [viewScroll addSubview:bgView];
    [self.view addSubview:viewScroll];
    
    //left view and right view
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 60, 45)];
    leftView.backgroundColor = [[UIColor blueColor]colorWithAlphaComponent:0.3];
    UIView * rightView = [[UIView alloc]initWithFrame:CGRectMake(Screen_Width - 20- 60, 20, 60, 45)];
    rightView.backgroundColor = [[UIColor blueColor]colorWithAlphaComponent:0.3];
    
    //left right super view
    viewNav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height/5*2)];
    [viewNav addSubview:leftView];
    [viewNav addSubview:rightView];
    [self.view addSubview:bgView];
    [self.view addSubview:viewNav];
    
    //save height
    bgHeight = bgView.frame.size.height;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<bgHeight-20) {//限制可拉伸间隙
        //拉伸比例
        float percent = scrollView.contentOffset.y/(bgHeight-20);
        
        //改textfield frame
        CGRect rect = field.frame;
        rect.size.width = Screen_Width- 40  -percent * 140;
        rect.origin.y = bgHeight - scrollView.contentOffset.y;
        field.frame = rect;
        
        field.center = CGPointMake(Screen_Width/2, field.center.y);
        
//        NSLog(@"%f",percent);
        
        //改bgview frame
        CGRect bgRect = bgView.frame;
        bgRect.size.height = bgHeight - scrollView.contentOffset.y+55;
        bgView.frame = bgRect;

        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
