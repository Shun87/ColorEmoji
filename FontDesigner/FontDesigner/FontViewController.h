//
//  FontViewController.h
//  TextFont
//
//  Created by chenshun on 13-6-15.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *mTableView;
    NSMutableArray *sourceArray;
    NSString *language;
}
@property (nonatomic, copy)NSString *language;
@property (nonatomic, retain) NSMutableArray *sourceArray;
@property (nonatomic, retain)IBOutlet UITableView *mTableView;
@end
