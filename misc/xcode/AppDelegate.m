//
//  AppDelegate.m
//  ioquake3-iOS
//
//  Created by Tom Kidd on 4/28/21.
//  Copyright © 2021 ioquake. All rights reserved.
//

#import "AppDelegate.h"
//#if TARGET_OS_TV
//#import "ioquake3_tvOS-Swift.h"
//#else
//#import "ioquake3_iOS-Swift.h"
//#endif

@implementation SDLUIKitDelegate (customDelegate)

// hijack the the SDL_UIKitAppDelegate to use the UIApplicationDelegate we implement here
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
+ (NSString *)getAppDelegateClassName {
    return @"AppDelegate";
}
#pragma clang diagnostic pop

@end

@implementation AppDelegate
@synthesize rootNavigationController, uiwindow;

#pragma mark -
#pragma mark AppDelegate methods
- (id)init {
    if ((self = [super init])) {
        rootNavigationController = nil;
        uiwindow = nil;
    }
    return self;
}

- (BOOL)prefersStatusBarHidden {
   return NO;
}

void Sys_Startup( int argc, char **argv );

// override the direct execution of SDL_main to allow us to implement our own frontend
- (void)postFinishLaunch
{
    [self performSelector:@selector(hideLaunchScreen) withObject:nil afterDelay:0.0];

    self.uiwindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.uiwindow.backgroundColor = [UIColor blackColor];
    
    [self.uiwindow makeKeyAndVisible];
    
    // TODO: Make the Obj-C equiv of this
    
//#if os(tvOS)
//let documentsDir = try! FileManager().url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).path
//#else
//let documentsDir = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).path
//#endif
//
//Sys_SetHomeDir(documentsDir)
    
    int argc = 67;
    
    char *argv[] = {
        "quake3",
        "+set",
        "com_basegame",
        "baseq3",
        "+set",
        "r_useOpenGLES",
        "1",
        "+set",
        "r_mode",
        "-1",
        "+set",
        "r_customwidth",
        (char *)[[NSString stringWithFormat:@"%i", (int)[[UIScreen mainScreen] nativeBounds].size.height] UTF8String],
        "+set",
        "r_customheight",
        (char *)[[NSString stringWithFormat:@"%i", (int)[[UIScreen mainScreen] nativeBounds].size.width] UTF8String],
        "+set",
        "s_sdlSpeed",
        "44100",
        "+set",
        "r_useHiDPI",
        "1",
        "+set",
        "r_fullscreen",
        "1",
        "+set",
        "in_joystick",
        "1",
        "+set",
        "in_joystickUseAnalog",
        "1",
        "+bind",
        "PAD0_RIGHTTRIGGER",
        "\"+attack\"",
        "+bind",
        "PAD0_LEFTSTICK_UP",
        "\"+forward\"",
        "+bind",
        "PAD0_LEFTSTICK_DOWN",
        "\"+back\"",
        "+bind",
        "PAD0_LEFTSTICK_LEFT",
        "\"+moveleft\"",
        "+bind",
        "PAD0_LEFTSTICK_RIGHT",
        "\"+moveright\"",
        "+bind",
        "PAD0_RIGHTSTICK_UP",
        "\"+lookup\"",
        "+bind",
        "PAD0_RIGHTSTICK_DOWN",
        "\"+lookdown\"",
        "+bind",
        "PAD0_RIGHTSTICK_LEFT",
        "\"+left\"",
        "+bind",
        "PAD0_RIGHTSTICK_RIGHT",
        "\"+right\"",
        "+bind",
        "PAD0_A",
        "\"+moveup\"",
        "+bind",
        "PAD0_LEFTSHOULDER",
        "\"weapnext\"",
        "+bind",
        "PAD0_RIGHTSHOULDER",
        "\"weapprev\"",
    };
    
    Sys_Startup(argc, argv);
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [super applicationDidReceiveMemoryWarning:application];
}

// true multitasking with SDL works only on 4.2 and above; we close the game to avoid a black screen at return
- (void)applicationWillResignActive:(UIApplication *)application {
    [super applicationWillResignActive:application];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    [super applicationDidFinishLaunching:application];
}

// dummy function to prevent linkage fail
int SDL_main(int argc, char **argv) {
    return 0;
}

@end
