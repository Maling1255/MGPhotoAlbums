//
//  MGPhotoAlbums.h
//  MGPhotoAlbums
//
//  Created by maling on 2018/12/19.
//  Copyright © 2018 maling. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@class MGCollections;
@interface MGPhotoAlbums : NSObject

/** 所有的相册集 */
@property (strong, nonatomic) NSArray <MGCollections *> *collections;

+ (instancetype)albums;

- (void)albumListData:(void(^)(NSArray *collections))collectionsCallback;


@end

@interface MGCollection : NSObject

/** 相册名字 */
@property (nonatomic, copy) NSString *albumName;

/** 相册里面的图片集合 */
@property (nonatomic, strong) NSArray *albumValue;

@end

NS_ASSUME_NONNULL_END
