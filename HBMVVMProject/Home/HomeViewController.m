//
//  HomeViewController.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2019/7/9.
//  Copyright © 2019年 hongbao.cui. All rights reserved.
//

#import "HomeViewController.h"
#import <OpenGLES/ES1/glext.h>
typedef struct BinaryTreeNode {
    int m_value;
    struct BinaryTreeNode *m_pLeft;
    struct BinaryTreeNode *m_pRight;
}TreeNode;

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    int a[] = {4,4,5,6,8,8,3,3,1,1,3};
    int b[] = {9,0,3,1,7};
    int count = sizeof(a)/sizeof(int);
//    sort(a,count);
  int index =  search(a, count,8);
    printf("er char ---index--->%d",index);
    
    
//    [self createTree:a length:count];
    
}
-(TreeNode *)createTree:(TreeNode *)treeNode  data:(int *)a{
    if (treeNode ==NULL) {
        return NULL;
    }
    TreeNode *node = (TreeNode *)malloc(sizeof(TreeNode));
    node->m_value = *a;
    treeNode->m_pLeft = [self createTree:treeNode data:a++];
    treeNode->m_pRight = [self createTree:treeNode data:a++];
    return treeNode;
}

- (TreeNode *)createTree:(int *)a  length:(int )length{
    for (int i=0; i<length; i = i+3) {
        TreeNode *node = (TreeNode *)malloc(sizeof(TreeNode));
        node->m_value = a[i];
        if (node->m_pLeft) {
            NSLog(@"node->m_pLeft:%@",node->m_pLeft);
            node->m_pLeft->m_value =a[i+1];
        }
        if (node->m_pRight) {
            NSLog(@"node->m_pLeft:%@",node->m_pRight);
            node->m_pRight->m_value =a[i+2];
        }
    }
    return NULL;
    
//    if (node == NULL||((a++) == '\0')) {
//        return NULL;
//    }
//    if (node->m_pLeft) {
//
//    }
//    return node;
}
//二分查找
int  search(int a[],int numbercount, int se) {
    int min = 0;
    int max = numbercount;
    int midde;
    while (true) {
        midde = (max-min)/2+min;
        if (a[midde] == se) {
            return midde;
        }
        if(a[midde]<se) {
            min = midde;
        }
        if (a[midde]>se) {
            max = midde;
        }
        
    }
    
}


void quicklySort(int a[],int low,int high) {
    int k = a[low];
    int i= low;
    int j = high + 1;
    while (i<j) {
        
//        while (left) {
//            <#statements#>
//        }
        while (a[i]<k) {
            
        }
        
    }
    
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
