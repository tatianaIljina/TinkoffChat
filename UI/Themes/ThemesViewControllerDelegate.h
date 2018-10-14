//
//  ThemesViewControllerDelegate.h
//  UI
//
//  Created by Татьяна Ильина on 14.10.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ThemesViewController;
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@protocol ThemesViewControllerDelegate <NSObject>

- (void)themesViewController: (ThemesViewController *)controller didSelectTheme:(UIColor *)selectedTheme;

@end

NS_ASSUME_NONNULL_END
