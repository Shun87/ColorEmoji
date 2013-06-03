//
//  ProVersionViewController.h
//  FontDesigner
//
//  Created by chenshun on 13-5-11.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProVersionViewController : UIViewController
{
    UIButton *button;
    UILabel *lable;
}
@property (nonatomic, retain)IBOutlet UILabel *lable;
@property (nonatomic, retain)IBOutlet UIButton *button;
@end
