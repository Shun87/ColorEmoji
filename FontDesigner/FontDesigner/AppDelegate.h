//
//  AppDelegate.h
//  FontDesigner
//
//  Created by chenshun on 13-5-5.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import <UIKit/UIKit.h>
#define FreeApp 1

#if FreeApp
#import "GADBannerView.h"
#endif
@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate
#if FreeApp
,GADBannerViewDelegate>
#else
>
#endif
{
    NSMutableArray *systemFontFamily;
#if FreeApp
     GADBannerView *adBanner;
#endif
}
@property (nonatomic, retain)NSMutableArray *systemFontFamily;
@property (strong, nonatomic) UIWindow *window;
#if FreeApp
@property (nonatomic, retain) GADBannerView *adBanner;
#endif
@property (strong, nonatomic) UITabBarController *tabBarController;

@end
