//
//  ChooseTimeVC.h
//  BusinessApp
//
//  Created by 孙升隆 on 2016/11/21.
//  Copyright © 2016年 Perfect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseTimeVC : UIViewController

@property (nonatomic, copy) void(^chooseTimeBlock)(int type);


@end
