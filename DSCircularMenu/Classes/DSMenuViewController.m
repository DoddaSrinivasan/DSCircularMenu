//
//  MenuViewController.m
//  Pods
//
//  Created by Srinivasan Dodda on 26/07/16.
//
//

#import "DSMenuViewController.h"

@interface DSMenuViewController ()

@end

@implementation DSMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _circularLayout = [[DSCircularLayout alloc] init];
    self.collectionView.backgroundColor = [UIColor clearColor];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataSource noOfMenuItems];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [_dataSource collectionView:collectionView menuItemAt:indexPath.item];
    return cell;
}

@end
