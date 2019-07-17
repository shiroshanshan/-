//
//  HTSProfileEditViewController.m
//  HTSSimpleProfile
//
//  Created by ハン・エンショウ on 2019/07/16.
//  Copyright © 2019 fan. All rights reserved.
//

#import "HTSProfileEditViewController.h"

@interface HTSProfileEditViewController ()

@end

@implementation HTSProfileEditViewController

@synthesize userProfileArray;
@synthesize superViewUpper;
@synthesize superViewMedium;
@synthesize superViewLower;
@synthesize datePicker;
@synthesize genderPicker;
@synthesize userProfileEditUpperInset;
@synthesize viewHeightFloat;
@synthesize viewWidthFloat;
@synthesize userAvatarImageView;
@synthesize userDescriptionTextView;

#pragma mark - Lifecycle

- (instancetype) initWithViewModel : (HTSProfileViewModel *)viewModel {
    self = [super init];
    if (!self) return nil;
    
    self.viewModel = viewModel;
    
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    userProfileEditUpperInset  = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
    userProfileArray = [NSMutableArray arrayWithArray:@[@"昵称",@"火山号",@"性别",@"生日"]];
    viewHeightFloat = self.view.frame.size.height;
    viewWidthFloat = self.view.frame.size.width;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
    self.navigationItem.title = @"编辑资料";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *userProfileSaveButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveUserProfile)];
    userProfileSaveButton.tintColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = userProfileSaveButton;
    
    [self setSuperView];
    [self setAvatar];
    [self setTableView];
    [self setTextView];
}

- (void)saveUserProfile {
    UITextField *userInformationTextField = [self.view viewWithTag:1];
    self.viewModel.userModel.nicknameString = userInformationTextField.text;
    self.viewModel.userModel.signatureString = userDescriptionTextView.text;
    if ([self.delegate respondsToSelector:@selector(didSaveWithAvatar:)]) {
        [self.delegate didSaveWithAvatar:userAvatarImageView.image];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setSuperView {
    CGRect rectUpper = CGRectMake(0, userProfileEditUpperInset, viewWidthFloat, viewHeightFloat * 0.3);
    superViewUpper = [[UIView alloc] initWithFrame:rectUpper];
    [self.view addSubview:superViewUpper];
    
    CGRect rectMedium = CGRectMake(0, userProfileEditUpperInset + viewHeightFloat * 0.3, viewWidthFloat, viewHeightFloat * 0.25);
    superViewMedium = [[UIView alloc] initWithFrame:rectMedium];
    [self.view addSubview:superViewMedium];
    
    CGRect rectLower = CGRectMake(0, userProfileEditUpperInset + 0.55 * viewHeightFloat, viewWidthFloat, 0.45 * viewHeightFloat - userProfileEditUpperInset);
    superViewLower = [[UIView alloc] initWithFrame:rectLower];
    [self.view addSubview:superViewLower];
}

- (void)setAvatar {
    int userAvatarSize = 120;
    int userAvatarTopInset = 50;
    int userAvatarButtonTopInset = 15;
    UIFont *userAvatarChangeButtonFont = [UIFont systemFontOfSize:17];
    userAvatarImageView = [[UIImageView alloc] init];
    [superViewUpper addSubview:userAvatarImageView];
    [userAvatarImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(userAvatarSize, userAvatarSize));
        make.centerX.mas_equalTo(self->superViewUpper);
        make.top.mas_equalTo(self->superViewUpper.mas_top).with.inset(userAvatarTopInset);
    }];
    userAvatarImageView.layer.cornerRadius = userAvatarSize / 2;
    userAvatarImageView.clipsToBounds = YES;
    userAvatarImageView.image = [UIImage imageNamed:@"avatar"];

    UIButton *userAvatarChangeButton = [[UIButton alloc] init];
    [userAvatarChangeButton setTitle:@"点击更换头像" forState:UIControlStateNormal];
    [userAvatarChangeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    userAvatarChangeButton.titleLabel.font = userAvatarChangeButtonFont;
    [superViewUpper addSubview:userAvatarChangeButton];
    [userAvatarChangeButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self->userAvatarImageView);
        make.top.mas_equalTo(self->userAvatarImageView.mas_bottom).with.inset(userAvatarButtonTopInset);
    }];
    [userAvatarChangeButton addTarget:self action:@selector(userAvatarChange) forControlEvents:UIControlEventTouchUpInside];
}

- (void)userAvatarChange {
    UIImagePickerController *pickerLibrary = [[UIImagePickerController alloc] init];
    pickerLibrary.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerLibrary.delegate = self;
    [self presentModalViewController:pickerLibrary animated:YES];
}

- (void)setTableView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [superViewMedium addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(self->superViewMedium);
        make.center.mas_equalTo(self->superViewMedium);
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int textFieldLeftInsetInt = 110;
    UIColor *cellColor = [UIColor grayColor];
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = userProfileArray[indexPath.row];
    cell.textLabel.textColor = cellColor;
    UITextField *userInformationTextField = [[UITextField alloc] init];
    [cell addSubview:userInformationTextField];
    [userInformationTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(cell);
        make.left.mas_equalTo(cell.mas_left).with.offset(textFieldLeftInsetInt);
    }];
    userInformationTextField.text = @"User Information";
    
    switch (indexPath.row) {
        case 0: {
            userInformationTextField.text = @"luckymore~";
            userInformationTextField.tag = 1;
            
            break;
        }
    
        case 1: {
            userInformationTextField.text = @"152151212";
            userInformationTextField.userInteractionEnabled = NO;
            [self setCopyButtonForCell:cell];
            userInformationTextField.tag = 2;
            
            break;
        }
            
        case 2: {
            userInformationTextField.text = @"男";
            userInformationTextField.tag = 3;
            
            genderPicker = [[UIPickerView alloc] init];
            genderPicker.delegate = self;
            genderPicker.dataSource = self;
            genderPicker.showsSelectionIndicator = YES;
            UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, viewWidthFloat, 44)];
            [toolBar setTintColor:[UIColor grayColor]];
            UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(showSelectedGender)];
            doneButton.tintColor = [UIColor redColor];
            UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            [toolBar setItems:[NSArray arrayWithObjects:space, doneButton, nil]];
            [genderPicker addSubview:toolBar];
            
            UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, genderPicker.frame.size.height + 44)];
            [genderPicker setFrame:CGRectMake(0, 0, inputView.frame.size.width, inputView.frame.size.height)];
            inputView.backgroundColor = [UIColor clearColor];
            [inputView addSubview:genderPicker];
            [inputView addSubview:toolBar];
            
            userInformationTextField.inputView = inputView;
            
            break;
        }
            
        case 3: {
            userInformationTextField.text = @"1993-12-18";
            userInformationTextField.tag = 4;
            datePicker = [[UIDatePicker alloc] init];
            datePicker.datePickerMode = UIDatePickerModeDate;
            [userInformationTextField setInputView:datePicker];
            UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, viewWidthFloat, 44)];
            [toolBar setTintColor:[UIColor grayColor]];
            UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(showSelectedDate)];
            doneButton.tintColor = [UIColor redColor];
            UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            [toolBar setItems:[NSArray arrayWithObjects:space, doneButton, nil]];
            [userInformationTextField setInputAccessoryView:toolBar];

            break;
        }

        default: {
            break;
        }
    }
    
    return cell;
}

- (void)setCopyButtonForCell:(UITableViewCell *)cell {
    int copyButtonRightInset = 10;
    int copyButtonWidth = 80;
    UIFont *copyButtonFont =[UIFont systemFontOfSize:14];
    UIBorderButton *copyButton = [[UIBorderButton alloc] init];
    [copyButton setTitle:@"点击复制" forState:UIControlStateNormal];
    [copyButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [copyButton.titleLabel setFont:copyButtonFont];
    copyButton.borderWidth = 1;
    copyButton.borderColor = [UIColor redColor];
    copyButton.cornerRadius = 15;
    [cell addSubview:copyButton];
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(cell);
        make.right.mas_equalTo(cell.mas_right).with.inset(copyButtonRightInset);
        make.width.mas_equalTo(copyButtonWidth);
    }];
    [copyButton addTarget:self action:@selector(copyUserId) forControlEvents:UIControlEventTouchUpInside];
}
         
- (void)copyUserId {
    UITextField *userIdTextField = [self.view viewWithTag:2];
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setValue:userIdTextField.text forPasteboardType:@"public.utf8-plain-text"];
}

- (void)showSelectedGender {
    UITextField *userInformationTextField = [self.view viewWithTag:3];
    NSInteger row = [genderPicker selectedRowInComponent:0];
    switch (row) {
        case 0: {
            userInformationTextField.text = @"男";
        }
        default: {
            userInformationTextField.text = @"女";
        }
    }
    [userInformationTextField resignFirstResponder];
}

- (void)showSelectedDate {
    UITextField *userInformationTextField = [self.view viewWithTag:4];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    userInformationTextField.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:datePicker.date]];
    [userInformationTextField resignFirstResponder];
}
    
- (void)setTextView {
    userDescriptionTextView = [[UITextView alloc] init];
    userDescriptionTextView.clipsToBounds = YES;
    userDescriptionTextView.textContainerInset = UIEdgeInsetsMake(30, 20, 30, 20);
    [superViewLower addSubview:userDescriptionTextView];
    [userDescriptionTextView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(self->superViewLower).sizeOffset(CGSizeMake(0, -100));
        make.centerX.mas_equalTo(self->superViewLower);
        make.top.mas_equalTo(self->superViewLower.mas_top).with.inset(40);
    }];
    userDescriptionTextView.text = @"恭喜你发现了一只研发小哥哥!";
    userDescriptionTextView.font = [UIFont systemFontOfSize:18];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return userProfileArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return viewHeightFloat * 0.25 / 4;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (row) {
        case 0: {
            return @"男";
        }
        default: {
            return @"女";
        }
    }
}

- (void)delTableLists:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
}

@end
