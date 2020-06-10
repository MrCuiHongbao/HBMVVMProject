//
//  HomeViewController.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2019/7/9.
//  Copyright © 2019年 hongbao.cui. All rights reserved.
//

#import "HomeViewController.h"
#import <OpenGLES/ES1/glext.h>
#import "HBOrderTools.h"
#import "BeatyViewController.h"
#import "HBBlockViewController.h"
#import "HBMVVMProject-Swift.h"
#include <string>
#include <vector>
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initTableView];
//    int m[10];
//    for (int i=0; i<10; i++) {
//        m[i] = i;
//        printf("viewDidLoad----->%d\n",i);
//    }
//
//    return;
//
    int a[] = {4,4,5,6,8,8,3,3,1,1,3};
//    int b[] = {9,0,3,1,7};
    int count = sizeof(a)/sizeof(int);
    sort(a,count);
//  int index =  search(a, count,8);
//    printf("er char ---index--->%d",count);
    
    BuildBinaryTreeAndGetOrder();
    LinkTreeHasCycle();
    
//    int a[11] = {5,3,7,6,4,1,0,2,9,10,8};
    int length = sizeof(a)/sizeof(int);
//    quickSort(a, length-1, 0, length-1);
    buildMaxHeap(a, length);
    for (int i=0; i<length-1; i++) {
        printf("quick sort list is %d\n",a[i]);
    }
    
//    std::string  cccc = "cuihongbao";
//    std::string  ssss = convertString(cccc, 3);
//    NSLog(@"%@",[NSString stringWithCString:ssss.c_str() encoding:NSUTF8StringEncoding]);
//    
//    cccc = "abcdabcbb";
//   length = lengthOfLongestSubstring(cccc);
//    printf("%d\n",length);
//    
//    std::vector<int> inVec{7,11,15,2};
//    std::vector<int> nVec= twoSum(inVec,9);
//    std::vector<int>::iterator iter;
//    for (iter = nVec.begin(); iter != nVec.end(); iter++)
//     {
//         printf("x = %d\n",*iter);
//     }
//    NSString *cui = @"Hello";
//    char  *ss  = (char *)[cui cStringUsingEncoding:NSUTF8StringEncoding];
//    revertString(ss);
//    revertString(ss);
//    NSLog(@"%@",[NSString stringWithCString:cui.c_str() encoding:NSUTF8StringEncoding]);
    
    
//    int length1 = sizeof(a)/sizeof(int);

//    buildMaxHeap(a, length);
}
- (void)initTableView {
    self.dataArray = [NSMutableArray arrayWithCapacity:1.0];
    [self.dataArray  addObject:@"美女图片"];
    [self.dataArray  addObject:@"Block"];
    [self.dataArray  addObject:@"SF"];
    UITableView *tempTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tempTableView.delegate = self;
    tempTableView.dataSource = self;
    [self.view addSubview:tempTableView];
    [tempTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"myCell"];
    [tempTableView setAccessibilityIdentifier:@"cuihongbao"];
}
#pragma mark- tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            BeatyViewController *beatyVC = [[BeatyViewController alloc] init];
            [self.navigationController pushViewController:beatyVC animated:YES];
        }
            break;
        case 1:{
            HBBlockViewController *block = [[HBBlockViewController alloc] init];
            [self.navigationController pushViewController:block animated:YES];
        }
        break;
        case 2: {
            HBSFViewController *sf = [[HBSFViewController alloc] init];
            [self.navigationController pushViewController:sf animated:YES];
        }break;
        default:
            break;
    }
}
#pragma mark-
//二叉树
void  BuildBinaryTreeAndGetOrder() {
//    int preorder[] = {62,15,12,46,35,57,68,65,79};
    int inorder[] = {12,15,35,46,57,62,65,68,79};
    int postorder[] = {12,35,57,46,15,65,79,68,62};
    
    HBOrderTools *tools = [[HBOrderTools alloc] init];
    TreeNode *tree =buildTree(inorder, 9, postorder, 9);
//    [tools preOrder:tree];//前序遍历
//   int *a = preSort(tree);
//    [tools inOrder:tree];//中序遍历
//    int *a = inOrder(tree);
//    int *a = postOrder(tree);
//   for (int i=0; i<sizeof(inorder)/sizeof(int); i++) {
//        printf("array is:%d\n",*(a+i));
//    }
    [tools postOrder:tree];//后序遍历
    [tools levelOrder:tree];//层序遍历
}
//单链表
void LinkTreeHasCycle() {
    int a[] = {12,15,35,18,57,62,65,18,79};
   LinkTreeNode *node =createLinkTree(a, 9);
    
    LinkTreeNode *link = reverLinkTreeNode(node);
    while (link) {
        printf("data is------->%d\n",link->data);
        link = link->nextNode;
    }
//    HBOrderTools *tools = [[HBOrderTools alloc] init];
    bool iscycle = hasCycle(node);
    printf("LinkTreeHasCycle yes or no :answer is:%d",iscycle);
    LinkTreeNode *node_enter  = cycleEnterPlace(node);
    printf("LinkTreeNode enter place :answer is:%d",node_enter->data);
}
void sort(int a[],int count) {
    int  different= 0;
    for (int i=0; i<count; i++) {
        different = different^a[i];
    }
    different &= -different;
    int ans[2] = {0,0};
    for (int i=0; i<count; i++) {
        if ((different&i) == 0) {
            ans[0] ^=i;
        } else {
            ans[1] ^=i;
        }
    }
    printf("printf is ------number0--->%d\n ------number1--->%d",ans[0],ans[1]);
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
