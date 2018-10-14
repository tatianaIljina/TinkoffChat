//
//  Themes.h
//  UI
//
//  Created by Татьяна Ильина on 14.10.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

#import <Foundation/Foundation.h> //для NSObject и строк NSString
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface Themes : NSObject
{
    UIColor *_theme1;
    UIColor *_theme2;
    UIColor *_theme3;
    
}
//объявление методов
@property (nonatomic, copy) UIColor *theme1;
@property (nonatomic, copy) UIColor *theme2;
@property (nonatomic, copy) UIColor *theme3;

@end

NS_ASSUME_NONNULL_END
