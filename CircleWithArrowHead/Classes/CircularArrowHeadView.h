//
//  CircularArrowHeadView.h
//  CircleWithArrowHead
//
//  Created by Jose Catala on 19/08/2018.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface CircularArrowHeadView : UIView

@property (nonatomic, strong) IBInspectable UIColor *fillColor;

@property (nonatomic, strong) IBInspectable UIColor *circleColor;

@property (nonatomic) IBInspectable CGFloat startAngle;

@property (nonatomic) IBInspectable CGFloat endAngle;

@property (nonatomic) IBInspectable CGFloat arrowWidth;

@property (nonatomic) IBInspectable CGFloat arrowHead;

@property (nonatomic) IBInspectable BOOL clockwise;

@end

NS_ASSUME_NONNULL_END
