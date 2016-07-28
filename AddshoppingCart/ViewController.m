//
//  ViewController.m
//  AddshoppingCart
//
//  Created by Raymon on 16/7/19.
//  Copyright © 2016年 Raymon. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+touch.h"

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)
@interface ViewController ()
@property (nonatomic,strong) UIBezierPath *path;
@end

@implementation ViewController
{
    UILabel *_badgeLabel;
    NSInteger _badgeNum;
    UIImageView *_imageView;
    UIButton *_addGoods;
    CALayer *_layer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _badgeNum = 0;
    [self setUI];
}

- (void)setUI
{
    UIColor *customColor = [UIColor colorWithRed:0.9634 green:0.3165 blue:0.3962 alpha:1.0];
    _addGoods = [UIButton buttonWithType:UIButtonTypeCustom];
    _addGoods.frame = CGRectMake(50, 300, 100, 50);
    _addGoods.timeInterVal = 3;
    [_addGoods setTitle:@"立即抢购" forState:UIControlStateNormal];
    [_addGoods setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _addGoods.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [_addGoods setBackgroundColor:customColor];
    [_addGoods addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addGoods];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _imageView.image = [UIImage imageNamed:@"TabCartSelected"];
    _imageView.center = CGPointMake(270, 320);
    [self.view addSubview:_imageView];

    // label
    _badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, 295, 20, 20)];
    _badgeLabel.textColor = customColor;
    _badgeLabel.textAlignment = NSTextAlignmentCenter;
    _badgeLabel.font = [UIFont boldSystemFontOfSize:13];
    _badgeLabel.backgroundColor = [UIColor whiteColor];
    _badgeLabel.layer.cornerRadius = CGRectGetHeight(_badgeLabel.bounds)/2;
    _badgeLabel.layer.masksToBounds = YES;
    _badgeLabel.layer.borderWidth = 1.0f;
    _badgeLabel.layer.borderColor = customColor.CGColor;
    [self.view addSubview:_badgeLabel];
    if (_badgeNum == 0) {
        _badgeLabel.hidden = YES;
    }
    self.path = [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(50, 150)];
    [_path addQuadCurveToPoint:CGPointMake(270, 300) controlPoint:CGPointMake(150, 20)];
}

- (void)startAnimation
{
    if (!_layer) {
//        _addGoods.enabled = NO;
        _layer = [CALayer layer];
        _layer.contents = (__bridge id)[UIImage imageNamed:@"3"].CGImage;
        _layer.contentsGravity = kCAGravityResizeAspectFill;
        _layer.bounds = CGRectMake(0, 0, 50, 50);
        [_layer setCornerRadius:CGRectGetHeight([_layer bounds])/2];
        _layer.masksToBounds = YES;
        _layer.position = CGPointMake(50, 150);
        [self.view.layer addSublayer:_layer];
    }
    [self groupAnimation];
}

- (void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration = 0.5f;
    expandAnimation.fromValue = [NSNumber numberWithFloat:1];
    expandAnimation.toValue = [NSNumber numberWithFloat:1.5f];
    expandAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime = 0.5;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:1.5f];
    narrowAnimation.duration = 1.5f;
    narrowAnimation.toValue = [NSNumber numberWithFloat:0.5f];
    
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,expandAnimation,narrowAnimation];
    groups.duration = 2.0f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [_layer addAnimation:groups forKey:@"group"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [_layer animationForKey:@"group"]) {
//        _addGoods.enabled = YES;
        [_layer removeFromSuperlayer];
        _layer = nil;
        _badgeNum ++;
        if (_badgeNum) {
            _badgeLabel.hidden = NO;
        }
        CATransition *animation = [CATransition animation];
        animation.duration = 0.25f;
        _badgeLabel.text = [NSString stringWithFormat:@"%ld",_badgeNum];
        [_badgeLabel.layer addAnimation:animation forKey:nil];
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        shakeAnimation.duration = 0.25f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
        shakeAnimation.toValue = [NSNumber numberWithFloat:5];
        shakeAnimation.autoreverses = YES;
        [_imageView.layer addAnimation:shakeAnimation forKey:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end





















