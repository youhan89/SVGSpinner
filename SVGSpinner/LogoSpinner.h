//
//  LogoSpinner.h
//
//  Created by Johan Sögaard on 08/07/16.
//  Copyright © 2016 Johan Sögaard All rights reserved.
//  VISIT HTTPS://WWW.FLIMSY.SE FOR MORE AWESOME LIBS, APPS AND GAMES!
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LogoSpinner : NSObject

@property UIColor *lineColor, *fillColor;
@property float lineWidth;

@property float startAnimationDuration, startAnimationBeginTime, startAnimationFromValue, startAnimationToValue;
@property float endAnimationDuration, endAnimationFromValue, endAnimationToValue;
@property float groupAnimationDuration;


-(instancetype)initWithSVGFileNamed:(NSString*)filename;
-(instancetype)initWithSVGString:(NSString*)svgString;

-(UIView *)getUIViewForAnimationWithCGRect:(CGRect)frame;
-(CAShapeLayer*)getLayerForAnimationWithCGRect:(CGRect)frame;
-(void)addAnimationToView:(UIView*)view;

@end
