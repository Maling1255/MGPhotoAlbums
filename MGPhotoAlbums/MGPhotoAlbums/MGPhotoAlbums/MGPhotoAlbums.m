//
//  MGPhotoAlbums.m
//  MGPhotoAlbums
//
//  Created by maling on 2018/12/19.
//  Copyright © 2018 maling. All rights reserved.
//

#import "MGPhotoAlbums.h"
#import <Photos/Photos.h>

@implementation MGPhotoAlbums

+ (void)authorizedToAlbum:(void(^)(BOOL status))resultBlock
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        
        if (status == PHAuthorizationStatusAuthorized) {
            resultBlock(YES);
        }
        else
        {
            resultBlock(NO);
        }
    }];
}

+ (instancetype)albums
{
   return [[MGPhotoAlbums alloc] init];
}

- (void)albumListData:(void(^)(NSArray *collections))collectionsCallback
{
    [MGPhotoAlbums authorizedToAlbum:^(BOOL status) {
        if (status) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (collectionsCallback) {
                    
                    collectionsCallback([self collationOfData]);
                }
            });
        }
    }];
}

- (NSArray *)collationOfData
{
   NSArray <NSDictionary *> *collections = [self getAllPhotoAblums];
    
    NSMutableArray *tempCollections = [[NSMutableArray alloc] init];
    
    for (NSDictionary *assetDict in collections) {
        
        NSString *albumName = assetDict.keyEnumerator.nextObject;
        
        NSArray <PHAsset *> *assets = assetDict.objectEnumerator.nextObject;
        
        NSLog(@"albumName: %@   %ld", albumName, assets.count);
    
        
        MGCollection *collection = [[MGCollection alloc] init];
        
        collection.albumName = albumName;
        
        collection.albumValue = assets;
        
        [tempCollections addObject:collection];
    }
    
    return tempCollections;
}


- (NSArray <NSDictionary *> *)getAllPhotoAblums
{
    NSMutableArray *allAlbums = [[NSMutableArray alloc] init];
    // 所有系统相册集
    PHFetchOptions *options = [PHFetchOptions new];
    PHFetchResult *fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                                                          subtype:PHAssetCollectionSubtypeAlbumRegular
                                                                          options:options];
    
    if (fetchResult.count == 0) return nil;
    
    for (PHAssetCollection * assetCollection in fetchResult) {
        
        // 相册名字
        NSString * collectionTitle = assetCollection.localizedTitle;
        
        NSArray <PHAsset *> *assets = [self getAssetWithCollection:assetCollection];
        
        if (assets.count != 0) {
            
            NSMutableDictionary *assetDict = [[NSMutableDictionary alloc] init];
            
            [assetDict setObject:assets forKey:collectionTitle];
            
            [allAlbums addObject:assetDict];
        }
    }
    
    // 获取自定义相册集
    PHFetchResult *userfetchResult = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    
    for (PHAssetCollection * assetCollection in userfetchResult) {
        
        NSString *collectionTitle = assetCollection.localizedTitle;
        
        NSArray *assets = [self getAssetWithCollection:assetCollection];
        
        if (assets.count != 0) {
            
            NSMutableDictionary *assetDict = [[NSMutableDictionary alloc] init];
            
            [assetDict setObject:assets forKey:collectionTitle];
            
            [allAlbums addObject:@{collectionTitle:assets}];
        }
    }
    
    return allAlbums;
}

- (NSArray *)getAssetWithCollection:(PHAssetCollection *)collection
{
    // 检索
    PHFetchOptions * options = [[PHFetchOptions alloc] init];
    
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    
    options.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    
    NSMutableArray * assetArray = [NSMutableArray array];
    
    PHFetchResult * assetFetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:options];
    
    for (PHAsset * asset in assetFetchResult) {
        
        [assetArray insertObject:asset atIndex:0];
        
    }
    return assetArray;
}


@end

@implementation MGCollection



@end
