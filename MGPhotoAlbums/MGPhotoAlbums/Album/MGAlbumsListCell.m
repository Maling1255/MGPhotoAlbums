//
//  MGAlbumsListCell.m
//  MGPhotoAlbums
//
//  Created by maling on 2018/12/20.
//  Copyright © 2018 maling. All rights reserved.
//

#import "MGAlbumsListCell.h"
#import <Photos/Photos.h>
#import "MGPhotoAlbums.h"

@interface MGAlbumsListCell ()

@property (assign, nonatomic) PHImageRequestID requestId;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;


@end

@implementation MGAlbumsListCell

- (void)setConllection:(MGCollection *)conllection
{
    _conllection = conllection;
    
    self.titleLbl.text = conllection.albumName;
    
    self.countLbl.text = [NSString stringWithFormat:@"%ld", conllection.albumValue.count];
    
    if (_requestId) {
        [[PHImageManager defaultManager] cancelImageRequest:_requestId];
    }
    
    PHAsset *asset = conllection.albumValue.firstObject;
    
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
                
                [weakSelf.iconImageView setImage:result];
            }
        }];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
