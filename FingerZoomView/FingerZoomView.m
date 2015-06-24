//
//  FingerZoomView.m
//  FingerZoomView
//
//  Created by Showtime on 6/24/15.
//  Copyright (c) 2015 Showtime. All rights reserved.
//

#import "FingerZoomView.h"


#define DEFAULT_ZOOM_SIZE 100
#define DEFAULT_ZOOM_AREA 50

@implementation FingerZoomView
@synthesize zoomView;
@synthesize zoomViewSize;
@synthesize zoomAreaSize;
@synthesize lpgr;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)activateFingerZoom:(BOOL)activated{

    if (activated){
        
        lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        [self addGestureRecognizer:lpgr];
        
        if (!zoomViewSize) {
            zoomViewSize  = DEFAULT_ZOOM_SIZE;
        }
        
        if (!zoomAreaSize){
            zoomAreaSize = DEFAULT_ZOOM_AREA;
        }
        
        if (!zoomView){
            zoomView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, zoomViewSize, zoomViewSize)];
            zoomView.backgroundColor = [UIColor blackColor];
            zoomView.layer.borderColor = [[UIColor orangeColor] CGColor];
            zoomView.layer.borderWidth = 1.0f;
            zoomView.layer.cornerRadius = zoomViewSize/2;
            zoomView.clipsToBounds = YES;
            zoomView.hidden = YES;
        }
        
        [self addSubview:zoomView];
        NSLog(@"%@",zoomView);
        
    }else{
    
        if (lpgr){
        
            [self removeGestureRecognizer:lpgr];
            if(zoomView){
                [zoomView removeFromSuperview];
                zoomView = nil;
            }
        }
    }
    

}

-(UIImage*)getViewAsImage{

    CGRect rect = self.bounds;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(rect.size.width+zoomViewSize*2, rect.size.height+zoomViewSize*2), NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, zoomViewSize, zoomViewSize);
    [self.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


-(UIImage*)cropImageWithAxis:(CGPoint)point Image:(UIImage*)image{
    
    CGImageRef cr = CGImageCreateWithImageInRect([image CGImage], CGRectMake(zoomViewSize*2+point.x*2-zoomAreaSize, zoomViewSize*2+point.y*2-zoomAreaSize, zoomAreaSize*2, zoomAreaSize*2));
    UIImage *cropped = [UIImage imageWithCGImage:cr];
    
    return cropped;
}

-(void)setZoomViewSize:(CGFloat)z{
    
    zoomViewSize = z;
    if (zoomView){
    
        zoomView.frame = CGRectMake(0, 0, z, z);
        zoomView.layer.cornerRadius = z/2;
    }
    
}


-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    
    CGPoint point = [gestureRecognizer locationInView:self];
    zoomView.hidden = YES;
    UIImage *image = [self getViewAsImage];
    zoomView.hidden = NO;
    zoomView.image = [self cropImageWithAxis:point Image:image];
    CGRect frame =  zoomView.frame;
    frame.origin.x = point.x-zoomViewSize/2;
    frame.origin.y = point.y-zoomViewSize;
    zoomView.frame = frame;
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        //if needed do some initial setup or init of views here
        zoomView.hidden = NO;
        // NSLog(@"start");
    }
    else if(gestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        // NSLog(@"dragging");
    }
    else if(gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        //else do cleanup
        // NSLog(@"end");
        zoomView.hidden = YES;
        return;
    }
    
    
    
}
@end
