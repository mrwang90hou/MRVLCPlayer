//
//  MRVideoControl.m
//  MRVLCPlayer
//
//  Created by Maru on 16/3/8.
//  Copyright © 2016年 Alloc. All rights reserved.
//

#import "MRVideoControlView.h"
#import "Masonry.h"
@interface MRVideoControlView ()
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@end
@implementation MRVideoControlView

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupView];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.topBar.frame             = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), MRVideoControlBarHeight);
    self.closeButton.frame        = CGRectMake(CGRectGetWidth(self.topBar.bounds) - CGRectGetWidth(self.closeButton.bounds), CGRectGetMinX(self.topBar.bounds), CGRectGetWidth(self.closeButton.bounds), CGRectGetHeight(self.closeButton.bounds));
    self.bottomBar.frame          = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetHeight(self.bounds) - MRVideoControlBarHeight, CGRectGetWidth(self.bounds), MRVideoControlBarHeight);
    self.progressSlider.frame     = CGRectMake(0, -0, CGRectGetWidth(self.bounds), MRVideoControlSliderHeight);
    self.playButton.frame         = CGRectMake(CGRectGetMinX(self.bottomBar.bounds), CGRectGetHeight(self.bottomBar.bounds)/2 - CGRectGetHeight(self.playButton.bounds)/2 + CGRectGetHeight(self.progressSlider.frame) * 0.6, CGRectGetWidth(self.playButton.bounds), CGRectGetHeight(self.playButton.bounds));
    self.pauseButton.frame        = self.playButton.frame;
    self.fullScreenButton.frame   = CGRectMake(CGRectGetWidth(self.bottomBar.bounds) - CGRectGetWidth(self.fullScreenButton.bounds) - 5, self.playButton.frame.origin.y, CGRectGetWidth(self.fullScreenButton.bounds), CGRectGetHeight(self.fullScreenButton.bounds));
    self.shrinkScreenButton.frame = self.fullScreenButton.frame;
    self.indicatorView.center     = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2);
    self.timeLabel.frame          = CGRectMake(CGRectGetMaxX(self.playButton.frame), self.playButton.frame.origin.y, CGRectGetWidth(self.bottomBar.bounds), CGRectGetHeight(self.timeLabel.bounds));
    self.alertlable.center        = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2);
    
    self.actionModelLabel.frame = CGRectMake(CGRectGetMaxX(self.playButton.frame), self.playButton.frame.origin.y, CGRectGetWidth(self.bottomBar.bounds), CGRectGetHeight(self.actionModelLabel.bounds));
    
    self.resolutionLabel.frame = CGRectMake(CGRectGetMinX(self.fullScreenButton.frame)-20, self.fullScreenButton.frame.origin.y,CGRectGetWidth(self.bottomBar.bounds), CGRectGetHeight(self.resolutionLabel.bounds));
    
    //约束布局
    [self.totalBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(55, 120));
    }];
    [self.picBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.totalBtnView.mas_top);
//        make.top.equalTo(self.totalBtnView);
        make.right.mas_equalTo(self.totalBtnView);
        make.size.mas_equalTo(CGSizeMake(55, 55));
    }];
    [self.vidBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.totalBtnView.mas_bottom);
        make.right.mas_equalTo(self.totalBtnView);
        make.size.mas_equalTo(CGSizeMake(55, 55));
    }];
//    self.totalBtnView.hidden = true;
//    self.totalBtnView.frame = CGRectMake(CGRectGetWidth(self.bounds)-120+55, CGRectGetMaxY(self.topBar.frame)+10, 55, 120);
//    self.picBtn.frame = CGRectMake(CGRectGetMinX(self.resolutionLabel.frame), CGRectGetMaxY(self.topBar.frame)+10,55, 55);
//    self.vidBtn.frame = CGRectMake(self.picBtn.frame.origin.x, CGRectGetMaxY(self.picBtn.frame)+10,55, 55);

    
    
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
}


#pragma mark - Public Method
- (void)animateHide
{
    [UIView animateWithDuration:MRVideoControlAnimationTimeinterval animations:^{
        self.topBar.alpha = 0;
        self.bottomBar.alpha = 0;
        self.totalBtnView.alpha = 0.3;
    } completion:^(BOOL finished) {
    }];
}

- (void)animateShow
{
    [UIView animateWithDuration:MRVideoControlAnimationTimeinterval animations:^{
        self.topBar.alpha = 1;
        self.bottomBar.alpha = 1;
        self.totalBtnView.alpha = 1;
    } completion:^(BOOL finished) {
        [self autoFadeOutControlBar];
    }];
}
//自动淡出控制栏
- (void)autoFadeOutControlBar
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(animateHide) object:nil];
    [self performSelector:@selector(animateHide) withObject:nil afterDelay:MRVideoControlBarAutoFadeOutTimeinterval];
}
//取消自动淡出控件栏
- (void)cancelAutoFadeOutControlBar
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(animateHide) object:nil];
}


#pragma mark - Private Method
- (void)setupView {
    
    self.backgroundColor = [UIColor clearColor];

    [self.layer addSublayer:self.bgLayer];
    [self addSubview:self.topBar];
    [self addSubview:self.indicatorView];
    [self addSubview:self.bottomBar];
    [self addSubview:self.indicatorView];
    [self addSubview:self.alertlable];
    [self addSubview:self.totalBtnView];
    
    [self.topBar    addSubview:self.closeButton];
    [self.bottomBar addSubview:self.playButton];
    [self.bottomBar addSubview:self.pauseButton];
    [self.bottomBar addSubview:self.fullScreenButton];
    [self.bottomBar addSubview:self.shrinkScreenButton];
    [self.bottomBar addSubview:self.progressSlider];
    [self.bottomBar addSubview:self.timeLabel];
    [self.bottomBar addSubview:self.actionModelLabel];
    [self.bottomBar addSubview:self.resolutionLabel];
    [self.totalBtnView addSubview:self.picBtn];
    [self.totalBtnView addSubview:self.vidBtn];
    
//    隐藏拍照及录像按钮
    self.picBtn.hidden = YES;
    [self.vidBtn setHidden:YES];
//
    self.timeLabel.hidden = true;
    self.pauseButton.hidden = YES;
    self.shrinkScreenButton.hidden = YES;
    
    [self addGestureRecognizer:self.pan];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
}


- (void)responseTapImmediately {
    self.bottomBar.alpha == 0 ? [self animateShow] : [self animateHide];
}

#pragma mark - Override
#pragma mark Touch Event

- (void)tapAction:(UITapGestureRecognizer *)tap {
    
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    
    CGPoint localPoint = [pan locationInView:self];
    
    CGPoint speedDir = [pan velocityInView:self];
    
    switch (pan.state) {
            
        case UIGestureRecognizerStateBegan: {
            
//            self.alertlable.alpha = MRVideoControlAlertAlpha;
            
        }
            break;
            
            
        case UIGestureRecognizerStateChanged: {
            
            // 判断方向
//            if (ABS(speedDir.x) > ABS(speedDir.y)) {
//                if ([pan translationInView:self].x > 0) {
//                    if ([_delegate respondsToSelector:@selector(controlViewFingerMoveRight)]) {
//                        [self.delegate controlViewFingerMoveRight];
//                    }
//                    [self.alertlable configureWithTime:[self.timeLabel.text substringToIndex:5] isLeft:NO];
//                }else {
//                    if ([_delegate respondsToSelector:@selector(controlViewFingerMoveRight)]) {
//                        [self.delegate controlViewFingerMoveLeft];
//                    }
//                    [self.alertlable configureWithTime:[self.timeLabel.text substringToIndex:5] isLeft:YES];
//                }
//            }else {
//
//                if (localPoint.x > self.bounds.size.width / 2) {
//                    // 改变音量
//                    if ([pan translationInView:self].y > 0) {
//                        self.volumeSlider.value -= 0.03;
//                    }else {
//                        self.volumeSlider.value += 0.03;
//                    }
//                    [self.alertlable configureWithVolume:self.volumeSlider.value];
//                }else {
//                    // 改变显示亮度
//                    if ([pan translationInView:self].y > 0) {
//                        [UIScreen mainScreen].brightness -= 0.01;
//                    }else {
//                        [UIScreen mainScreen].brightness += 0.01;
//                    }
//                    [self.alertlable configureWithLight];
//                }
//            }
        }
            break;
            
        case UIGestureRecognizerStateEnded: {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:1 animations:^{
                    self.alertlable.alpha = 0;
                }];
            });
        }
            break;
        default:
            break;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch.tapCount > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self responseTapImmediately];
        });

    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self responseTapImmediately];
}

#pragma mark - Property
- (MRVideoHUDView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[MRVideoHUDView alloc] init];
        _indicatorView.bounds = CGRectMake(0, 0, 100, 100);
    }
    return _indicatorView;
}

- (UIView *)topBar
{
    if (!_topBar) {
        _topBar = [UIView new];
        _topBar.backgroundColor = [UIColor clearColor];
    }
    return _topBar;
}

- (UIView *)bottomBar
{
    if (!_bottomBar) {
        _bottomBar = [UIView new];
//        _bottomBar.backgroundColor = MRRGB(27, 27, 27);
        _bottomBar.backgroundColor = [UIColor clearColor];
    }
    return _bottomBar;
}

- (UIButton *)playButton
{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"Play Icon"] forState:UIControlStateNormal];
        _playButton.bounds = CGRectMake(0, 0, MRVideoControlBarHeight, MRVideoControlBarHeight);
    }
    return _playButton;
}

- (UIButton *)pauseButton
{
    if (!_pauseButton) {
        _pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pauseButton setImage:[UIImage imageNamed:@"Pause Icon"] forState:UIControlStateNormal];
        _pauseButton.bounds = CGRectMake(0, 0, MRVideoControlBarHeight, MRVideoControlBarHeight);
    }
    return _pauseButton;
}

- (UIButton *)fullScreenButton
{
    if (!_fullScreenButton) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setImage:[UIImage imageNamed:@"Full Screen Icon"] forState:UIControlStateNormal];
        _fullScreenButton.bounds = CGRectMake(0, 0, MRVideoControlBarHeight, MRVideoControlBarHeight);
    }
    return _fullScreenButton;
}

- (UIButton *)shrinkScreenButton
{
    if (!_shrinkScreenButton) {
        _shrinkScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shrinkScreenButton setImage:[UIImage imageNamed:@"Min. Icon"] forState:UIControlStateNormal];
        _shrinkScreenButton.bounds = CGRectMake(0, 0, MRVideoControlBarHeight, MRVideoControlBarHeight);
    }
    return _shrinkScreenButton;
}


- (MRProgressSlider *)progressSlider
{
    if (!_progressSlider) {
        _progressSlider = [[MRProgressSlider alloc] init];
        [_progressSlider setThumbImage:[UIImage imageNamed:@"Player Control Nob"] forState:UIControlStateNormal];
        [_progressSlider setMinimumTrackTintColor:MRRGB(239, 71, 94)];
        [_progressSlider setMaximumTrackTintColor:MRRGB(157, 157, 157)];
        [_progressSlider setBackgroundColor:[UIColor clearColor]];
        _progressSlider.value = 0.f;
        _progressSlider.continuous = YES;
        _progressSlider.hidden = true;//隐藏改控件
    }
    return _progressSlider;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"Player close"] forState:UIControlStateNormal];
        _closeButton.bounds = CGRectMake(0, 0, MRVideoControlBarHeight, MRVideoControlBarHeight);
    }
    return _closeButton;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont systemFontOfSize:MRVideoControlTimeLabelFontSize];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.bounds = CGRectMake(0, 0, MRVideoControlTimeLabelFontSize, MRVideoControlBarHeight);
    }
    return _timeLabel;
}
- (UILabel *)actionModelLabel
{
    if (!_actionModelLabel) {
        _actionModelLabel = [UILabel new];
        _actionModelLabel.backgroundColor = [UIColor clearColor];
        _actionModelLabel.font = [UIFont systemFontOfSize:MRVideoControlTimeLabelFontSize];
        _actionModelLabel.textColor = [UIColor redColor];
        _actionModelLabel.textAlignment = NSTextAlignmentLeft;
        _actionModelLabel.text = @"录像模式";
        _actionModelLabel.bounds = CGRectMake(0, 0, MRVideoControlTimeLabelFontSize, MRVideoControlBarHeight);
    }
    return _actionModelLabel;
}
- (UILabel *)resolutionLabel
{
    if (!_resolutionLabel) {
        _resolutionLabel = [UILabel new];
        _resolutionLabel.backgroundColor = [UIColor clearColor];
        _resolutionLabel.font = [UIFont systemFontOfSize:MRVideoControlTimeLabelFontSize];
        _resolutionLabel.textColor = [UIColor redColor];
        _resolutionLabel.textAlignment = NSTextAlignmentLeft;
        _resolutionLabel.text = @"高清";
        _resolutionLabel.bounds = CGRectMake(0, 0, MRVideoControlTimeLabelFontSize, MRVideoControlBarHeight);
    }
    return _resolutionLabel;
}
-(UIView *)totalBtnView
{
    if (!_totalBtnView) {
        _totalBtnView = [UIView new];
        _totalBtnView.backgroundColor = [UIColor clearColor];
    }
    return _totalBtnView;

}

- (UIButton *)picBtn
{
    if (!_picBtn) {
        _picBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_picBtn setImage:[UIImage imageNamed:@"recorder_btn_photograph_default"] forState:UIControlStateNormal];
        [_picBtn setImage:[UIImage imageNamed:@"recorder_btn_photograph_selected"] forState:UIControlStateSelected];
        _picBtn.bounds = CGRectMake(0, 0, MRVideoControlBarHeight, MRVideoControlBarHeight);
    }
    return _picBtn;
}
- (UIButton *)vidBtn
{
    if (!_vidBtn) {
        _vidBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_vidBtn setImage:[UIImage imageNamed:@"recorder_btn_videotape_default"] forState:UIControlStateNormal];
        [_vidBtn setImage:[UIImage imageNamed:@"recorder_btn_videotape_selected"] forState:UIControlStateSelected];
        _vidBtn.bounds = CGRectMake(0, 0, MRVideoControlBarHeight, MRVideoControlBarHeight);
    }
    return _vidBtn;
}

- (CALayer *)bgLayer {
    if (!_bgLayer) {
        _bgLayer = [CALayer layer];
        _bgLayer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Video Bg"]].CGColor;
        _bgLayer.bounds = self.frame;
        _bgLayer.position = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2);
    }
    return _bgLayer;
}

- (UISlider *)volumeSlider {
    if (!_volumeSlider) {
        for (UIControl *view in self.volumeView.subviews) {
            if ([view.superclass isSubclassOfClass:[UISlider class]]) {
                _volumeSlider = (UISlider *)view;
            }
        }
    }
    return _volumeSlider;
}

- (MPVolumeView *)volumeView {
    if (!_volumeView) {
        _volumeView = [[MPVolumeView alloc] init];
    }
    return _volumeView;
}

- (UILabel *)alertlable {
    if (!_alertlable) {
        _alertlable = [UILabel new];
        _alertlable.bounds = CGRectMake(0, 0, 100, 40);
        _alertlable.textAlignment = NSTextAlignmentCenter;
        _alertlable.backgroundColor = [UIColor colorWithWhite:0.000 alpha:MRVideoControlAlertAlpha];
        _alertlable.textColor = [UIColor whiteColor];
        _alertlable.layer.cornerRadius = 10;
        _alertlable.layer.masksToBounds = YES;
        _alertlable.alpha = 0;
    }
    return _alertlable;
}

- (UIPanGestureRecognizer *)pan {
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    }
    return _pan;
}

@end

@implementation MRProgressSlider
- (CGRect)trackRectForBounds:(CGRect)bounds {
    return CGRectMake(0, self.bounds.size.height * 0.8, self.bounds.size.width, MRProgressWidth);
}

@end

@implementation UILabel (ConfigureAble)

- (void)configureWithTime:(NSString *)time isLeft:(BOOL)left {
    left ? [self setText:[NSString stringWithFormat:@"<<%@",time]] : [self setText:[NSString stringWithFormat:@">>%@",time]];
}
- (void)configureWithLight {
    self.text = [NSString stringWithFormat:@"亮度:%d%%",(int)([UIScreen mainScreen].brightness * 100)];
}

- (void)configureWithVolume:(float)volume {
    self.text = [NSString stringWithFormat:@"音量:%d%%",(int)(volume * 100)];
}

@end
