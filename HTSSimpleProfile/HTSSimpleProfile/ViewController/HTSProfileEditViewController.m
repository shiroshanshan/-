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
@synthesize datePicker;
@synthesize genderPicker;

- (instancetype) initWithViewModel : (HTSProfileViewModel *)viewModel {
    self = [super init];
    if (!self) return nil;
    
    self.viewModel = viewModel;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
    self.navigationItem.title = @"编辑资料";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *userProfileSaveButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveUserProfile)];
    userProfileSaveButton.tintColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = userProfileSaveButton;
    
    userProfileArray = [NSMutableArray arrayWithArray:@[@"昵称",@"火山号",@"性别",@"生日"]];
    
    [self setSuperView];
    [self setAvatar];
    [self setTableView];
    [self setTextView];
}

- (void)saveUserProfile {
    UITextField *userInformationTextField = [self.view viewWithTag:5];
    UITextView *userDescriptionTextView = [self.view viewWithTag:6];
    self.viewModel.userModel.nicknameString = userInformationTextField.text;
    self.viewModel.userModel.signatureString = userDescriptionTextView.text;
    if ([self.delegate respondsToSelector:@selector(didSave)]) {
        [self.delegate didSave];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setSuperView {
    CGFloat userProfileEditUpperOffset = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
    CGRect rectUpper = CGRectMake(0, userProfileEditUpperOffset, self.view.frame.size.width, self.view.frame.size.height * 0.3);
    UIView *superViewUpper = [[UIView alloc] initWithFrame:rectUpper];
    [self.view addSubview:superViewUpper];
    superViewUpper.tag = 1;
    
    CGRect rectMedium = CGRectMake(0, userProfileEditUpperOffset + self.view.frame.size.height * 0.3, self.view.frame.size.width, self.view.frame.size.height * 0.25);
    UIView *superViewMedium = [[UIView alloc] initWithFrame:rectMedium];
    [self.view addSubview:superViewMedium];
    superViewMedium.tag = 2;
    
    CGRect rectLower = CGRectMake(0, userProfileEditUpperOffset + 0.55 * self.view.frame.size.height, self.view.frame.size.width, 0.45 * self.view.frame.size.height - userProfileEditUpperOffset);
    UIView *superViewLower = [[UIView alloc] initWithFrame:rectLower];
    [self.view addSubview:superViewLower];
    superViewLower.tag = 3;
}

- (void)setAvatar {
    UIView *superViewUpper = [self.view viewWithTag:1];
    UIImageView *userAvatarImageView = [[UIImageView alloc] init];
    [superViewUpper addSubview:userAvatarImageView];
    [userAvatarImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(120, 120));
        make.centerX.mas_equalTo(superViewUpper);
        make.top.mas_equalTo(superViewUpper.mas_top).with.inset(50);
    }];
    userAvatarImageView.layer.cornerRadius = 60;
    userAvatarImageView.clipsToBounds = YES;
    userAvatarImageView.image = [UIImage imageNamed:@"avatar"];
    userAvatarImageView.tag = 4;
    
    UIButton *userAvatarChangeButton = [[UIButton alloc] init];
    [userAvatarChangeButton setTitle:@"点击更换头像" forState:UIControlStateNormal];
    [userAvatarChangeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    userAvatarChangeButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [superViewUpper addSubview:userAvatarChangeButton];
    [userAvatarChangeButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(userAvatarImageView);
        make.top.mas_equalTo(userAvatarImageView.mas_bottom).with.inset(15);
//        make.size.mas_equalTo(CGSizeMake(100, 30));
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
    UIView *superViewMedium = [self.view viewWithTag:2];
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [superViewMedium addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(superViewMedium);
        make.center.mas_equalTo(superViewMedium);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return userProfileArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height * 0.25 / 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = userProfileArray[indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
    UITextField *userInformationTextField = [[UITextField alloc] init];
    [cell addSubview:userInformationTextField];
    [userInformationTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(cell);
        make.left.mas_equalTo(cell.mas_left).with.offset(110);
    }];
    userInformationTextField.text = @"User Information";
    
    if (indexPath.row == 0) {
        userInformationTextField.text = @"luckymore~";
        userInformationTextField.tag = 5;
    }
    
    if (indexPath.row == 1) {
        userInformationTextField.text = @"152151212";
        userInformationTextField.userInteractionEnabled = NO;
        userInformationTextField.tag = 7;
        UIBorderButton *copyButton = [[UIBorderButton alloc] init];
        [copyButton setTitle:@"点击复制" forState:UIControlStateNormal];
        [copyButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [copyButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        copyButton.borderWidth = 1;
        copyButton.borderColor = [UIColor redColor];
        copyButton.cornerRadius = 15;
        [cell addSubview:copyButton];
        [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell);
            make.right.mas_equalTo(cell.mas_right).with.offset(-10);
            make.width.mas_equalTo(80);
        }];
        [copyButton addTarget:self action:@selector(copyUserDescription) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (indexPath.row == 2) {
        userInformationTextField.text = @"男";
        userInformationTextField.tag = 8;
        genderPicker = [[UIPickerView alloc] init];
        genderPicker.delegate = self;
        genderPicker.dataSource = self;
        genderPicker.showsSelectionIndicator = YES;
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
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
        
    }
        
    if (indexPath.row == 3) {
        userInformationTextField.text = @"1993-12-18";
        userInformationTextField.tag = 9;
        datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [userInformationTextField setInputView:datePicker];
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        [toolBar setTintColor:[UIColor grayColor]];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(showSelectedDate)];
        doneButton.tintColor = [UIColor redColor];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [toolBar setItems:[NSArray arrayWithObjects:space, doneButton, nil]];
        [userInformationTextField setInputAccessoryView:toolBar];
    }
    
    return cell;
}

- (void)setTextView {
    UIView *superViewLower = [self.view viewWithTag:3];
    UITextView *userDescriptionTextView = [[UITextView alloc] init];
    userDescriptionTextView.clipsToBounds = YES;
    userDescriptionTextView.textContainerInset = UIEdgeInsetsMake(30, 20, 30, 20);
    [superViewLower addSubview:userDescriptionTextView];
    [userDescriptionTextView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(superViewLower).sizeOffset(CGSizeMake(0, -100));
        make.centerX.mas_equalTo(superViewLower);
        make.top.mas_equalTo(superViewLower.mas_top).with.inset(40);
    }];
    userDescriptionTextView.text = @"恭喜你发现了一只研发小哥哥!";
    userDescriptionTextView.font = [UIFont systemFontOfSize:18];
    userDescriptionTextView.tag = 6;
}
         
- (void)copyUserDescription {
    UITextField *htsNumberTextField = [self.view viewWithTag:7];
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setValue:htsNumberTextField.text forPasteboardType:@"public.utf8-plain-text"];
}

- (void)showSelectedDate {
    UITextField *userInformationTextField = [self.view viewWithTag:9];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    userInformationTextField.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:datePicker.date]];
    [userInformationTextField resignFirstResponder];
}

- (void)showSelectedGender {
    UITextField *userInformationTextField = [self.view viewWithTag:8];
    NSInteger row = [genderPicker selectedRowInComponent:0];
    if (row == 0) {
        userInformationTextField.text = @"男";
    } else {
        userInformationTextField.text = @"女";
    }
    [userInformationTextField resignFirstResponder];
}

//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    UITextField *userInformationTextField = [self.view viewWithTag:8];
//    if (row == 0) {
//        userInformationTextField.text = @"男";
//    } else {
//        userInformationTextField.text = @"女";
//    }
//}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (row == 0) {
        return @"男";
    } else {
        return @"女";
    }
}

- (void)delTableLists:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
}

@end
