//
//  CircularMenuViewController.m
//  DSCircularMenu
//
//  Created by Srinivasan Dodda on 26/07/16.
//  Copyright © 2016 Dodda Srinivasan. All rights reserved.
//

#import "CircularMenuViewController.h"
#import "DSViewController.h"
#import "MenuCell.h"

@interface CircularMenuViewController ()

@end

@implementation CircularMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;

    [self setMenuWithCentre:CGPointMake(screenWidth/2, screenHeight-40)
           radius:screenWidth/2 - 40
      andItemSize:CGSizeMake(50, 50)];
    
    [self registerNib:[UINib nibWithNibName:@"MenuCell" bundle:[NSBundle mainBundle]] forReuseIdentifier:@"MenuCell"];
    
    DSViewController *vc = (DSViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"DSViewController"];
    vc.index = 0;
    [self setFrontViewController:vc];
}

-(NSInteger)noOfMenuItems{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView menuItemAt:(NSInteger)index{
    MenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MenuCell" forIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    [cell.lblIndex setText:[NSString stringWithFormat:@"%d",(int)index]];
    return cell;
}

-(UIViewController *)viewControllerForMenuItemAt:(NSUInteger)index{
    DSViewController *viewController = (DSViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"DSViewController"];
    viewController.index = index;
    return viewController;
}

@end
