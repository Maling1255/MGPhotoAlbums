//
//  ViewController.h
//  MGPhotoAlbums
//
//  Created by maling on 2018/12/19.
//  Copyright © 2018 maling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, copy) void(^displayAlbum)(NSArray *images);

@end

