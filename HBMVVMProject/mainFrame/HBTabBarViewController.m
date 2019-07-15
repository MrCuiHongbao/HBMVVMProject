//
//  HBTabBarViewController.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2019/7/2.
//  Copyright © 2019年 hongbao.cui. All rights reserved.
//

#import "HBTabBarViewController.h"
#import "HBRouter.h"
@interface HBTabBarViewController ()
@end

@implementation HBTabBarViewController
- (instancetype)initWithViewControllers:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        NSMutableArray *viewsVC = [NSMutableArray arrayWithCapacity:1.0];
        NSArray *views = [dict objectForKey:@"HBTabBarModule"];
        NSInteger index = 0;
        NSMutableArray *items = [NSMutableArray arrayWithCapacity:1.0];
        for (NSString *className in views) {
            NSString *classFormate = [NSString stringWithFormat:@"router://%@/%@exportInterface",className,className];
            UIViewController  *vc = [HBRouter openURL:classFormate arg:nil error:nil completion:^(id  _Nullable object) {
                NSLog(@"object----->%@",object);
            }];
            if (vc) {
                [viewsVC addObject:vc];
            }
            UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"1221" image:nil tag:index];
            [items addObject:item];
            index++;
        }
        self.viewControllers = viewsVC;
        self.customizableViewControllers = viewsVC;
//        [self.tabBar setItems:items animated:YES];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
