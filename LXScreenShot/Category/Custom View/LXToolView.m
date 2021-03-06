//
//  LXToolView.m
//  LXScreenShot
//
//  Created by Leexin on 16/4/18.
//  Copyright © 2016年 Garden.Lee. All rights reserved.
//

#import "LXToolView.h"
#import "UIView+Extensions.h"

static const CGFloat kToolButtonSpace = 5.f;
static const CGFloat kToolButtonWidth = 25.f;
static const CGFloat kToolButtonHeight = 20.f;

@interface LXToolView () <LXToolPopViewDelegate>

@property (nonatomic, strong) UIButton *rectButton;
@property (nonatomic, strong) UIButton *circleButton;
@property (nonatomic, strong) UIButton *arrowButton;
@property (nonatomic, strong) UIButton *penButton;
@property (nonatomic, strong) UIButton *textButton;
@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) LXToolPopView *popView;

@end

@implementation LXToolView

#pragma mark - Life Cycle

- (void)dealloc {
    
    NSLog(@"dealloc LXToolView");
}

- (instancetype)init {
    
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 200.f,55.f)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 2.f;
        self.layer.masksToBounds = YES;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    
    self.rectButton.frame = CGRectMake(kToolButtonSpace, 0, kToolButtonWidth, kToolButtonHeight);
    [self addSubview:self.rectButton];
    
    self.circleButton.frame = self.rectButton.frame;
    self.circleButton.left = self.rectButton.right + kToolButtonSpace;
    [self addSubview:self.circleButton];
    
    self.arrowButton.frame = self.rectButton.frame;
    self.arrowButton.left = self.circleButton.right + kToolButtonSpace;
    [self addSubview:self.arrowButton];
    
    self.penButton.frame = self.rectButton.frame;
    self.penButton.left = self.arrowButton.right + kToolButtonSpace;
    [self addSubview:self.penButton];
    
    self.textButton.frame = self.rectButton.frame;
    self.textButton.left = self.penButton.right + kToolButtonSpace;
    [self addSubview:self.textButton];
    
    self.shareButton.frame = self.rectButton.frame;
    self.shareButton.left = self.textButton.right + kToolButtonSpace;
    [self addSubview:self.shareButton];
    
    [self addSubview:self.popView];
}

#pragma mark - Custom Method

- (void)showPopViewWithClickedButton:(UIButton *)clickButton { // 弹出PopView
    
    if (clickButton.tag == LXToolButtonTypeShare) {
        [self.popView hidePopView];
        return;
    }
    NSInteger index = clickButton.tag - LXToolButtonTypeRect;
    CGFloat piontX = index * (kToolButtonWidth + kToolButtonSpace) + kToolButtonWidth / 2;
    if (piontX < self.popView.width) {
        [self.popView showPopViewWithArrowPoint:CGPointMake(piontX, 0)];
    }
}

- (void)setButtonSelectedWithClickedButton:(UIButton *)clickButton { // 设置所有Button的Selected属性
    
    for (NSInteger i = LXToolButtonTypeRect; i < LXToolButtonTypeRect + 6; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:i];
        if (i != clickButton.tag) {
            button.selected = NO;
        }
    }
}

#pragma mark - LXToolPopViewDelegate

- (void)toolPopView:(LXToolPopView *)popView clickedSizeButtonType:(ToolPopViewLineWidthType)type {
    
    if ([self.delegate respondsToSelector:@selector(toolView:didSelectLineWith:)]) {
        [self.delegate toolView:self didSelectLineWith:type];
    }
}

- (void)toolPopView:(LXToolPopView *)popView clickedColorButtonWithColor:(UIColor *)color {
    
    if ([self.delegate respondsToSelector:@selector(toolView:didSelectColor:)]) {
        [self.delegate toolView:self didSelectColor:color];
    }
}

#pragma mark - Event Response

- (void)onToolButtonClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self showPopViewWithClickedButton:sender];
        [self setButtonSelectedWithClickedButton:sender];
    } else {
        [self.popView hidePopView];
    }
    if ([self.delegate respondsToSelector:@selector(toolView:didClickToolButton:)]) {
        [self.delegate toolView:self didClickToolButton:sender];
    }
}

#pragma mark - Getters

- (UIButton *)rectButton {
    
    if (!_rectButton) {
        _rectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rectButton.tag = LXToolButtonTypeRect;
        _rectButton.titleLabel.font = [UIFont systemFontOfSize:10.f];
        [_rectButton setTitle:@"矩形" forState:UIControlStateNormal];
        [_rectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rectButton setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [_rectButton addTarget:self action:@selector(onToolButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rectButton;
}

- (UIButton *)circleButton {
    
    if (!_circleButton) {
        _circleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _circleButton.tag = LXToolButtonTypeCircle;
        _circleButton.titleLabel.font = [UIFont systemFontOfSize:10.f];
        [_circleButton setTitle:@"圆形" forState:UIControlStateNormal];
        [_circleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_circleButton setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [_circleButton addTarget:self action:@selector(onToolButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _circleButton;
}

- (UIButton *)arrowButton {
    
    if (!_arrowButton) {
        _arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _arrowButton.tag = LXToolButtonTypeArrow;
        _arrowButton.titleLabel.font = [UIFont systemFontOfSize:10.f];
        [_arrowButton setTitle:@"箭头" forState:UIControlStateNormal];
        [_arrowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_arrowButton setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [_arrowButton addTarget:self action:@selector(onToolButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrowButton;
}

- (UIButton *)penButton {
    
    if (!_penButton) {
        _penButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _penButton.tag = LXToolButtonTypePen;
        _penButton.titleLabel.font = [UIFont systemFontOfSize:10.f];
        [_penButton setTitle:@"手写" forState:UIControlStateNormal];
        [_penButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_penButton setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [_penButton addTarget:self action:@selector(onToolButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _penButton;
}

- (UIButton *)textButton {
    
    if (!_textButton) {
        _textButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _textButton.tag = LXToolButtonTypeText;
        _textButton.titleLabel.font = [UIFont systemFontOfSize:10.f];
        [_textButton setTitle:@"文字" forState:UIControlStateNormal];
        [_textButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_textButton setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [_textButton addTarget:self action:@selector(onToolButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _textButton;
}

- (UIButton *)shareButton {
    
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareButton.tag = LXToolButtonTypeShare;
        _shareButton.titleLabel.font = [UIFont systemFontOfSize:10.f];
        [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
        [_shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_shareButton setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [_shareButton addTarget:self action:@selector(onToolButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

- (LXToolPopView *)popView {
    
    if (!_popView) {
        _popView = [[LXToolPopView alloc] init];
        _popView.delegate = self;
        _popView.left = kToolButtonSpace;
        _popView.top = kToolButtonHeight + kToolButtonSpace;
    }
    return _popView;
}

@end
