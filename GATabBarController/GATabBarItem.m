//
//  GATabBarItem.m
//  GATabBarControllerEg
//
//  Created by GikkiAres on 12/12/15.
//  Copyright © 2015 GikkiAres. All rights reserved.
//

#import "GATabBarItem.h"

@implementation GATabBarItem

- (void)setIsSelected:(BOOL)isSelected {
  _isSelected = isSelected;
  if (_isSelected) {
    _imageView.image = _imageSelected;
  }
  else {
    _imageView.image = _image;
  }
}

- (IBAction)clickTabBarButton:(id)sender {
  if([self.delegate respondsToSelector:@selector(chooseTabBarItemAtIndex:)]) {
    [self.delegate chooseTabBarItemAtIndex:self.index];
  }
}

@end
