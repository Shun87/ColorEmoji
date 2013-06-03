//
//  SpecialSymbolController.h
//  CustomEmoji
//
//  Created by chenshun on 13-6-2.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialSymbolController : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *symbolListArray;
    UITableView *mTableView;
}

@property (nonatomic, retain)NSMutableArray *symbolListArray;
@property (nonatomic, retain)IBOutlet UITableView *mTableView;
@end