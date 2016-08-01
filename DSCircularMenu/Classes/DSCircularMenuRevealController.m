//
//  DSCircularMenuController.m
//  Pods
//
//  Created by Srinivasan Dodda on 25/07/16.
//
//

#import "DSCircularMenuRevealController.h"

@interface DSCircularMenuRevealController (){
    DSMenuViewController *_menuViewController;
}

@end

@implementation DSCircularMenuRevealController

-(void)viewDidLoad {
    [super viewDidLoad];
    _menuViewController = [[DSMenuViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    _menuViewController.dataSource = self;
    _menuViewController.view.backgroundColor = [UIColor clearColor];
    [self addChildViewController:_menuViewController toView:_menuView];
}

-(void)loadView{
    [super loadView];
    CGRect bounds = self.view.bounds;
    
    _frontView = [[UIView alloc] initWithFrame:bounds];
    _frontView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _frontView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_frontView];
    
    _menuView = [[UIView alloc] initWithFrame:bounds];
    _menuView.backgroundColor = [UIColor clearColor];
    _menuView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_menuView];
    
    //[self.view bringSubviewToFront:_frontView];
}

-(void)addChildViewController:(UIViewController *)childVc toView:(UIView *)view{
    [self addChildViewController:childVc];
    [view addSubview:childVc.view];
    [childVc didMoveToParentViewController:self];
    [self addConstraintsToChildView:childVc.view forView:view];
}

-(void)addConstraintsToChildView:(UIView *)childView forView:(UIView *)view{
    NSDictionary *views = NSDictionaryOfVariableBindings(childView);
    childView.translatesAutoresizingMaskIntoConstraints = NO;
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[childView]-(0)-|" options:0 metrics:nil views:views]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[childView]-(0)-|" options:0 metrics:nil views:views]];
}

-(void)setFrontViewController:(UIViewController *)frontViewController{
    if(_frontViewController != nil){
        [_frontViewController removeFromParentViewController];
        for(UIView *view in [_frontView subviews]){
            [view removeFromSuperview];
        }
    }
    _frontViewController = frontViewController;
    [self addChildViewController:_frontViewController toView:_frontView]; 
}

#pragma mark - orientation and preferred status bar

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    if(_frontViewController == nil){
        return [super preferredStatusBarStyle];
    }else{
        return [_frontViewController preferredStatusBarStyle];
    }
}

#pragma mark - Menu set up methods
-(void)registerClass:(nullable Class)cellClass forReuseIdentifier:(NSString *)identifier{
    [_menuViewController.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
    
}

-(void)registerNib:(UINib *)nib forReuseIdentifier:(NSString *)identifier{
    [_menuViewController.collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
}

-(void)setMenu:(CGPoint)centre radius:(CGFloat)radius andItemSize:(CGSize)itemSize{
    if(_menuViewController.circularLayout == nil){
        _menuViewController.circularLayout = [[DSCircularLayout alloc] init];
    }
    [_menuViewController.circularLayout initWithCentre:centre
                             radius:radius
                           itemSize:itemSize
                  andAngularSpacing:20];
    [_menuViewController.circularLayout setStartAngle:M_PI endAngle:0];
    _menuViewController.circularLayout.mirrorX = NO;
    _menuViewController.circularLayout.mirrorY = NO;
    _menuViewController.circularLayout.rotateItems = YES;
    _menuViewController.circularLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [_menuViewController.collectionView setCollectionViewLayout:_menuViewController.circularLayout];
    [_menuViewController.collectionView.collectionViewLayout invalidateLayout];
}

-(void)setMenuStartAngle:(CGFloat)startAngle andEndAngle:(CGFloat)endAngle{
    [_menuViewController.circularLayout setStartAngle:startAngle endAngle:endAngle];
    [_menuViewController.collectionView.collectionViewLayout invalidateLayout];
}

-(void)setMenuXMirror:(BOOL)xMirror yMirror:(BOOL)yMirror{
    _menuViewController.circularLayout.mirrorX = xMirror;
    _menuViewController.circularLayout.mirrorY = yMirror;
    [_menuViewController.collectionView.collectionViewLayout invalidateLayout];
}

-(void)setMenu:(UICollectionViewScrollDirection)scrollDirection{
    _menuViewController.circularLayout.scrollDirection = scrollDirection;
    [_menuViewController.collectionView.collectionViewLayout invalidateLayout];
}

-(void)reloadMenuItems{
    [_menuViewController.collectionView.collectionViewLayout invalidateLayout];
    [_menuViewController.collectionView reloadData];
}

#pragma mark - DSMenuViewControllerDataSource

-(NSInteger)noOfMenuItems{
    [self doesNotRecognizeSelector:_cmd];
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView menuItemAt:(NSInteger)index{
    [self doesNotRecognizeSelector:_cmd];
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return nil;
}

-(UIViewController *)viewControllerForMenuItemAt:(NSInteger)index{
    [self doesNotRecognizeSelector:_cmd];
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return nil;
}

-(void)selectedMenuItemAt:(NSInteger)index{
    UIViewController *controller = [self viewControllerForMenuItemAt:index];
    [self setFrontViewController:controller];
}

@end
