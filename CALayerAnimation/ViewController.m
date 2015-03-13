//
//  ViewController.m
//  test
//
//  Created by invoker on 15/3/11.
//  Copyright (c) 2015年 invoker. All rights reserved.
//

#import "ViewController.h"
#define WIDTH 50
#define PHOTO_HEIGHT 150
@interface ViewController ()
{
    UILabel *testLable;
    UIButton *testButton;
    float i;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    testLable=[[UILabel alloc]initWithFrame:CGRectMake(50, 50, 200, 50)];
    testLable.backgroundColor=[UIColor colorWithRed:0.579 green:0.779 blue:0.788 alpha:1.000];
    [self.view addSubview:testLable];
    
    testButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 500, 50, 50)];
    
    [testButton setTitle:@"开始" forState:UIControlStateNormal];
    [testButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [testButton addTarget:self action:@selector(anmi) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:testButton];
    [self drawMyLayer];
    
    CGPoint position= CGPointMake(160, 200);
    CGRect bounds=CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    CGFloat cornerRadius=PHOTO_HEIGHT/2;
    CGFloat borderWidth=2;
    
    //自定义图层
    CALayer *layer=[[CALayer alloc]init];
    layer.bounds=CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    layer.position=CGPointMake(160, 200);
    layer.backgroundColor=[UIColor redColor].CGColor;
    layer.cornerRadius=PHOTO_HEIGHT/2;
    //注意仅仅设置圆角，对于图形而言可以正常显示，但是对于图层中绘制的图片无法正确显示
    //如果想要正确显示则必须设置masksToBounds=YES，剪切子图层
    layer.masksToBounds=YES;
    //阴影效果无法和masksToBounds同时使用，因为masksToBounds的目的就是剪切外边框，
    //而阴影效果刚好在外边框
    //    layer.shadowColor=[UIColor grayColor].CGColor;
    //    layer.shadowOffset=CGSizeMake(2, 2);
    //    layer.shadowOpacity=1;
    //设置边框
    layer.borderColor=[UIColor whiteColor].CGColor;
    layer.borderWidth=2;
   
    layer.bounds=bounds;
    layer.position=position;
    layer.backgroundColor=[UIColor redColor].CGColor;
    layer.cornerRadius=cornerRadius;
    layer.masksToBounds=YES;
    layer.borderColor=[UIColor whiteColor].CGColor;
    layer.borderWidth=borderWidth;
    
    //设置图层代理
    layer.delegate=self;
    
    //添加图层到根图层
    [self.view.layer addSublayer:layer];
    
    //调用图层setNeedDisplay,否则代理方法不会被调用
    [layer setNeedsDisplay];
    
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    //    NSLog(@"%@",layer);//这个图层正是上面定义的图层
    CGContextSaveGState(ctx);
    
    //图形上下文形变，解决图片倒立的问题
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -PHOTO_HEIGHT);
    
    UIImage *image=[UIImage imageNamed:@"1.jpeg"];
    //注意这个位置是相对于图层而言的不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);
    
    //    CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
    //    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    CGContextRestoreGState(ctx);
}


#pragma mark 绘制图层
-(void)drawMyLayer{
    CGSize size=[UIScreen mainScreen].bounds.size;
    
    //获得根图层
    CALayer *layer=[[CALayer alloc]init];
    //设置背景颜色,由于QuartzCore是跨平台框架，无法直接使用UIColor
    layer.backgroundColor=[UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
    //设置中心点
    layer.position=CGPointMake(size.width/2, size.height/2);
    //设置大小
    layer.bounds=CGRectMake(0, 0, WIDTH,WIDTH);
    //设置圆角,当圆角半径等于矩形的一半时看起来就是一个圆形
    layer.cornerRadius=WIDTH/2;
    //设置阴影
    layer.shadowColor=[UIColor grayColor].CGColor;
    layer.shadowOffset=CGSizeMake(2, 2);
    layer.shadowOpacity=.9;
    //设置边框
    //    layer.borderColor=[UIColor whiteColor].CGColor;
    //    layer.borderWidth=1;
    
    //设置锚点
    //    layer.anchorPoint=CGPointZero;
    
    [self.view.layer addSublayer:layer];
    
}

#pragma mark 点击放大
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CALayer *layer=self.view.layer.sublayers[2];
    NSLog(@"%@",self.view.layer.sublayers);
    CGFloat width=layer.bounds.size.width;
    if (width==WIDTH) {
        width=WIDTH*4;
    }else{
        width=WIDTH;
    }
    layer.bounds=CGRectMake(0, 0, width, width);
    layer.position=[touch locationInView:self.view];
    layer.cornerRadius=width/2;
}



-(void)anmi
{
   
        [UIView animateWithDuration:1.0f animations:^{
            
            testLable.frame = CGRectMake(0, arc4random() % 500, 200, 50);
            
            
        } completion:^(BOOL finished){
            [UIView beginAnimations:@"animationID" context:nil];
            [UIView setAnimationDuration:2.0f]; //动画时长
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
            
            testLable.frame = CGRectMake(50, arc4random() % 500, 200, 50);
            
        }];
   


}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
