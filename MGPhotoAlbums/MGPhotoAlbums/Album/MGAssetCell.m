//
//  MGAssetCell.m
//  MGPhotoAlbums
//
//  Created by maling on 2018/12/20.
//  Copyright © 2018 maling. All rights reserved.
//

#import "MGAssetCell.h"
#import <Photos/Photos.h>

@interface MGAssetCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIView *maskView;

@property (assign, nonatomic) PHImageRequestID requestId;

@end
@implementation MGAssetCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.selectedBtn.layer.cornerRadius = 15;
        
        self.selectedBtn.layer.masksToBounds = YES;
        
    }
    return self;
}

- (IBAction)clickSelectBtn:(UIButton *)button
{
    button.selected = !button.selected;
    
    if (self.selectBtnEvent) {
        
        NSArray *tempArray = self.selectBtnEvent(button);
        
        if (tempArray && self.complete) {
            
            self.complete(tempArray);
        }
    }
    
    if (!button.selected)
    {
        [button setTitle:nil forState:UIControlStateNormal];
    }
    
}

- (void)didSelectedBtn:(NSArray *(^)(UIButton *selectedBtn))selectBtnEvent complete:(void(^)(NSArray *array))complete
{
    self.selectBtnEvent = selectBtnEvent;
    
    self.complete = complete;
}

- (void)markNumber:(id)number selected:(BOOL)selected
{
    if (selected) {
        
        if ([number integerValue] >= MGMaxSelextedCount)  return;
        
        NSString * title = [NSString stringWithFormat:@" %ld ",[number integerValue] + 1];
        
        [self.selectedBtn setTitle:title forState:UIControlStateNormal];
        self.selectedBtn.titleLabel.backgroundColor = [UIColor blueColor];
        self.selectedBtn.titleLabel.layer.cornerRadius = 10;
        self.selectedBtn.titleLabel.layer.masksToBounds = YES;
        
        [self.selectedBtn setSelected:YES];

    }
    else
    {
        [self.selectedBtn setTitle:nil forState:UIControlStateNormal];
        self.selectedBtn.titleLabel.backgroundColor = [UIColor clearColor];
        [self.selectedBtn setSelected:NO];

    }
}

- (void)selectedOfCell:(BOOL)selected selectArray:(NSArray *)selectArray
{
    if (selectArray.count == MGMaxSelextedCount) {
        
        self.maskView.hidden = selected;
    }
    else
    {
        self.maskView.hidden = YES;
    }
}


- (void)setPhotoWithAsset:(id)assetItem
{
    
    if (_requestId) {
        [[PHImageManager defaultManager] cancelImageRequest:_requestId];
    }
    
    PHAsset *asset = (PHAsset *)assetItem;
    
    PHImageRequestOptions * options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    
    CGFloat width = self.frame.size.width * 2;
    CGFloat height = width / asset.pixelWidth * asset.pixelHeight;
    if (height < self.frame.size.height) {
        height = self.frame.size.height * 2;
        width = height / asset.pixelHeight * asset.pixelWidth;
    }
    
    WeakSelf(weakSelf);
    if (asset) {
        
      _requestId = [[PHImageManager defaultManager] requestImageForAsset:asset
                                                              targetSize:CGSizeMake(width, height)
                                                             contentMode:PHImageContentModeAspectFill
                                                                 options:options
                                                           resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                               
            if (result) {
                
                [weakSelf.bgImageView setImage:result];
            }
        }];
    }
    
}

@end
