//
//  GATabBarController.h
//  GATabBarControllerEg
//
//  Created by GikkiAres on 12/12/15.
//  Copyright © 2015 GikkiAres. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GATabBarController : UITabBarController


-(void)configImgArr:(NSArray *)arrImg SelectedImgArr:(NSArray *)arrSelectedImg TitleArr:(NSArray *)arrTitle;

-(void)updatePadding:(CGFloat)padding;

@end
