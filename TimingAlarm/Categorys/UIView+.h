//
//  UIView.h
//  UXKit
//
//  Created by OranWu on 13-5-8.
//  Copyright (c) 2013年 Oran Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(Additions)

@property (nonatomic, readwrite) float top;
@property (nonatomic, readwrite) float left;
@property (nonatomic, readwrite) float bottom;
@property (nonatomic, readwrite) float right;

@property (nonatomic, readwrite) float width;
@property (nonatomic, readwrite) float height;

@property (nonatomic, readwrite) CGPoint origin;
@property (nonatomic, readwrite) CGSize  size;

@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat centerX;
@property (nonatomic, assign)CGFloat centerY;
@property(nonatomic, assign) IBInspectable CGFloat borderWidth;
@property(nonatomic, assign) IBInspectable UIColor *borderColor;
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;


- (id)initWithIOS7Frame:(CGRect)frame;

- (void)runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;

- (void)rotateWithAngle:(CGFloat)angel animateDuration:(CGFloat)duration;

- (void)setScale:(float)scale;
- (void)setOrigin:(CGPoint)origin Scale:(float)scale;
- (void)setCenter:(CGPoint)center Scale:(float)scale;
- (void)setRightTop:(CGPoint)origin Scale:(float)scale;


- (void)addImage:(UIImage*)image atPoint:(CGPoint)point;
- (void)removeAllSubviews;

- (void)drawCircleAtCenterPoint:(CGPoint)center radius:(float)radius fill:(BOOL)isFill;

- (NSArray *)animationArrayWithAngle:(double)angle;
- (NSArray *)animationArrayWithOffsetPoint:(CGPoint)offsetPoint;
- (NSArray *)animationArrayWithDistance:(double)distance;

- (NSArray *)animationArrayDistance:(double)distance;
@end
