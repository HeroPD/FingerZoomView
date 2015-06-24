//
//  FingerZoomView.h
//  FingerZoomView
//
//  Created by Showtime on 6/24/15.
//  Copyright (c) 2015 Showtime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FingerZoomView : UIView

@property(nonatomic , strong) UIImageView *zoomView;
@property(nonatomic , assign) CGFloat zoomViewSize;
@property(nonatomic , assign) CGFloat zoomAreaSize;

@property(nonatomic) UILongPressGestureRecognizer *lpgr;


-(void)activateFingerZoom:(BOOL) activated;

@end
