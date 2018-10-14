//
//  ThemesViewController.m
//  UI
//
//  Created by Татьяна Ильина on 14.10.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

#import "ThemesViewController.h"
#import "Themes.h"
#import "ThemesViewControllerDelegate.h"



@implementation ThemesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[Themes alloc] init];
}

-(id<ThemesViewControllerDelegate>)delegate {
    return _delegate;
}

-(void)setDelegate:(id<ThemesViewControllerDelegate>)delegate {
    if (delegate != _delegate) {
        id<ThemesViewControllerDelegate> oldDelegate = _delegate;
        _delegate = [delegate retain];
        [oldDelegate release];
    }
}

-(Themes *)model {
    return _model;
}

-(void)setModel:(Themes *)model {
    @synchronized(self) {
        _model = model;
    }
}


- (IBAction)chooseTheme1:(id)sender {
    self.view.backgroundColor = [UIColor colorWithRed:0.80 green:1.00 blue:0.00 alpha:1.0];
    //[[self delegate] themesViewController:self didSelectTheme:[[self model] theme1]];
}
- (IBAction)chooseTheme2:(id)sender {
    self.view.backgroundColor = [UIColor colorWithRed:0.46 green:0.08 blue:0.53 alpha:1.0];
    //[[self delegate] themesViewController:self didSelectTheme:[[self model] theme2]];

}
- (IBAction)chooseTheme3:(id)sender {
    self.view.backgroundColor = [UIColor colorWithRed:0.08 green:0.73 blue:0.77 alpha:1.0];
    //[[self delegate] themesViewController:self didSelectTheme:[[self model] theme3]];
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
