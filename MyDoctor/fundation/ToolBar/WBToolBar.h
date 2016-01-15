//
//  WBToolBar.h
//  EnterpriseMicroBlog
//  工具栏
//  Created by zhu zhanping on 13-4-13.
//  Copyright (c) 2013年 Enterprise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDConst.h"
@protocol ToolBarDelegate;

#define kToolBarElementWidth    107
#define kTollBarHeight          40
@interface WBToolBar : UIView {
    UIButton *lastSelectedElement;
    UIImageView *cursor;
    UIView *blueLineVIew;
}
- (void)drawFristRect:(CGRect)rect;

@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,weak) id<ToolBarDelegate> delegate;

@end

@protocol ToolBarDelegate <NSObject>

//标签选择后调用
-(void) elementSelected:(int)index toolBar:(WBToolBar*)toolBar;

@end
