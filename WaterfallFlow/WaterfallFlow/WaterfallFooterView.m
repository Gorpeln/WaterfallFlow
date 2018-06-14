//
//  WaterfallFooterView.m
//  Gorpeln
//
//  Created by chen on 2017/6/29.
//  Copyright © 2017年 Gorpeln. All rights reserved.
//

#import "WaterfallFooterView.h"

@implementation WaterfallFooterView

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        [self tipLabel];

    }
    
    return self;
}
-(void)tipLabel{
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:self.bounds];
    tipLabel.text = @"尾部";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tipLabel];
}
@end
