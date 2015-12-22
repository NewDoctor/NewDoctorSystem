//
//  NIDropDown.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TextShowStyle)
{
    TextShowStyleLeft,
    TextShowStyleCenter,
    TextShowStyleRight,
};


@class NIDropDown;
@protocol NIDropDownDelegate
- (void) niDropDownDelegateMethod: (NIDropDown *) sender;
@end 

@interface NIDropDown : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,retain) id <NIDropDownDelegate> delegate;
@property (nonatomic,assign) int Offset;
@property (nonatomic,strong) NSString * isOffset;

@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIButton *btnSender;
@property(nonatomic, retain) NSArray *list;
@property (nonatomic,assign) CGFloat font;
@property (nonatomic,assign) TextShowStyle * textshowStyle;


-(void)hideDropDown:(UIButton *)b;
- (id)showDropDown:(UIButton *)b:(CGFloat *)height:(NSArray *)arr;

@end
