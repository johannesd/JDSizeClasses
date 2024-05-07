//
//  UIViewController+JDSizeClasses.m
//
//  Created by Johannes Dörr on 02.08.15.
//  Copyright © 2015 Johannes Dörr. All rights reserved.
//

#import "UIViewController+JDSizeClasses.h"
#import <objc/runtime.h>

@implementation UIViewController (JDSizeClasses)

+ (void)load
{
    Method original, swizzled;
    original = class_getInstanceMethod(self, @selector(traitCollectionDidChange:));
    swizzled = class_getInstanceMethod(self, @selector(jd_SizeClasses_traitCollectionDidChange:));
    method_exchangeImplementations(original, swizzled);
    
    original = class_getInstanceMethod(self, @selector(viewDidLoad));
    swizzled = class_getInstanceMethod(self, @selector(jd_SizeClasses_viewDidLoad));
    method_exchangeImplementations(original, swizzled);
}

- (JDUserInterfaceSizeClass)jd_verticalSizeClass
{
    if ([self respondsToSelector:@selector(traitCollection)]) {
        return (JDUserInterfaceSizeClass)self.traitCollection.verticalSizeClass;
    }
    else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return JDUserInterfaceSizeClassRegular;
        }
        else {
            if (self.view.frame.size.height > 414) { // (portrait) width of iPhone 6 plus
                return JDUserInterfaceSizeClassRegular;
            }
            else {
                return JDUserInterfaceSizeClassCompact;
            }
        }
    }
}

- (JDUserInterfaceSizeClass)jd_horizontalSizeClass
{
    if ([self respondsToSelector:@selector(traitCollection)]) {
        if (self.traitCollection.displayScale == 3 && self.view.bounds.size.width < self.view.bounds.size.height) {
            // Bugfix for iPhone 6 Plus
            return JDUserInterfaceSizeClassCompact;
        }
        return (JDUserInterfaceSizeClass)self.traitCollection.horizontalSizeClass;
    }
    else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            if (self.view.frame.size.width > 512) {
                return JDUserInterfaceSizeClassRegular;
            }
            else {
                return JDUserInterfaceSizeClassCompact;
            }
        }
        else {
            if (self.view.frame.size.width > 414) {
                return JDUserInterfaceSizeClassRegular;
            }
            else {
                return JDUserInterfaceSizeClassCompact;
            }
        }
    }
}

- (void)jd_SizeClasses_viewDidLoad
{
    [self jd_SizeClasses_viewDidLoad];
//    if (![self respondsToSelector:@selector(traitCollectionDidChange:)]) {
        if ([self respondsToSelector:@selector(jd_traitCollectionDidChange:)]) {
            [self jd_traitCollectionDidChange:nil];
        }
//    }
}

- (void)jd_SizeClasses_traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection
{
    if ([self respondsToSelector:@selector(jd_traitCollectionDidChange:)]) {
        [self jd_traitCollectionDidChange:previousTraitCollection];
    }
}

//- (void)jd_traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection
//{
//
//}

@end
