//
//  HTSProfileEditViewController.h
//  HTSSimpleProfile
//
//  Created by ハン・エンショウ on 2019/07/16.
//  Copyright © 2019 fan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "UIBorderButton.h"
#import "HTSProfileViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTSProfileEditViewController : UIViewController <HTSDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) HTSProfileViewModel *viewModel;
@property (weak, nonatomic) id <HTSDelegate> delegate;
@property (nonatomic) UIView *superViewUpper;
@property (nonatomic) UIView *superViewMedium;
@property (nonatomic) UIView *superViewLower;
@property (nonatomic) NSMutableArray *userProfileArray;
@property (nonatomic) UIImageView *userAvatarImageView;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UITextView *userDescriptionTextView;
@property (nonatomic) UIDatePicker *datePicker;
@property (nonatomic) UIPickerView *genderPicker;
@property (nonatomic) CGFloat userProfileEditUpperInset;
@property (nonatomic) CGFloat viewHeightFloat;
@property (nonatomic) CGFloat viewWidthFloat;

- (instancetype) initWithViewModel : (HTSProfileViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
