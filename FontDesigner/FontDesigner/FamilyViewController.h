//
//  FirstViewController.h
//  FontDesigner
//
//  Created by chenshun on 13-5-5.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    System,
    Custom
}FontType;

@interface FamilyViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *mTableView;

    FontType type;
    
    NSMutableArray *fontArray;
}
@property (nonatomic, retain) NSMutableArray *fontArray;
@property (nonatomic, assign)FontType type;
@property (nonatomic, retain)IBOutlet UITableView *mTableView;
@end
