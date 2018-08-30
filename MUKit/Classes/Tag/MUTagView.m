//
//  UITagView.m
//  ZPApp
//
//  Created by Jekity on 2018/8/14.
//  Copyright © 2018年 Jekity. All rights reserved.
//

#import "MUTagView.h"

@interface MUTagView ()
@property (nonatomic,assign) CGRect contentRect;
@property (nonatomic,assign) CGFloat itemHeight;
@property (nonatomic,strong) NSArray *innerArray;
@property (nonatomic,assign) CGFloat margain;
@end
@implementation MUTagView

- (instancetype)initWithFrame:(CGRect)frame withAarray:(NSArray *)array itemHeight:(CGFloat)itemHeight{
    
    if (self = [super initWithFrame:frame]) {
        _contentRect  = frame;
        _itemHeight = itemHeight>16?:16;
        _innerArray = [array mutableCopy];
        _margain    = 6.;
        [self setupLayoutViews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame withAarray:(NSArray *)array{
    if (self = [super initWithFrame:frame]) {
        _contentRect  = frame;
        _itemHeight = 16;
        _innerArray = [array mutableCopy];
        _margain    = 6.;
        [self setupLayoutViews];
    }
    return self;
}
-(void)setupLayoutViews{
    
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (NSUInteger i = 0; i < self.innerArray.count; i++) {
        
        UILabel *label = [self labelWithIndex:i model:self.innerArray[i]];
        CGFloat width = label.frame.size.width + _margain;
        label.tag = i;
        if (x + width + 12 > _contentRect.size.width) {
            y += (_itemHeight + _margain);//换行
            x = 0; //0位置开始
        }
        
        label.frame = CGRectMake(x, y, width, _itemHeight);
        [self addSubview:label];
        x += width + _margain;//宽度+间隙
    }
    if (self.innerArray.count>0) {
        _needHeight = y+_itemHeight;
    }
          
}


- (UILabel *)labelWithIndex:(NSUInteger)index model:(id)model{
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.userInteractionEnabled = YES;
    label.layer.borderColor = [UIColor lightGrayColor].CGColor;
    label.layer.cornerRadius = 3;
    label.backgroundColor = [UIColor colorWithRed:240./255. green:240./255. blue:240./255. alpha:1.];
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:10];
    if ([model isKindOfClass:[NSString class]]) {
        label.text = model;
    }
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapedLabel:)];
    tapGesture.numberOfTapsRequired = 1;
    [label addGestureRecognizer:tapGesture];
    if (self.configuredLabel) {
        self.configuredLabel(label, index, model);
    }
    [label sizeToFit];
    return label;
}

- (void)tapedLabel:(UITapGestureRecognizer *)gesture{
    if (self.TapedLabel) {
        UILabel *label = (UILabel *)gesture.view;
        self.TapedLabel(label, label.tag ,self.innerArray[label.tag]);
    }
}

@end
