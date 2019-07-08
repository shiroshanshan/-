//
//  HTSEditProfileViewController.m
//  Homework
//
//  Created by ハン・エンショウ on 2019/07/08.
//  Copyright © 2019 fan. All rights reserved.
//

#import "HTSEditProfileViewController.h"

@interface HTSEditProfileViewController ()
@property (weak, nonatomic) IBOutlet UITableView *userEditProfileTable;
@property (weak, nonatomic) IBOutlet UIImageView *userEditProfileAvatar;
@property (weak, nonatomic) IBOutlet UITextView *userEditDescription;
@end

@implementation HTSEditProfileViewController
@synthesize userProfileArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    saveButtonItem.tintColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    
    userProfileArray = [NSMutableArray arrayWithArray:@[@"昵称",@"火山号",@"性别",@"生日"]];
    self.userEditProfileAvatar.layer.cornerRadius  = self.userEditProfileAvatar.frame.size.width/2;
    self.userEditProfileAvatar.clipsToBounds = YES;
    
    self.userEditDescription.textContainerInset = UIEdgeInsetsMake(30, 20, 30, 20);
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    [_userEditProfileTable setEditing: YES animated: YES];
}

- (IBAction)save:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return userProfileArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = userProfileArray[indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
    UITextField *userInfo = [[UITextField alloc] init];
    [cell addSubview:userInfo];
    [userInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(cell);
        make.left.mas_equalTo(cell.mas_left).with.offset(110);
    }];
    userInfo.text = @"User Information";
    
    if (indexPath.row == 1) {
        BorderUIButton *copyButton = [[BorderUIButton alloc] init];
        [copyButton setTitle:@"点击复制" forState:UIControlStateNormal];
        [copyButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [copyButton.titleLabel setFont:[UIFont fontWithName:@"ArialHebrew" size:14]];
        copyButton.borderWidth = 1;
        copyButton.borderColor = [UIColor redColor];
        copyButton.cornerRadius = 15;
        [cell addSubview:copyButton];
        [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(cell).with.offset(15);
            make.bottom.mas_equalTo(cell).with.offset(-15);
            make.right.mas_equalTo(cell.mas_right).with.offset(-10);
            make.width.mas_equalTo(80);
        }];
    }
    
    return cell;
}

- (IBAction)changeUserAvatar:(UIButton *)sender {
    UIImagePickerController *pickerLibrary = [[UIImagePickerController alloc] init];
    pickerLibrary.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerLibrary.delegate = self;
    [self presentModalViewController:pickerLibrary animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)editingInfo{
    self.userEditProfileAvatar.image = image;
    [self dismissModalViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
