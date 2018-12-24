//
//  MGAlbumTool.m
//  MGPhotoAlbums
//
//  Created by maling on 2018/12/20.
//  Copyright © 2018 maling. All rights reserved.
//

#import "MGAlbumTool.h"
#import "MGPhotoAlbums.h"

@interface MGAlbumTool ()

@property (nonatomic, assign) NSInteger countOfSelected;
@property (nonatomic, assign) NSInteger indexOfPhoto;

@end

@implementation MGAlbumTool

- (instancetype)init
{
    if (self = [super init]) {
        
        _countOfSelected = 0;
        
        _indexOfPhoto = -1;
        
        _selectedOfIndexPaths = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)selectItemAtIndex:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView
{
    
    NSArray *selectedIndexPath = [self selectItemAtIndexPath:indexPath];
    
    [self setSelectStatusForCell];
    
    if (_countOfSelected == MGMaxSelextedCount && _selectedOfIndexPaths.count == MGMaxSelextedCount) return selectedIndexPath;
    
    if (_selectedOfIndexPaths.count == MGMaxSelextedCount || _countOfSelected == MGMaxSelextedCount)
    {
        [collectionView reloadData];
    }
    else
    {
        [collectionView reloadItemsAtIndexPaths:selectedIndexPath];
    }
 
   _countOfSelected = _selectedOfIndexPaths.count;
    
    return selectedIndexPath;
}

- (NSArray <NSIndexPath *> *)selectItemAtIndexPath:(NSIndexPath *)indexPath 
{
    if (![_selectedOfIndexPaths containsObject:indexPath])
    {
        if (_selectedOfIndexPaths.count < MGMaxSelextedCount) {
            
          [_selectedOfIndexPaths addObject:indexPath];
        }
        else
        {
            NSLog(@"你最多只能选择9张照片");
        }
        
    }
    else
    {
        [_selectedOfIndexPaths removeObject:indexPath];
    }
    
    return _selectedOfIndexPaths;
}

- (NSArray <NSIndexPath *> *)getCurrentIndexPath
{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (NSIndexPath *indexPath in _selectedOfIndexPaths) {
        
        [tempArray addObject: [NSIndexPath indexPathForRow:indexPath.item inSection:0]];
    }
    
    return tempArray;
}

- (void)setSelectStatusForCell
{
    for (int i = 0; i < _selectStatus.count; i++) {
        
        [_selectStatus replaceObjectAtIndex:i withObject:@NO];
    }
    
    for (int i = 0; i < _selectStatus.count; i++) {
        
        for (NSIndexPath *indexPath in _selectedOfIndexPaths) {
            
            if (indexPath.row == i) {
                
                [_selectStatus replaceObjectAtIndex:i withObject:@YES];
                
                break;
            }
        }
    }
}

- (void)setConllection:(MGCollection *)conllection
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < conllection.albumValue.count; i++) {
        
        [tempArray addObject:@NO];
    }
    
    _selectStatus = tempArray.mutableCopy;
}




@end
