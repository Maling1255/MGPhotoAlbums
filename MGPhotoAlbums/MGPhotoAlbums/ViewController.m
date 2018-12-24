//
//  ViewController.m
//  MGPhotoAlbums
//
//  Created by maling on 2018/12/19.
//  Copyright © 2018 maling. All rights reserved.
//

#import "ViewController.h"
#import "MGAlbumsListController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDisplayAlbum:^(NSArray *images) {
       
        NSLog(@"%@", images);
        
    }];
    
}

- (IBAction)selectPhotoAlbums:(id)sender {
    
    MGAlbumsListController *listVC = [[MGAlbumsListController alloc] init];
    
    [self.navigationController pushViewController:listVC animated:YES];
}

@end
