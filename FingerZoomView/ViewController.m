//
//  ViewController.m
//  FingerZoomView
//
//  Created by Showtime on 6/24/15.
//  Copyright (c) 2015 Showtime. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize fingerZoomView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [fingerZoomView activateFingerZoom:YES];
    fingerZoomView.zoomViewSize = 200.0f;
    fingerZoomView.zoomAreaSize = 100.0f;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
