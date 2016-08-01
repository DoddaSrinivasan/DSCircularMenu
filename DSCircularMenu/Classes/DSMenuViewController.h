//
//  MenuViewController.h
//  Pods
//
//  Created by Srinivasan Dodda on 26/07/16.
//
//

#import <UIKit/UIKit.h>
#import "DSCircularLayout.h"

@protocol DSMenuViewControllerDataSource;

@interface DSMenuViewController : UICollectionViewController

@property (strong, nonatomic) DSCircularLayout *circularLayout;

@property (weak, nonatomic) id<DSMenuViewControllerDataSource> dataSource;

@end

@protocol DSMenuViewControllerDataSource <NSObject>

@required
-(NSInteger)noOfMenuItems;
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView menuItemAt:(NSInteger)index;

@end
