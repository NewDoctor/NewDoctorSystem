//
//  MDAddressViewController.h
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/27.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import "MDBaseViewController.h"
#import "MDConst.h"

@interface MDAddressViewController :MDBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)     UITableView * tableView;



@end
