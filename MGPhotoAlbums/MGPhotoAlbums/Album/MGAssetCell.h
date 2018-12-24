//
//  MGAssetCell.h
//  MGPhotoAlbums
//
//  Created by maling on 2018/12/20.
//  Copyright © 2018 maling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGAssetCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;

@property (nonatomic, copy) NSArray *(^selectBtnEvent)(UIButton *button);

@property (nonatomic, copy) void (^complete)(NSArray *array);

- (void)setPhotoWithAsset:(id)assetItem;

- (void)selectedOfCell:(BOOL)selected selectArray:(NSArray *)selectArray;

- (void)didSelectedBtn:(NSArray *(^)(UIButton *selectedBtn))selectBtnEvent complete:(void(^)(NSArray *array))complete;

- (void)markNumber:(id)number selected:(BOOL)selected;

@end

