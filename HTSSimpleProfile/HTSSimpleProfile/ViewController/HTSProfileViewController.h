//
//  ViewController.h
//  HTSSimpleProfile
//
//  Created by ハン・エンショウ on 2019/07/09.
//  Copyright © 2019 fan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "HTSProfileViewModel.h"
#import "UIBorderButton.h"
#import "HTSProfileEditViewController.h"

@interface HTSProfileViewController : UIViewController <HTSDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) HTSProfileViewModel *viewModel;
//@property (nonatomic) UINavigationBar *userProfileNavigationBar;
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) int cellInsetInt;

- (instancetype)initWithViewModel : (HTSProfileViewModel *)viewModel;

@end

