//
//  NextViewController.m
//  DotTransition
//
//  Created by CJ on 2017/7/13.
//  Copyright © 2017年 CJ. All rights reserved.
//

#import "NextViewController.h"
#import "TransitionManager.h"

@interface NextViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.transitioningDelegate = self;
}

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [TransitionManager transitionManager:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [TransitionManager transitionManager:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
