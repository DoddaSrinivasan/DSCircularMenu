//
//  CircularMenuViewController.m
//  DSCircularMenu
//
//  Created by Srinivasan Dodda on 26/07/16.
//  Copyright © 2016 Dodda Srinivasan. All rights reserved.
//

#import "CircularMenuViewController.h"
#import "MenuCell.h"

@interface CircularMenuViewController ()

@end

@implementation CircularMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;

    [self setMenu:CGPointMake(screenWidth/2, screenHeight-25)
           radius:screenWidth/2 - 25
      andItemSize:CGSizeMake(50, 50)];
    
    [self registerNib:[UINib nibWithNibName:@"MenuCell" bundle:[NSBundle mainBundle]] forReuseIdentifier:@"MenuCell"];
}

-(NSInteger)noOfMenuItems{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView menuItemAt:(NSInteger)index{
    MenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MenuCell" forIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    return cell;
}

-(UIViewController *)viewControllerForMenuItemAt:(NSUInteger)index{
    return nil;
}

@end
