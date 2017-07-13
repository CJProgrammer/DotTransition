//
//  ViewController.m
//  DotTransition
//
//  Created by CJ on 2017/7/13.
//  Copyright © 2017年 CJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.button.layer.cornerRadius = 25;
    self.button.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
