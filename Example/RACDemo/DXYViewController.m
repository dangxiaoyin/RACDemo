//
//  DXYViewController.m
//  RACDemo
//
//  Created by dangxy on 08/09/2020.
//  Copyright (c) 2020 dangxy. All rights reserved.
//

#import "DXYViewController.h"

@interface DXYViewController ()

@end

@implementation DXYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIViewController *vc = [[NSClassFromString(@"RACViewController") alloc] init];
    [self.view addSubview:vc.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
