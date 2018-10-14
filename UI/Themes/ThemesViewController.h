//
//  ThemesViewController.h
//  UI
//
//  Created by Татьяна Ильина on 14.10.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Themes;
@protocol ThemesViewControllerDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface ThemesViewController : UIViewController
{
    //тип, имя 
    id<ThemesViewControllerDelegate> _delegate;
    Themes *_model;
}
@property (retain) id<ThemesViewControllerDelegate> delegate;
@property (assign) Themes *model;

@end

NS_ASSUME_NONNULL_END
