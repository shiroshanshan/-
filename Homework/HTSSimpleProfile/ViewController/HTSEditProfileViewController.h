//
//  HTSEditProfileViewController.h
//  Homework
//
//  Created by ハン・エンショウ on 2019/07/08.
//  Copyright © 2019 fan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "BorderUIButton.h";
NS_ASSUME_NONNULL_BEGIN

@interface HTSEditProfileViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic)NSMutableArray *userProfileArray;
@end

NS_ASSUME_NONNULL_END
