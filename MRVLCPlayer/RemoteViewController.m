//
//  RemoteViewController.m
//  MRVLCPlayer
//
//  Created by Maru on 16/3/20.
//  Copyright © 2016年 Alloc. All rights reserved.
//

#import "RemoteViewController.h"
#import "MRVLCPlayer.h"

//模糊视频
#define NOTHIGHDEFINITION @"rtsp://192.72.1.1/liveRTSP/av1"
#define URL @"http://192.72.1.1/SD/Normal/NK_D20180821_173641_1440.MP4"
@implementation RemoteViewController

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        
        [self prefersStatusBarHidden];
        
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
        
    }
}

- (IBAction)remotePlay:(id)sender {

    MRVLCPlayer *player = [[MRVLCPlayer alloc] init];
    player.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width / 16 * 9);
    player.center = self.view.center;
//    player.mediaURL = [NSURL URLWithString:@"http://baobab.kaiyanapp.com/api/v1/playUrl?vid=39183&editionType=normal&source=qcloud"];
    player.mediaURL = [NSURL URLWithString:NOTHIGHDEFINITION];
    
    [player showInView:self.view.window];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
