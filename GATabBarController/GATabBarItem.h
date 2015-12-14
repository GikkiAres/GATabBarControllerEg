//
//  GATabBarItem.h
//  GATabBarControllerEg
//
//  Created by GikkiAres on 12/12/15.
//  Copyright © 2015 GikkiAres. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GATabBarItem;
@protocol GATabBarItemDelegate <NSObject>

- (void)chooseTabBarItemAtIndex:(NSInteger)index;

@end

@interface GATabBarItem : UIView
@property (nonatomic,strong) NSString *title;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *lbBagde;
@property (nonatomic) NSInteger index;
@property (nonatomic) BOOL isSelected;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIImage *imageSelected;
@property (nonatomic,strong) id<GATabBarItemDelegate> delegate;

@end
