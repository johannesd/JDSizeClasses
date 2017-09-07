//
//  UIViewController+JDSizeClasses.h
//
//  Created by Johannes Dörr on 02.08.15.
//  Copyright © 2015 Johannes Dörr. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, JDUserInterfaceSizeClass) {
    JDUserInterfaceSizeClassUnspecified = 0,
    JDUserInterfaceSizeClassCompact     = 1,
    JDUserInterfaceSizeClassRegular     = 2,
};


@interface UIViewController (JDSizeClasses)

@property (nonatomic, readonly) JDUserInterfaceSizeClass jd_verticalSizeClass;
@property (nonatomic, readonly) JDUserInterfaceSizeClass jd_horizontalSizeClass;

- (void)jd_traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection;
    
@end
