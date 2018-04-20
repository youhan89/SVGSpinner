//
//  LogoSpinner.h
//
//  Created by Johan Sögaard on 08/07/16.
//  Copyright © 2016 Johan Sögaard All rights reserved.
//  VISIT HTTPS://WWW.FLIMSY.SE FOR MORE AWESOME LIBS, APPS AND GAMES!
//

#import "LogoSpinner.h"
#import "PocketSVG.h"
@interface LogoSpinner()

@property CGPathRef path;
@property CAShapeLayer *shapeLayer;
@property CABasicAnimation *pathAnimationStart, *pathAnimationEnd;
@property CAAnimationGroup *animationGroup;
@property UIView *view;

@end

@implementation LogoSpinner

#pragma mark Setup
-(instancetype)initWithSVGFileNamed:(NSString*)filename
{
    self.path = [PocketSVG pathFromSVGFileNamed:filename];
    [self setDefaultValues];
    return self;
}

-(instancetype)initWithSVGString:(NSString*)svgString
{
    self.path = [PocketSVG pathFromSVGString:svgString];
    [self setDefaultValues];
    return self;
}

-(void)setDefaultValues
{
    self.lineColor = [UIColor blackColor];
    self.fillColor = [UIColor clearColor];
    self.lineWidth = 2.0f;
    
    self.startAnimationDuration = 2.0f;
    self.startAnimationBeginTime = 0.5f;
    self.startAnimationFromValue = 0.0f;
    self.startAnimationToValue = 1.0f;
    
    self.endAnimationDuration = 2.0f;
    self.endAnimationFromValue = 0.0f;
    self.endAnimationToValue = 1.0f;
    
    self.groupAnimationDuration = 2.5f;
}

-(void)buildLayersAndViews
{
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.path = self.path;
    
    self.shapeLayer.strokeColor = [self.lineColor CGColor];
    self.shapeLayer.lineWidth = self.lineWidth;
    
    self.shapeLayer.fillColor = [self.fillColor CGColor];
    
    self.pathAnimationStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    self.pathAnimationStart.duration = self.startAnimationDuration;
    self.pathAnimationStart.beginTime = self.startAnimationBeginTime;
    self.pathAnimationStart.fromValue = [NSNumber numberWithFloat:self.startAnimationFromValue];
    self.pathAnimationStart.toValue = [NSNumber numberWithFloat:self.startAnimationToValue];
    self.pathAnimationStart.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    self.pathAnimationEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    self.pathAnimationEnd.duration = self.endAnimationDuration;
    self.pathAnimationEnd.fromValue = [NSNumber numberWithFloat:self.endAnimationFromValue];
    self.pathAnimationEnd.toValue = [NSNumber numberWithFloat:self.endAnimationToValue];
    self.pathAnimationEnd.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    self.animationGroup = [CAAnimationGroup animation];
    [self.animationGroup setDuration:self.groupAnimationDuration];
    [self.animationGroup setRepeatCount:MAXFLOAT];
    [self.animationGroup setAnimations:[NSArray arrayWithObjects:self.pathAnimationStart,self.pathAnimationEnd, nil]];
    
    [self.shapeLayer addAnimation:self.animationGroup forKey:@"strokeStart"];
}


#pragma mark Get Animations by view or layer
-(UIView *)getUIViewForAnimationWithCGRect:(CGRect)frame
{
    [self buildLayersAndViews];
    
    [self.shapeLayer setFrame:frame];
    self.view = [[UIView alloc] initWithFrame:frame];
    [self.view.layer addSublayer:self.shapeLayer];
    
    return self.view;
}

-(void)addAnimationToView:(UIView*)view
{
    [view.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    [self buildLayersAndViews];
    
    CGRect boundingBox = CGPathGetBoundingBox(self.shapeLayer.path);
    
    NSLog(@"%@", [NSString stringWithFormat:@"frame width: %f, frame height : %f, box width: %f, box height: %f",view.frame.size.width,
           view.frame.size.height,boundingBox.size.width,boundingBox.size.height]);
    
    self.shapeLayer.transform = CATransform3DMakeScale(view.frame.size.width/boundingBox.size.width,
                                                       view.frame.size.height/boundingBox.size.height,
                                                       1);
    [self.shapeLayer setFrame:CGRectMake(0, 0, 0, 0)];
    [view.layer addSublayer:self.shapeLayer];
}


-(CAShapeLayer*)getLayerForAnimationWithCGRect:(CGRect)frame
{
    [self buildLayersAndViews];
    [self.shapeLayer setFrame:frame];
    return self.shapeLayer;
}

#pragma mark Lines & Colors
/*-(void)setLineWidth:(float)lineWidth
{
    self.lineWidth = lineWidth;
}

-(float)lineWidth
{
    return self.lineWidth;
}

-(void)setLineColor:(UIColor *)lineColor
{
    self.lineColor = lineColor;
}

-(UIColor*)lineColor
{
    return self.lineColor;
}

-(void)setFillColor:(UIColor *)fillColor
{
    self.fillColor = fillColor;
}

-(UIColor*)fillColor
{
    return self.fillColor;
}

#pragma mark StartAnimation properties
-(void)setStartAnimationDuration:(float)startAnimationDuration
{
    self.startAnimationDuration = startAnimationDuration;
}

-(float)startAnimationDuration
{
    return self.startAnimationDuration;
}

-(void)setStartAnimationBeginTime:(float)startAnimationBeginTime
{
    self.startAnimationBeginTime = startAnimationBeginTime;
}

-(float)startAnimationBeginTime
{
    return self.startAnimationBeginTime;
}

-(void)setStartAnimationToValue:(float)startAnimationToValue
{
    self.startAnimationToValue = startAnimationToValue;
}

-(float)startAnimationToValue
{
    return self.startAnimationToValue;
}

-(void)setStartAnimationFromValue:(float)startAnimationFromValue
{
    self.startAnimationFromValue = startAnimationFromValue;
}

-(float)startAnimationFromValue
{
    return self.startAnimationFromValue;
}

#pragma mark EndAnimation properties
-(void)setEndAnimationDuration:(float)endAnimationDuration
{
    self.endAnimationDuration = endAnimationDuration;
}

-(float)endAnimationDuration
{
    return self.endAnimationDuration;
}

-(void)setEndAnimationToValue:(float)endAnimationToValue
{
    self.endAnimationToValue = endAnimationToValue;
}

-(float)endAnimationToValue
{
    return self.endAnimationToValue;
}

-(void)setEndAnimationFromValue:(float)endAnimationFromValue
{
    self.endAnimationFromValue = endAnimationFromValue;
}

-(float)endAnimationFromValue
{
    return self.endAnimationFromValue;
}
*/
@end
