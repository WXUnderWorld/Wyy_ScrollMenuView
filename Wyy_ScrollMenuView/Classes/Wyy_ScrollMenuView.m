//
//  Wyy_ScrollMenuView.m
//  Wyy_Module
//
//  Created by _YT_ on 2020/12/25.
//  Copyright © 2020 YT. All rights reserved.
//

#import "Wyy_ScrollMenuView.h"
#import "UIView+WyyFrame.h"
@interface Wyy_ScrollMenuView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *menuView;
@property (nonatomic,strong) UIImageView *lineView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIButton *tempBtn;
@property (nonatomic,strong) NSMutableArray *btnsArray;
@property (nonatomic,strong) Wyy_ScrollMenuConfig *config;

@end

#define Wyy_ScreenWidth UIScreen.mainScreen.bounds.size.width
@implementation Wyy_ScrollMenuView

- (instancetype)initWithFrame:(CGRect)frame config:(Wyy_ScrollMenuConfig *)config
{
    if (self = [super initWithFrame:frame]) {
        self.config = config;
        [self makeUI];
        [self setupWithConfig];
        
    }
    return self;
}

- (void)makeUI
{
    [self addSubview:self.menuView];
    [self addSubview:self.scrollView];
    [self.menuView addSubview:self.lineView];
}


- (void)setupWithConfig
{
    [self setupMenuWithConfig];
    [self setupScrollViewWithConfig];
}

- (void)setupMenuWithConfig
{
    if (self.config.menuTitles.count == 0) {
        return;
    }
    self.menuView.frame = CGRectMake(0, 0, self.frame.size.width, _config.menuHeight);
    [self.btnsArray removeAllObjects];
    
    NSArray *frameArray = _config.menuItemFrames;
    NSInteger i = 0;
    for (NSString *title in self.config.menuTitles) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i < frameArray.count) {
            btn.frame = CGRectFromString(frameArray[i]);
        }
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:self.config.normalColor forState:UIControlStateNormal];
        [btn setTitleColor:_config.selectedColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.normalFont;
        [btn addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.menuView addSubview:btn];
        btn.tag = i;
        [self.btnsArray addObject:btn];
        
        if (i == 0) {
            _tempBtn = btn;
            _tempBtn.selected = YES;
            _tempBtn.titleLabel.font = self.config.selectedFont;
            self.lineView.ys_x = _tempBtn.center.x - 20;
            self.lineView.ys_y = _tempBtn.ys_height - 3;
            self.lineView.ys_size = CGSizeMake(40, 6);
        }
        
        i ++;
    }
    
    self.menuView.contentSize = _config.menuContentSize;
}

- (void)setupScrollViewWithConfig
{
    if (self.config.childVCs.count == 0) {
        self.scrollView.frame = CGRectZero;
        return;
    }
    
    self.scrollView.scrollEnabled = self.config.canScroll;
    self.scrollView.frame = CGRectMake(0, _config.menuHeight, self.frame.size.width, self.frame.size.height - _config.menuHeight);
    self.scrollView.contentSize = CGSizeMake(Wyy_ScreenWidth * self.config.childVCs.count, 0);
    UIViewController *vc = _config.childVCs.firstObject;
    if (vc.view.superview == nil) {
        [self.scrollView addSubview:vc.view];
        vc.view.frame = _scrollView.bounds;
    }
}


- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    if (_config.childVCs.count) {
        [self.scrollView setContentOffset:CGPointMake(currentIndex * self.scrollView.bounds.size.width, 0) animated:NO];
    }
    [self setupCurrentSelectedAnimation:currentIndex];
}

#pragma mark---事件
- (void)menuButtonClicked:(UIButton *)btn
{
    [self setCurrentIndex:btn.tag];
}

- (void)changeButtonState:(UIButton *)btn
{
    btn.selected = !btn.selected;
    _tempBtn.selected = !btn.selected;
    _tempBtn.titleLabel.font = self.config.normalFont;
    _tempBtn = btn;
    _tempBtn.titleLabel.font = self.config.selectedFont;
}

- (void)setupCurrentSelectedAnimation:(NSInteger)index
{
    if (index < self.btnsArray.count) {
        UIButton *btn = self.btnsArray[index];
        [self setupMenuViewOffsetCenterForView:btn];
        [UIView animateWithDuration:0.25 animations:^{
            self.lineView.ys_centerX = btn.ys_centerX;
        }];
        [self changeButtonState:btn];
        
        if ([self.delegate respondsToSelector:@selector(scrollMenuViewDidSelectedIndex:)]) {
            [self.delegate scrollMenuViewDidSelectedIndex:index];
        }
    }
}

- (void)setupChildVC:(NSInteger)index
{
    if (index < self.config.childVCs.count) {
        UIViewController *vc = self.config.childVCs[index];
        if (vc.view.superview) {
            return;
        }
        vc.view.frame = _scrollView.bounds;
        vc.view.ys_x = _scrollView.ys_width * index;
        [_scrollView addSubview:vc.view];
    }
}

- (void)setupMenuViewOffsetCenterForView:(UIButton *)btn
{
    if (_config.layoutStyle == Wyy_ScrollMenuLayout_EqualWidth) {
        return;
    }
    
    CGFloat offsetx = btn.center.x - Wyy_ScreenWidth/2;
    CGFloat offsetMax = self.menuView.contentSize.width - Wyy_ScreenWidth;
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax && offsetMax >= 0){
        offsetx = offsetMax;
    }
    
    if (self.menuView.contentSize.width >= Wyy_ScreenWidth) {
        CGPoint offset = CGPointMake(offsetx, 0);
        [self.menuView setContentOffset:offset animated:YES];
    }
}

#pragma mark---UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    [self setupCurrentSelectedAnimation:index];
    [self setupChildVC:index];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scale = scrollView.contentOffset.x / scrollView.bounds.size.width;
    NSInteger index = ceilf(scale);
    [self setupChildVC:index];
}

#pragma mark---懒加载
- (UIImageView *)lineView
{
    if (!_lineView) {
        _lineView = [UIImageView new];
        _lineView.image = _config.lineImage ? _config.lineImage : [UIImage imageNamed:@"mall_odlist_line"];
        _lineView.backgroundColor = _config.lineColor;
        _lineView.hidden = _config.hideLine;
    }
    return _lineView;
}

- (UIScrollView *)menuView
{
    if (!_menuView) {
        _menuView = [UIScrollView new];
        _menuView.frame = CGRectMake(0, 0, self.frame.size.width, _config.menuHeight);
        _menuView.backgroundColor = _config.menuViewColor;
        _menuView.showsHorizontalScrollIndicator = NO;
    }
    return _menuView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.frame = CGRectMake(0, _config.menuHeight, self.frame.size.width, self.frame.size.height - _config.menuHeight);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (NSMutableArray *)btnsArray
{
    if (!_btnsArray) {
        _btnsArray = [NSMutableArray array];
    }
    return _btnsArray;
}

@end



@implementation Wyy_ScrollMenuConfig

- (UIColor *)menuViewColor
{
    if (!_menuViewColor) {
        _menuViewColor = UIColor.whiteColor;
    }
    return _menuViewColor;
}

- (UIFont *)normalFont
{
    if (!_normalFont) {
        _normalFont = [UIFont systemFontOfSize:14];
    }
    return _normalFont;
}

- (UIFont *)selectedFont
{
    if (!_selectedFont) {
        _selectedFont = [UIFont systemFontOfSize:14];
    }
    return _selectedFont;
}

- (UIColor *)normalColor
{
    if (!_normalColor) {
        _normalColor = [UIColor blackColor];
    }
    return _normalColor;
}

- (UIColor *)selectedColor
{
    if (!_selectedColor) {
        _selectedColor = [UIColor redColor];
    }
    return _selectedColor;
}

- (CGFloat)widthForText:(NSString *)text
{
    CGSize size = [text boundingRectWithSize:CGSizeMake(Wyy_ScreenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.normalFont} context:nil].size;
    
    return size.width + 10;
}

- (CGFloat)getMenuTitlesWidth
{
    CGFloat width = 0;
    for (NSString *text in _menuTitles) {
        width += [self widthForText:text];
    }
    return width;
}


- (NSArray *)menuItemFrames
{
    if (_layoutStyle == Wyy_ScrollMenuLayout_EqualWidth) {
        if (_menuTitles.count == 0) {
            return nil;
        }
        CGFloat itemW = Wyy_ScreenWidth / _menuTitles.count;
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 0; i < _menuTitles.count; i ++) {
            CGRect frame = CGRectMake(itemW * i, 0, itemW, _menuItemHeight);
            [array addObject:NSStringFromCGRect(frame)];
        }
        return array;
    }
    
    
    CGFloat spacing = _minSpacing;
    CGFloat totalSpacing = Wyy_ScreenWidth - _marginLeft - _marginRight - [self getMenuTitlesWidth];
    if (_menuTitles.count > 1 && totalSpacing > 0) {
        spacing = totalSpacing / (_menuTitles.count - 1);
    }
    if (spacing < _minSpacing) {
        spacing = _minSpacing;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    CGFloat sumX = _marginLeft;
    for (NSInteger i = 0; i < _menuTitles.count; i ++) {
        CGFloat itemW = [self widthForText:_menuTitles[i]];
        CGRect frame = CGRectMake(sumX, 0, itemW, _menuItemHeight);
        sumX += (itemW + spacing);
        [array addObject:NSStringFromCGRect(frame)];
    }
    sumX -= spacing;
    sumX += _marginRight;
    _menuContentSize = CGSizeMake(sumX, 0);
    
    return array;
}


@end

