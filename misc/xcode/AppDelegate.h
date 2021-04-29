//
//  AppDelegate.h
//  ioquake3-iOS
//
//  Created by Tom Kidd on 4/28/21.
//  Copyright © 2021 ioquake. All rights reserved.
//

#ifndef AppDelegate_h
#define AppDelegate_h

#import <UIKit/UIKit.h>

@interface SDLLaunchScreenController : UIViewController

- (instancetype)init;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (void)loadView;

@end

@interface SDLUIKitDelegate : NSObject<UIApplicationDelegate>

+ (id)sharedAppDelegate;
+ (NSString *)getAppDelegateClassName;

- (void)hideLaunchScreen;

/* This property is marked as optional, and is only intended to be used when
 * the app's UI is storyboard-based. SDL is not storyboard-based, however
 * several major third-party ad APIs (e.g. Google admob) incorrectly assume this
 * property always exists, and will crash if it doesn't. */
@property (nonatomic) UIWindow *window;

@end

@interface AppDelegate : SDLUIKitDelegate {
    UINavigationController *rootNavigationController;     // required to dismiss the SettingsBaseViewController
    UIWindow *uiwindow;
}

@property (nonatomic, strong) UINavigationController *rootNavigationController;
@property (nonatomic, strong) UIWindow *uiwindow;


@end

#endif /* AppDelegate_h */
