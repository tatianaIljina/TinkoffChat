//
//  Themes.m
//  UI
//
//  Created by Татьяна Ильина on 14.10.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

//implementation file
#import "Themes.h"
#import <Foundation/Foundation.h>

@implementation Themes
-(id)init //метод экземпляра
{
    [super init];
    _theme1 = [UIColor colorWithRed:0.80 green:1.00 blue:0.00 alpha:1.0];
    _theme2 = [UIColor colorWithRed:0.46 green:0.08 blue:0.53 alpha:1.0];
    _theme3 = [UIColor colorWithRed:0.08 green:0.73 blue:0.77 alpha:1.0];
    
    return self;
    
}

- (void)setTheme1:(UIColor *)theme1
{
    id oldTheme1 = _theme1;
    _theme1 = [theme1 copy];
    [oldTheme1 release];
}

-(UIColor *)theme1
{
    return _theme1;
}

- (void)setTheme2:(UIColor *)theme2
{
    id oldTheme2 = _theme1;
    _theme2 = [theme2 copy];
    [oldTheme2 release];
}

-(UIColor *)theme2
{
    return _theme2;
}

- (void)setTheme3:(UIColor *)theme3
{
    id oldTheme3 = _theme3;
    _theme3 = [theme3 copy];
    [oldTheme3 release];
}

-(UIColor *)theme3
{
    return _theme3;
}

//когда счетчик ссылок будет равняться нулю
-(void)dealloc
{
    [[self theme1] release];
    [[self theme2] release];
    [[self theme3] release];
    [super dealloc];
}


@end
