//
//  TextField.m
//  TextField
//
//  Created by 王凯丹 on 2017/10/28.
//  Copyright © 2017年 shiheng. All rights reserved.
//

#import "KDTextField.h"
@interface KDTextField()<CAAnimationDelegate>
@property (strong, nonatomic) UILabel *placeholderCacheLabel;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UIView *grayLineView;
@property (strong, nonatomic) NSAttributedString *cachedPlaceholder;
@end

@implementation KDTextField

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self == nil) return nil;
    self.defaultTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithRed:33.0/255.0 green:33.0/255.0 blue:33.0/255.0 alpha:1.0]};
    self.borderStyle = UITextBorderStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    
    self.grayLineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, frame.size.width, 1)];
    _grayLineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self addSubview:_grayLineView];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, 0, 1)];
    _lineView.backgroundColor = [UIColor colorWithRed:0xFA/255.0 green:0x68/255.0 blue:0x64/255.0 alpha:1.0];
    _lineView.layer.anchorPoint = CGPointMake(0, 0.5);
    [self addSubview:_lineView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kd_textFieldDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kd_textFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITextFieldTextDidBeginEditingNotification
- (void)kd_textFieldDidBeginEditing:(NSNotification *)notification {
    CAKeyframeAnimation *kfAnimation11 = [CAKeyframeAnimation animationWithKeyPath:@"bounds.size.width"];
    kfAnimation11.fillMode = kCAFillModeForwards;
    kfAnimation11.removedOnCompletion = NO;
    kfAnimation11.values = @[@0,@(self.bounds.size.width)];
    kfAnimation11.duration = 0.25f;
    kfAnimation11.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_lineView.layer addAnimation:kfAnimation11 forKey:@"kKDLienViewWidth"];
    
    if (![self.text isEqualToString:@""]) {
        return;
    }
    if (!_placeholderCacheLabel) {
        [self addSubview:self.placeholderCacheLabel];
        _placeholderCacheLabel.attributedText = self.attributedPlaceholder;
        self.cachedPlaceholder = self.attributedPlaceholder;
    }
    self.placeholder = nil;
    _placeholderCacheLabel.hidden = NO;


    CAKeyframeAnimation *kfAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    kfAnimation1.fillMode = kCAFillModeForwards;
    kfAnimation1.removedOnCompletion = NO;
    CATransform3D scale1 = CATransform3DMakeScale(1.0, 1.0, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.1, 1.1, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    kfAnimation1.values = @[[NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3]];
    
    CAKeyframeAnimation *kfAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"bounds.origin"];
    kfAnimation2.fillMode = kCAFillModeForwards;
    kfAnimation2.removedOnCompletion = NO;
    kfAnimation2.values = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],[NSValue valueWithCGPoint:CGPointMake(0, 22)]];
    
    CAAnimationGroup *grouoAnimation = [CAAnimationGroup animation];
    grouoAnimation.animations = @[kfAnimation1,kfAnimation2];
    grouoAnimation.fillMode = kCAFillModeForwards;
    grouoAnimation.removedOnCompletion = NO;
    grouoAnimation.duration = 0.25;
    grouoAnimation.delegate = self;
    [_placeholderCacheLabel.layer addAnimation:grouoAnimation forKey:@"kKDOutAnimation"];
    
}

#pragma mark - UITextFieldTextDidEndEditingNotification
- (void)kd_textFieldDidEndEditing:(NSNotification *)notification {
    CAKeyframeAnimation *kfAnimation11 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    kfAnimation11.fillMode = kCAFillModeForwards;
    kfAnimation11.removedOnCompletion = NO;
    kfAnimation11.values = @[@1,@0];
    kfAnimation11.duration = 0.25f;
    kfAnimation11.delegate = self;
    [_lineView.layer addAnimation:kfAnimation11 forKey:@"kKDLienViewOpactity"];
    
    CAKeyframeAnimation *kfAnimation12 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    kfAnimation12.fillMode = kCAFillModeForwards;
    kfAnimation12.removedOnCompletion = NO;
    kfAnimation12.values = @[@0,@1];
    kfAnimation12.duration = 0.25f;
    kfAnimation12.delegate = self;
    [_grayLineView.layer addAnimation:kfAnimation12 forKey:@"kKDGrayLienViewOpactity"];

    if (![self.text isEqualToString:@""]) {
        return;
    }
    
    CAKeyframeAnimation *kfAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    kfAnimation1.fillMode = kCAFillModeForwards;
    kfAnimation1.removedOnCompletion = NO;
    CATransform3D scale1 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.1, 1.1, 1);
    CATransform3D scale3 = CATransform3DMakeScale(1.0, 1.0, 1);
    kfAnimation1.values = @[[NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3]];
    
    CAKeyframeAnimation *kfAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"bounds.origin"];
    kfAnimation2.fillMode = kCAFillModeForwards;
    kfAnimation2.removedOnCompletion = NO;
    kfAnimation2.values = @[[NSValue valueWithCGPoint:CGPointMake(0, 22)],[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
    
    CAAnimationGroup *grouoAnimation = [CAAnimationGroup animation];
    grouoAnimation.animations = @[kfAnimation1,kfAnimation2];
    grouoAnimation.fillMode = kCAFillModeForwards;
    grouoAnimation.removedOnCompletion = NO;
    grouoAnimation.duration = 0.25;
    grouoAnimation.delegate = self;
    [_placeholderCacheLabel.layer addAnimation:grouoAnimation forKey:@"kZYYInAnimation"];
    
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        if (anim == [_placeholderCacheLabel.layer animationForKey:@"kZYYInAnimation"] ) {
            _placeholderCacheLabel.hidden = YES;
            self.attributedPlaceholder = self.cachedPlaceholder;
        } else if (anim == [_lineView.layer animationForKey:@"kZYYLienViewOpactity"]) {
            CGRect frame = _lineView.frame;
            frame.size.width = 0;
            _lineView.frame = frame;
            _lineView.alpha = 1;
            _grayLineView.alpha = 0;
            [_lineView.layer removeAllAnimations];
        }
    }
}


#pragma mark - Setter & Getter
- (UILabel *)placeholderCacheLabel {
    if (!_placeholderCacheLabel) {
        _placeholderCacheLabel = [[UILabel alloc] init];
        _placeholderCacheLabel.layer.anchorPoint = CGPointZero;
        _placeholderCacheLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    }
    return _placeholderCacheLabel;
}

@end
