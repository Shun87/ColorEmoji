//
//  FamilyDetailViewController.h
//  FontDesigner
//
//  Created by chenshun on 13-5-5.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *mTableView;
    NSMutableArray *sourceArray;
    NSString *familyName;
}
@property (nonatomic, copy) NSString *familyName;
@property (nonatomic, retain) NSMutableArray *sourceArray;
@property (nonatomic, retain)IBOutlet UITableView *mTableView;
@end
