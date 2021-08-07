//
//  Wyy_ScrollMenuView.h
//  Wyy_Module
//
//  Created by _YT_ on 2020/12/25.
//  Copyright © 2020 YT. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class Wyy_ScrollMenuConfig;
@protocol Wyy_ScrollMenuViewDelegate <NSObject>

- (void)scrollMenuViewDidSelectedIndex:(NSInteger)index;

@end


@interface Wyy_ScrollMenuView : UIView

- (instancetype)initWithFrame:(CGRect)frame config:(Wyy_ScrollMenuConfig *)config;

@property (nonatomic,assign) NSInteger currentIndex;

@property (nonatomic,weak) id <Wyy_ScrollMenuViewDelegate> delegate;

@end



typedef enum : NSUInteger {
    Wyy_ScrollMenuLayout_EqualWidth = 0,  //等宽度
    Wyy_ScrollMenuLayout_EqualSpacing = 1,//等间距
} Wyy_ScrollMenuViewLayoutStyle;

@interface Wyy_ScrollMenuConfig : NSObject
//菜单标题
@property (nonatomic,strong) NSArray <NSString *>*menuTitles;
//左边距
@property (nonatomic,assign) CGFloat marginLeft;
//右边距
@property (nonatomic,assign) CGFloat marginRight;
//最小间距
@property (nonatomic,assign) CGFloat minSpacing;
//菜单view高度
@property (nonatomic,assign) CGFloat menuHeight;
//标题高度
@property (nonatomic,assign) CGFloat menuItemHeight;
//菜单背景颜色
@property (nonatomic,strong) UIColor *menuViewColor;
//默认字体
@property (nonatomic,strong) UIFont *normalFont;
//选中字体
@property (nonatomic,strong) UIFont *selectedFont;
//默认颜色
@property (nonatomic,strong) UIColor *normalColor;
//选中颜色
@property (nonatomic,strong) UIColor *selectedColor;
//底部标识线颜色
@property (nonatomic,strong) UIColor *lineColor;
//底部图片
@property (nonatomic,strong) UIImage *lineImage;
//是否隐藏底部图片
@property (nonatomic,assign) BOOL hideLine;
//子控制器,不传的话只显示头部menu
@property (nonatomic,strong) NSArray <UIViewController *>*childVCs;
//每个标题的frame
@property (nonatomic,strong,readonly) NSArray *menuItemFrames;
//菜单contentSize
@property (nonatomic,assign,readonly) CGSize menuContentSize;
//是否可以左右滑动,默认no
@property (nonatomic,assign) BOOL canScroll;
//排版方式，默认Wyy-ScrollMenuLayout_EqualWidth等宽，总宽度不超过屏幕宽度情况下
@property (nonatomic,assign) Wyy_ScrollMenuViewLayoutStyle layoutStyle;

@end


NS_ASSUME_NONNULL_END
