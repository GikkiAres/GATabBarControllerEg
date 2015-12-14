//
//  GATabBarController.m
//  GATabBarControllerEg
//
//  Created by GikkiAres on 12/12/15.
//  Copyright © 2015 GikkiAres. All rights reserved.
//

#import "GATabBarController.h"
#import "GATabBarItem.h"

@interface GATabBarController () <GATabBarItemDelegate>

//padding,是两边的item距离边框的距离
//spacing,是item之间的距离

@property(nonatomic,strong) UITabBar *tabBarRef;

@property (nonatomic)CGFloat padding;
@property (nonatomic)CGFloat spacing;
@property (nonatomic)CGFloat widthTotal;
//状态栏去掉内容的空白部分
@property (nonatomic)CGFloat widthBlank;
@property (nonatomic)CGFloat heightTotal;
@property (nonatomic)CGFloat heightSystemTotal;
@property (nonatomic)CGFloat widthItem;
@property (nonatomic)CGFloat heightItem;
@property (nonatomic)NSMutableArray *marrItemCenterX;
@property (nonatomic,strong)NSMutableArray *marrTabBarItem;
//装载自定义Item的CustomTabBar
@property (nonatomic,strong)UIView *customTabBar;
//提示当前选项的IndicatorLabel
@property (nonatomic,strong)UILabel *lbIndicator;

@end

@implementation GATabBarController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initData];
}


- (void)initData {
  //设置tvc的背景色,实际是UIWindow下的UILayoutContainerView变色了.
  //self.view.backgroundColor = [UIColor greenColor];
  //初始化数据,是将数据设置成合法数据
  _tabBarRef = self.view.subviews[1];
  //实际变色的时tvc的rootvc的下一层tabBar的颜色改变.其余的相关多余view都是透明的.
  //_tabBarRef.backgroundColor = [UIColor greenColor];
  _widthTotal = _tabBarRef.bounds.size.width;
  //系统的tabBar高度和自定义的高度.
  _heightSystemTotal = _tabBarRef.bounds.size.height;
  _heightTotal = _heightSystemTotal;
  _padding = -1;
  _spacing = -1;
  _heightItem = _heightTotal;
  _widthItem = -1;
  _marrItemCenterX = [NSMutableArray array];
  _marrTabBarItem = [NSMutableArray array];
  _customTabBar = [UIView new];
  _customTabBar.frame = CGRectMake(0, _heightTotal-_heightSystemTotal, _widthTotal, _heightTotal);
  //关闭系统tabBar的按钮,防止穿透点击.
  //父视图设置为No,子视图也不会响应吧.
  //_tabBarRef.userInteractionEnabled = NO;
  [_tabBarRef addSubview:_customTabBar];
  //初始化选择指示器
  _lbIndicator = [UILabel new];
  _lbIndicator.backgroundColor = [UIColor blackColor];
  _lbIndicator.frame = CGRectMake(0, _heightTotal-2-1, 22, 2);
  [_customTabBar addSubview:_lbIndicator];
}

- (void)configImgArr:(NSArray *)arrImg SelectedImgArr:(NSArray *)arrSelectedImg  TitleArr:(NSArray *)arrTitle {
  //默认化数据,将一些参数设置为默认值.
  //初始化内边框间距和间距为等大的.
  if (_widthItem<0) {
    _widthItem = 100;
  }
  _widthBlank = _widthTotal-_widthItem*arrImg.count;
  if (_padding<0) {
    _padding = _widthBlank/(arrImg.count + 1);
    _spacing = _widthBlank/(arrImg.count + 1);
  }
  for (NSInteger index = 0; index <= arrImg.count-1; index++) {
    CGFloat x = 0;
    if (index==0) {
      x = _padding+_widthItem/2;
    }
    else
      x = _padding+_widthItem/2+(_widthItem+_spacing)*index;
    [_marrItemCenterX addObject:@(x)];
  }
  
  for (NSInteger index = 0; index <= arrImg.count-1; index++) {
    //从nibload出来的view,如果依靠约束布局,那么在手动调整view的frame后,子视图的frame会根据约束自动更新.
    GATabBarItem *item = [[[NSBundle mainBundle]loadNibNamed:@"GATabBarItem" owner:self options:nil]firstObject];
    CGRect frame = CGRectMake(0,0,_widthItem, _heightItem);
    item.frame = frame;
    //tabBar的frame更改有效果.
    //_tabBarRef.frame = frame;
    NSNumber *numberX = _marrItemCenterX[index];
    item.center = CGPointMake([numberX floatValue],_heightItem/2);
    item.lbTitle.text = arrTitle[index];
    item.image = arrImg[index];
    item.imageSelected = arrSelectedImg[index];
    item.index = index;
    item.delegate = self;
    item.lbBagde.hidden = YES;
    item.isSelected = NO;
    [_marrTabBarItem addObject:item];
    [_customTabBar addSubview:item];
  }
  //设置初始选择
  [self chooseTabBarItemAtIndex:0];
  //这句话非常重要,否则系统可能会把自己创建的UITabBarButton挡住自定义的view.
  [_tabBarRef bringSubviewToFront:_customTabBar];
}

- (void)chooseTabBarItemAtIndex:(NSInteger)index {
  self.selectedIndex = index;
  [_marrTabBarItem enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    if (idx == index) {
      [obj setValue:@(YES) forKey:@"isSelected"];
    }
    else {
      [obj setValue:@(NO) forKey:@"isSelected"];
    }
  }];
  [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    NSNumber *numberX = _marrItemCenterX[index];
    CGPoint center = _lbIndicator.center;
    center.x = [numberX floatValue];
    _lbIndicator.center = center;
  } completion:nil];
}

//必须要进行的初始化函数用config
//只是替换默认值的用update
- (void)updatePadding:(CGFloat)padding {
  _padding = padding;
  _widthBlank = _widthTotal-_widthItem*_marrTabBarItem.count;
  if (_padding>=0) {
    CGFloat _widthSpacingBlank = _widthBlank-_padding*2;
    _spacing = _widthSpacingBlank/(_marrTabBarItem.count-1);
  }
  for (NSInteger index = 0; index <= _marrTabBarItem.count-1; index++) {
    CGFloat xCenter = _padding+_widthItem/2+(_widthItem+_spacing)*index;
    _marrItemCenterX[index] = @(xCenter);
  }
  //跟新每个tabBarItem的中心点坐标
  for (NSInteger index = 0; index <= _marrTabBarItem.count-1; index++) {
    //调整项目的中心店坐标
    GATabBarItem *item = _marrTabBarItem[index];
    NSNumber *numberX = _marrItemCenterX[index];
    item.center = CGPointMake([numberX floatValue],_heightItem/2);
  }
  //设置位置指示器的位置
  CGPoint center = _lbIndicator.center;
  NSNumber *numberX = _marrItemCenterX[0];
  center.x = [numberX floatValue];
  _lbIndicator.center = center;

  
}

@end
