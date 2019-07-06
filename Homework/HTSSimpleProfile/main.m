//
//  main.m
//  Homework
//
//  Created by ハン・エンショウ on 2019/07/05.
//  Copyright © 2019 fan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "HTSUserModel.h"
#import "HTSVideoModel.h"

int main(int argc, char * argv[]) {
    NSError *error = nil;
    NSDictionary *userDictionary;
    userDictionary = [HTSUserModel loadUserJSONFile];
//    NSLog(@"userDictionary is a %@", [userDictionary class]);
    HTSUserModel *usermodel = [MTLJSONAdapter modelOfClass:[HTSUserModel class] fromJSONDictionary:userDictionary error: &error];
//    NSLog(@"error is %@", error);
    HTSVideoModel *videomodel = [[HTSVideoModel alloc] init];
    NSDictionary *videoDictionary;
    videoDictionary = [HTSVideoModel loadVideoJSONFile];
    NSArray *videoArray;
    videoArray = [videoDictionary objectForKey:@"data"];
    for (int i = 0; i < videoArray.count; i++){
        HTSVideo *video = [MTLJSONAdapter modelOfClass:[HTSVideo class] fromJSONDictionary:[videoArray objectAtIndex:i] error: &error];
        [videomodel appendVideo:video];
    }
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
