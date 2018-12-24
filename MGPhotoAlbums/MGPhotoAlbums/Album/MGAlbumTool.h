//
//  MGAlbumTool.h
//  MGPhotoAlbums
//
//  Created by maling on 2018/12/20.
//  Copyright © 2018 maling. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MGCollection;
@interface MGAlbumTool : NSObject

/** 所有选中的IndexPath */
@property (nonatomic, strong) NSMutableArray *selectedOfIndexPaths;

/** 选中状态 */
@property (nonatomic, strong) NSMutableArray *selectStatus;

@property (nonatomic, strong) MGCollection *conllection;

- (NSArray *)selectItemAtIndex:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView;

- (NSArray <NSIndexPath *> *)selectItemAtIndexPath:(NSIndexPath *)indexPath;

- (NSArray <NSIndexPath *> *)getCurrentIndexPath;

@end

NS_ASSUME_NONNULL_END
