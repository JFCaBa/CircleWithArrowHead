//
//  Created by Robert Jose Catala on 19/08/18.
//  Copyright © 2018 Jose Catala. All rights reserved.
//

#import "JFCCircularArrowHead.h"

@interface JFCCircularArrowHead ()


@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation JFCCircularArrowHead

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setUpView];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self updateView];
}

- (void)setUpView
{
    self.startAngle  = -M_PI_2;
    self.endAngle    = M_PI * 3 / 4;
    self.fillColor   = [UIColor blueColor];
    self.strokeColor = [UIColor whiteColor];
    self.circleColor = [UIColor lightGrayColor];
    self.lineWidth   = 0;
    self.arrowWidth  = 30;
    self.clockwise   = true;
    self.arrowHead = 50;
    
    self.shapeLayer = [[CAShapeLayer alloc]init];
    self.circleLayer = [[CAShapeLayer alloc]init];
    
    [self updateView];
}

/**
 Update path based upon properties.
 
 Note, in this example, I'm just updating the path property of some CAShapeLayer, but if you wanted
 to have some custom color pattern that was revealed by updating this path, you could use this CAShapeLayer
 as a mask instead, revealing some colored pattern (or whatever) instead.
 */
- (void)updateView
{
    [self drawFullCircle];
    
    CGRect rect = self.bounds;
    
    CGPoint center = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0);
    CGFloat radius = MIN(rect.size.width / 2.0, rect.size.height / 2.0) - (self.lineWidth + self.arrowHead);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(center.x + cosf(self.startAngle) * (radius + self.arrowWidth / 2.0), center.y + sinf(self.startAngle) * (radius + self.arrowWidth / 2.0))];
    
    [path addArcWithCenter:center radius:radius + self.arrowWidth / 2.0 startAngle:self.startAngle endAngle:self.endAngle clockwise:self.clockwise];
    
    [path addLineToPoint:CGPointMake(center.x + cosf(self.endAngle) * (radius + self.arrowHead), center.y + sinf(self.endAngle) * (radius + self.arrowHead))];
    
    CGFloat theta = asinf((self.arrowHead * 1.5) / radius / 2.0) * (self.clockwise ? 1.0 : -1.0);
    CGFloat pointDistance = radius / cosf(theta);
    
    [path addLineToPoint:CGPointMake(center.x + cosf(self.endAngle + theta) * pointDistance, center.y + sinf(self.endAngle + theta) * pointDistance)];
    
    [path addLineToPoint:CGPointMake(center.x + cosf(self.endAngle) * (radius - self.arrowHead), center.y + sinf(self.endAngle) * (radius - self.arrowHead))];
    
    [path addLineToPoint:CGPointMake(center.x + cosf(self.endAngle) * (radius - self.arrowWidth / 2.0), center.y + sinf(self.endAngle) * (radius - self.arrowWidth / 2.0))];
    
    [path addArcWithCenter:center radius:radius - self.arrowWidth / 2 startAngle:self.endAngle endAngle:self.startAngle clockwise:!self.clockwise];
    
    [path closePath];
    
    [self.shapeLayer setPath:path.CGPath];
    [self.shapeLayer setStrokeColor:[UIColor clearColor].CGColor];
    [self.shapeLayer setFillColor:self.fillColor.CGColor];
    [self.shapeLayer setLineWidth:0];
    
    [self.layer addSublayer:self.shapeLayer];
}

- (void) drawFullCircle
{
    CGRect rect = self.bounds;
    
    CGPoint center = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0);
    CGFloat radius = MIN(rect.size.width / 2.0, rect.size.height / 2.0) - (self.lineWidth + self.arrowHead) / 2;
    
    //Create the gray circle
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:center radius:(radius - self.arrowHead / 2) startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    [self.circleLayer setPath:bezierPath.CGPath];
    [self.circleLayer setStrokeColor:self.circleColor.CGColor];
    [self.circleLayer setFillColor:[UIColor clearColor].CGColor];
    [self.circleLayer setLineWidth:_arrowWidth];
    //[grayCirclePath setStrokeEnd:50/100];
    [self.layer addSublayer:self.circleLayer];
}


- (void)setStartAngle:(CGFloat)startAngle {
    _startAngle = startAngle;
    [self updateView];
}

- (void)setEndAngle:(CGFloat)endAngle {
    _endAngle = endAngle;
    [self updateView];
}

- (void)setClockwise:(BOOL)clockwise {
    _clockwise = clockwise;
    [self updateView];
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    [self updateView];
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
    [self updateView];
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    [self updateView];
}

- (void)setArrowWidth:(CGFloat)arrowWidth {
    _arrowWidth = arrowWidth;
    [self updateView];
}
@end
