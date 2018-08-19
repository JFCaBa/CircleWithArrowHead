//
//  CircleWithArrowHead.m
//  CircleWithArrowHead
//
//  Created by Jose Catala on 19/08/2018.
//

#import "CircleWithArrowHead.h"

@interface CircleWithArrowHead()
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@end

@implementation CircleWithArrowHead

@synthesize fillColor = _fillColor;
@synthesize circleColor = _circleColor;
@synthesize startAngle = _startAngle;
@synthesize endAngle = _endAngle;
@synthesize arrowWidth = _arrowWidth;
@synthesize arrowHead = _arrowHead;
@synthesize clockwise = _clockwise;

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setUp];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self updateView];
}

- (void)setUp
{
    self.startAngle  = 0;
    self.endAngle    = M_PI * 4 / 6;
    self.fillColor   = [UIColor greenColor];
    self.circleColor = [UIColor lightGrayColor];
    self.arrowWidth  = 30;
    self.clockwise   = true;
    self.arrowHead = 50;
    
    self.shapeLayer = [[CAShapeLayer alloc]init];
    self.circleLayer = [[CAShapeLayer alloc]init];
    
    [self updateView];
}

- (void)updateView
{
    [self createTheGrayCircle];
    
    CGRect rect = self.bounds;
    
    CGPoint center = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0);
    CGFloat radius = MIN(rect.size.width / 2.0, rect.size.height / 2.0) - self.arrowHead;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(center.x + cosf(self.startAngle) * (radius + self.arrowWidth / 2.0),
                                  center.y + sinf(self.startAngle) * (radius + self.arrowWidth / 2.0))];
    
    [path addArcWithCenter:center
                    radius:radius + self.arrowWidth / 2.0
                startAngle:self.startAngle
                  endAngle:self.endAngle
                 clockwise:self.clockwise];
    
    [path addLineToPoint:CGPointMake(center.x + cosf(self.endAngle) * (radius + self.arrowHead),
                                     center.y + sinf(self.endAngle) * (radius + self.arrowHead))];
    
    CGFloat theta = asinf((self.arrowHead * 1.5) / radius / 2.0) * (self.clockwise ? 1.0 : -1.0);
    CGFloat pointDistance = radius / cosf(theta);
    
    [path addLineToPoint:CGPointMake(center.x + cosf(self.endAngle + theta) * pointDistance,
                                     center.y + sinf(self.endAngle + theta) * pointDistance)];
    
    [path addLineToPoint:CGPointMake(center.x + cosf(self.endAngle) * (radius - self.arrowHead),
                                     center.y + sinf(self.endAngle) * (radius - self.arrowHead))];
    
    [path addLineToPoint:CGPointMake(center.x + cosf(self.endAngle) * (radius - self.arrowWidth / 2.0),
                                     center.y + sinf(self.endAngle) * (radius - self.arrowWidth / 2.0))];
    
    [path addArcWithCenter:center
                    radius:radius - self.arrowWidth / 2
                startAngle:self.endAngle
                  endAngle:self.startAngle
                 clockwise:!self.clockwise];
    
    [path closePath];
    
    [self.shapeLayer setPath:path.CGPath];
    [self.shapeLayer setFillColor:self.fillColor.CGColor];
    [self.shapeLayer setStrokeColor:[UIColor clearColor].CGColor];
    [self.shapeLayer setLineWidth:0];
    
    [self.layer addSublayer:self.shapeLayer];
}

- (void) createTheGrayCircle
{
    CGRect rect = self.bounds;
    
    CGPoint center = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0);
    CGFloat radius = MIN(rect.size.width / 2.0, rect.size.height / 2.0) - self.arrowHead / 2;
    
    //Create the gray circle
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:center radius:(radius - self.arrowHead / 2) startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    [self.circleLayer setPath:bezierPath.CGPath];
    [self.circleLayer setStrokeColor:self.circleColor.CGColor];
    [self.circleLayer setFillColor:[UIColor clearColor].CGColor];
    [self.circleLayer setLineWidth:_arrowWidth];
    [self.layer addSublayer:self.circleLayer];
}


- (void) didChangeValueForKey:(NSString *)key
{
    [self updateView];
}

@end
