# DSCircularMenu
DSCircularMenu is a custom container view controller to provide a circular menu based navigation. It Comes with a simple set up and delegate methods similar to collection or table view. 

<br>

![](http://res.cloudinary.com/dm6lqaxjt/image/upload/v1472538429/DSCircularMenu.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

DSCircularMenu is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod "DSCircularMenu"
```


##Setup

1. Create a ViewController and subclass it with DSCircularMenuRevealController.
2. Create an subclass of UICollectionViewCell for menuItem. Make sure you generate an XIB too. And design the MenuItem as you wish
3. In the ViewController's view did load method configure the menu and register MenuItem

```
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;

    [self setMenuWithCentre:CGPointMake(screenWidth/2, screenHeight-40)
          radius:screenWidth/2 - 40
          andItemSize:CGSizeMake(50, 50)];
    
    [self registerNib:[UINib nibWithNibName:@"MenuCell" bundle:[NSBundle mainBundle]] forReuseIdentifier:@"MenuCell"];
```
 4 . Now Over ride the following methods in the ViewController

```
-(NSInteger)noOfMenuItems{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView menuItemAt:(NSInteger)index{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MenuCell" forIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    
    // Customize the menu item
    
    return cell;
}

-(UIViewController *)viewControllerForMenuItemAt:(NSUInteger)index{
    //Add your custom logic to return the corresponding view controller for that MenuItem
    UIViewController *ctrl = [UIViewController alloc] init];
    
    return ctrl;
}
```


## Author

Dodda Srinivasan, srinivasan.munna@gmail.com

## License

DSCircularMenu is available under the MIT license. See the LICENSE file for more info.
