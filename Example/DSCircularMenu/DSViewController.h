//
//  DSViewController.h
//  DSCircularMenu
//
//  Created by Srinivasan Dodda on 01/08/16.
//  Copyright © 2016 Dodda Srinivasan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSViewController : UIViewController

@property (assign, nonatomic) NSUInteger *index;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;

@end
