//
//  HTSMainNavigationController.m
//  Homework
//
//  Created by ハン・エンショウ on 2019/07/08.
//  Copyright © 2019 fan. All rights reserved.
//

#import "HTSMainNavigationController.h"

@interface HTSMainNavigationController ()

@end

@implementation HTSMainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
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
