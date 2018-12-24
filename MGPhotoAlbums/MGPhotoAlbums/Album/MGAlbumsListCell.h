//
//  MGAlbumsListCell.h
//  MGPhotoAlbums
//
//  Created by maling on 2018/12/20.
//  Copyright © 2018 maling. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MGCollection;
@interface MGAlbumsListCell : UITableViewCell

@property (nonatomic, strong) MGCollection *conllection;

@end

NS_ASSUME_NONNULL_END
