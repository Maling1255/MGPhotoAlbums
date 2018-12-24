//
//  MGAssetCollectionController.m
//  MGPhotoAlbums
//
//  Created by maling on 2018/12/20.
//  Copyright © 2018 maling. All rights reserved.
//

#import "MGAssetCollectionController.h"
#import "MGAssetCell.h"
#import "MGPhotoAlbums.h"
#import "MGAlbumTool.h"
#import "ViewController.h"

static NSString * const reuseidentifier = @"assetCellID";

@interface MGAssetCollectionController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *displayCollectionView;
@property (nonatomic, strong) MGAlbumTool *albumTool;
@property (nonatomic, strong) NSArray *selectedArray;

@end

@implementation MGAssetCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

    layout.itemSize = CGSizeMake(80, 120);
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 10;
    
    _displayCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _displayCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _displayCollectionView.dataSource = self;
    _displayCollectionView.delegate = self;
    _displayCollectionView.backgroundColor = [UIColor whiteColor];
    _displayCollectionView.alwaysBounceVertical = YES;
    
    [self.view addSubview:_displayCollectionView];
    
    [self.displayCollectionView registerNib:[UINib nibWithNibName:@"MGAssetCell" bundle:nil] forCellWithReuseIdentifier:reuseidentifier];
    
    _albumTool = [[MGAlbumTool alloc] init];
    
    _albumTool.conllection = self.conllection;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishEvent)];
}

- (void)finishEvent
{
   ViewController *vc = self.navigationController.viewControllers[0];
    
    if (vc.displayAlbum) {
        vc.displayAlbum(@[@"dd", @"aa", @"ss"]);
    }
    
    [self.navigationController popToViewController:vc animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.conllection.albumValue.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   MGAssetCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseidentifier forIndexPath:indexPath];
    
    [cell setPhotoWithAsset:self.conllection.albumValue[indexPath.row]];
    
    [cell selectedOfCell:[_albumTool.selectStatus[indexPath.row] boolValue] selectArray:self.selectedArray];

    WeakSelf(weakSelf);
    [cell didSelectedBtn:^NSArray *(UIButton *selectedBtn) {
       
        return [weakSelf.albumTool selectItemAtIndex:indexPath collectionView:weakSelf.displayCollectionView];
        
    } complete:^(NSArray *array) {
        
        weakSelf.selectedArray = array.mutableCopy;
    }];

    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    MGAssetCell *currentSelectCell = (MGAssetCell *)cell;
    
    NSArray *allSelectedIndexPaths = [_albumTool getCurrentIndexPath];
    
    for (NSIndexPath *index in allSelectedIndexPaths) {

        if (index.row == indexPath.row) {
            
            NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:indexPath.item inSection:0];
            
            NSInteger count = [_albumTool.selectedOfIndexPaths indexOfObject:tempIndexPath];
            
            [currentSelectCell markNumber:@(count) selected:YES];
            
            return;
        }
        else
        {
            [currentSelectCell markNumber:nil selected:NO];
            
        }
    }
    
    
//    NSLog(@">>> %ld", currentSelectCell.currentSelectIndexPaths.count);
    
//   if (currentSelectCell.currentSelectIndexPaths.count == MGMaxSelextedCount - 1)
//   {
//       currentSelectCell.maskView.hidden = YES;
//   }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    MGAssetCell *cell = (MGAssetCell *)[self.displayCollectionView cellForItemAtIndexPath:indexPath];

}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
