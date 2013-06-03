//
//  SecondViewController.h
//  FontDesigner
//
//  Created by chenshun on 13-5-5.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StyleViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *mTableView;
    NSMutableArray *styleArray;
}
@property (nonatomic, retain)IBOutlet UITableView *mTableView;
@end
