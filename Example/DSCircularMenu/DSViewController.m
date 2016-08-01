//
//  DSViewController.m
//  DSCircularMenu
//
//  Created by Srinivasan Dodda on 01/08/16.
//  Copyright © 2016 Dodda Srinivasan. All rights reserved.
//

#import "DSViewController.h"

@interface DSViewController ()

@end

@implementation DSViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    _indexLabel.text = [NSString stringWithFormat:@"Controller %d", (int)_index];
}

@end
