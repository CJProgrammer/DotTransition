//
//  TransitionManager.h
//  DotTransition
//
//  Created by CJ on 2017/7/13.
//  Copyright © 2017年 CJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TransitionManager : NSObject <UIViewControllerAnimatedTransitioning>

// 初始化
+ (instancetype)transitionManager:(BOOL)presenting;

- (instancetype)initWithPresenting:(BOOL)presenting;

@end
