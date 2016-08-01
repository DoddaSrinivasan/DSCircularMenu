//
//  DSCircularMenuController.h
//  Pods
//
//  Created by Srinivasan Dodda on 25/07/16.
//
//

#import <UIKit/UIKit.h>
@import DSCircularCollectionView;
#import "DSMenuViewController.h"

@class DSCircularMenuRevealController;

#pragma mark - DSCircularMenuRevealController Class
@interface DSCircularMenuRevealController : UIViewController <DSMenuViewControllerDataSource>

// Front view controller, can be nil on initialization but must be supplied by the time its view is loaded
@property (strong, nonatomic, nonnull) UIViewController *frontViewController;

// Default duration for the revealToggle animation, default is 0.25
@property (assign, nonatomic) NSTimeInterval toggleAnimationDuration;

@property (strong, nonatomic, nonnull) UIView *frontView;
@property (strong, nonatomic, nonnull) UIView *menuView;
@property (strong, nonatomic, nonnull) UIView *menuOverLayContainer;
@property (strong, nonatomic, nonnull) UIView *menuOverLayView;
@property (strong, nonatomic, nonnull) UIView *menuButtonView;


-(void)registerClass:(nullable Class)cellClass forReuseIdentifier:(NSString * _Nonnull)identifier;
-(void)registerNib:(nullable UINib *)nib forReuseIdentifier:(NSString * _Nonnull)identifier;

-(void)setMenu:(CGPoint)centre radius:(CGFloat)radius andItemSize:(CGSize)itemSize;
-(void)setMenuStartAngle:(CGFloat)startAngle andEndAngle:(CGFloat)endAngle;
-(void)setMenuXMirror:(BOOL)xMirror yMirror:(BOOL)yMirror;
-(void)setMenu:(UICollectionViewScrollDirection)scrollDirection;

-(void)reloadMenuItems;
-(nonnull UIViewController *)viewControllerForMenuItemAt:(NSInteger)index;
-(void)setFrontViewController:(nonnull UIViewController *)frontViewController;

-(void)showMenu;
-(void)hideMenu;

@end


#pragma mark - UIViewController(DSCircularMenuController) Category
@interface UIViewController(DSCircularMenuController)

- (nonnull DSCircularMenuRevealController *)circularMenuViewController;

@end
