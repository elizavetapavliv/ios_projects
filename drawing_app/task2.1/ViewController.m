//
//  ViewController.m
//  task2.1
//
//  Created by Elizaveta on 4/28/19.
//  Copyright © 2019 Elizaveta. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *canvas;
@property (strong, nonatomic) IBOutlet UIImageView *colorsView;
@property (strong, nonatomic) IBOutlet UISlider *sizeSlider;
@property (strong, nonatomic) IBOutlet UISlider *colorsSlider;
@property (strong, nonatomic) IBOutlet UISegmentedControl *patternControl;
@property CGPoint lastPoint;
@property NSArray* colorsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.colorsArray = [NSArray arrayWithObjects: UIColor.greenColor, UIColor.cyanColor, UIColor.blueColor, UIColor.purpleColor, UIColor.magentaColor, nil];
    
    UIImage* colors = [UIImage imageNamed: @"colors.png"];
    self.colorsView = [[UIImageView alloc] initWithFrame:self.colorsView.frame];
    self.colorsView.contentMode = UIViewContentModeScaleAspectFit;
    self.colorsView.image = colors;
    [self.view addSubview:self.colorsView];
}
- (IBAction)saveTapped:(id)sender {
    NSData* data = UIImagePNGRepresentation(_canvas.image);
    [data writeToFile:@"/Users/liza.pavliv/lab8/task2.1/test.png" atomically:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch  = [touches anyObject];
    [self setLastPoint:[touch locationInView:self.view]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGRect drawRect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width,
                                 self.view.frame.size.height);
    [[[self canvas] image] drawInRect:drawRect];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), (int)_sizeSlider.value);
    
    UIColor* c = [[self colorsArray] objectAtIndex:(int)_colorsSlider.value];
    const CGFloat* comp =  CGColorGetComponents(c.CGColor);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), comp[0], comp[1], comp[2], CGColorGetAlpha(c.CGColor));
    if (_patternControl.selectedSegmentIndex == 1){
        CGContextSetLineDash(UIGraphicsGetCurrentContext(), 0, (CGFloat[]){2, 13}, 2);
    }
    else {
         CGContextSetLineDash(UIGraphicsGetCurrentContext(), 0, (CGFloat[]){1}, 0);
    }
    CGContextSetLineJoin(UIGraphicsGetCurrentContext(), kCGLineJoinRound);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x, _lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    [[self canvas] setImage:UIGraphicsGetImageFromCurrentImageContext()];
    UIGraphicsEndImageContext();
    _lastPoint = currentPoint;
}
@end
