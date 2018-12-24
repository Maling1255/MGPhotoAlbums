//
//  MGAlbumsListController.m
//  MGPhotoAlbums
//
//  Created by maling on 2018/12/19.
//  Copyright © 2018 maling. All rights reserved.
//

#import "MGAlbumsListController.h"
#import "MGPhotoAlbums.h"
#import "MGAlbumsListCell.h"
#import "MGAssetCollectionController.h"

static NSString *const reuseIdentifier = @"albumListCellID";
@interface MGAlbumsListController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *displayTableView;
@property (nonatomic, strong) MGPhotoAlbums *photoAlbums;

@property (nonatomic, strong) NSArray *collections;

@end

@implementation MGAlbumsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
    
    [self loadData];
    
}

- (void)setupSubviews
{
    self.displayTableView.delegate = self;
    
    self.displayTableView.dataSource = self;
    
    self.displayTableView.rowHeight = 80;
    
    self.displayTableView.tableFooterView = [UIView new];
    
    [self.displayTableView registerNib:[UINib nibWithNibName:@"MGAlbumsListCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
}

- (void)loadData
{
   self.photoAlbums = [MGPhotoAlbums albums];
 
    WeakSelf(weakSelf);
    [self.photoAlbums albumListData:^(NSArray * _Nonnull collections) {
        
        weakSelf.collections = collections;
        
        [weakSelf.displayTableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.collections.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGAlbumsListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    MGCollection *conllection = self.collections[indexPath.row];

    cell.conllection = conllection;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MGCollection *conllection = self.collections[indexPath.row];
    
    MGAssetCollectionController *collectionVC = [[MGAssetCollectionController alloc] init];
    
    collectionVC.conllection = conllection;
    
    [self.navigationController pushViewController:collectionVC animated:YES];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


