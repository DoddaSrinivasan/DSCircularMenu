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
    int menuOverlayExpandedWidth;
}

@end

@implementation DSCircularMenuRevealController

-(void)viewDidLoad {
    [super viewDidLoad];
    _menuViewController = [[DSMenuViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    _menuViewController.dataSource = self;
    _menuViewController.view.backgroundColor = [UIColor clearColor];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    menuOverlayExpandedWidth = sqrt(pow(screenSize.height, 2) + pow(screenSize.width/2, 2));
    [self addChildViewController:_menuViewController toView:_menuView];
}

-(void)loadView{
    [super loadView];
    
    CGRect bounds = self.view.bounds;
    
    CGRect menuButtonBounds = self.view.bounds;
    menuButtonBounds.size.width = 60;
    menuButtonBounds.size.height = 60;
    
    _frontView = [[UIView alloc] initWithFrame:bounds];
    _frontView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _frontView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_frontView];
    
    
    _menuOverLayContainer = [[UIView alloc] initWithFrame:bounds];
    _menuOverLayContainer.backgroundColor = [UIColor clearColor];
    _menuOverLayContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_menuOverLayContainer];
    [self addConstraintsToChildView:_menuOverLayContainer forView:self.view];
    
    _menuOverLayView = [[UIView alloc] initWithFrame:menuButtonBounds];
    _menuOverLayView.layer.cornerRadius = 30;
    _menuOverLayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    _menuOverLayView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [_menuOverLayContainer addSubview:_menuOverLayView];
    
    _menuView = [[UIView alloc] initWithFrame:bounds];
    _menuView.backgroundColor = [UIColor clearColor];
    _menuView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_menuView];
    
    _menuButtonView = [[UIView alloc] initWithFrame:menuButtonBounds];
    _menuButtonView.layer.cornerRadius = 30;
    _menuButtonView.backgroundColor = [UIColor redColor];
    _menuButtonView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_menuButtonView];
    
    UITapGestureRecognizer *menuTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMenuTap:)];
    [_menuButtonView addGestureRecognizer:menuTapRecognizer];
    
    _menuView.hidden = YES;
    _menuOverLayContainer.hidden = YES;
}

- (void)handleMenuTap:(UITapGestureRecognizer *)recognizer {
    if(_menuView.hidden){
        [self showMenu];
    }else{
        [self hideMenu];
    }
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

#pragma mark - menu methods

-(void)showMenu{
    if(!_menuViewController.isAnimating){
        _menuView.hidden = NO;
        _menuOverLayContainer.hidden = NO;
        [UIView animateWithDuration:.3
                         animations:^
         {
             self.menuOverLayView.transform = CGAffineTransformMakeScale(2*menuOverlayExpandedWidth/60, 2*menuOverlayExpandedWidth/60);
             [_menuOverLayContainer layoutIfNeeded];
         } completion:^(BOOL finished) {
             
         }];
        [_menuViewController showMenu];
    }
}

-(void)hideMenu{
    if(!_menuViewController.isAnimating){
        [UIView animateWithDuration:.3
                         animations:^
         {
             self.menuOverLayView.transform = CGAffineTransformMakeScale(1,1);
             [_menuOverLayContainer layoutIfNeeded];
         } completion:^(BOOL finished) {
             _menuView.hidden = YES;
             _menuOverLayContainer.hidden = YES;
         }];
        [_menuViewController hideMenu];
    }
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

-(void)setMenuWithCentre:(CGPoint)centre radius:(CGFloat)radius andItemSize:(CGSize)itemSize{
    if(_menuViewController.circularLayout == nil){
        _menuViewController.circularLayout = [[DSCircularLayout alloc] init];
    }
    
    [_menuViewController.circularLayout initWithCentre:centre
                             radius:radius
                           itemSize:itemSize
                  andAngularSpacing:20];
    
    CGRect menuButtonFrame = [_menuButtonView frame];
    menuButtonFrame.origin.x = centre.x - 30;
    menuButtonFrame.origin.y = centre.y - 30;
    _menuButtonView.frame = menuButtonFrame;
    _menuOverLayView.frame = menuButtonFrame;
    
    [_menuViewController.circularLayout setStartAngle:M_PI endAngle:0];
    _menuViewController.circularLayout.mirrorX = NO;
    _menuViewController.circularLayout.mirrorY = NO;
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

-(UIViewController *)viewControllerForMenuItemAt:(NSUInteger)index{
    [self doesNotRecognizeSelector:_cmd];
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return nil;
}

-(void)selectedMenuItemAt:(NSInteger)index{
    UIViewController *controller = [self viewControllerForMenuItemAt:index];
    [self setFrontViewController:controller];
    [self handleMenuTap:nil];
}

@end
