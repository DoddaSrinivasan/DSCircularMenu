//
//  MenuViewController.m
//  Pods
//
//  Created by Srinivasan Dodda on 26/07/16.
//
//

#import "DSMenuViewController.h"

@interface DSMenuViewController (){
    NSInteger _menuItemsCount;
    BOOL _isAnimating;
}

@end

@implementation DSMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _menuItemsCount = 0;
    _circularLayout = [[DSCircularLayout alloc] init];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _menuItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [_dataSource collectionView:collectionView menuItemAt:indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [_dataSource selectedMenuItemAt:indexPath.item];
}

-(void)showMenu{
    _isAnimating = YES;
    [self.collectionView performBatchUpdates:^{
        CGFloat originalAnimationDuration = [CATransaction animationDuration];
        CGFloat newAnimationDuration = 0.2;
        [self.collectionView.viewForFirstBaselineLayout.layer setSpeed:originalAnimationDuration/newAnimationDuration];
        for(int i=0; i<(int)[_dataSource noOfMenuItems]; i++){
            [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:i inSection:0]]];
        }
        _menuItemsCount = [_dataSource noOfMenuItems];
        [self.collectionView layoutIfNeeded];
    } completion:^(BOOL finished) {
        _isAnimating = NO;
    }];
}

-(void)hideMenu{
    _isAnimating = YES;
    [self.collectionView performBatchUpdates:^{
        CGFloat originalAnimationDuration = [CATransaction animationDuration];
        CGFloat newAnimationDuration = 0.2;
        [self.collectionView.viewForFirstBaselineLayout.layer setSpeed:originalAnimationDuration/newAnimationDuration];
        for(int i = _menuItemsCount-1; i >= 0; i--){
            [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:i inSection:0]]];
        }
        _menuItemsCount = 0;
        [self.collectionView layoutIfNeeded];
    } completion:^(BOOL finished) {
        _isAnimating = NO;
    }];
    
}

@end
