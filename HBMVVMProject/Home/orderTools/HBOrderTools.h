//
//  HBOrderTools.h
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/3/6.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import <Foundation/Foundation.h>
#include<unordered_map>

//NS_ASSUME_NONNULL_BEGIN
typedef  struct treeNode {
    int data;
   struct treeNode *leftChild;
   struct treeNode *rightChild;
}TreeNode;

typedef struct linkTreeNode  {
    int data;
    int index;//标记位
    struct linkTreeNode *nextNode;
}LinkTreeNode;

@interface HBOrderTools : NSObject

#pragma mark-- 创建二叉树 ，前序遍历，中序遍历，后序遍历，层序遍历
#pragma mark-
/*
参考链接
https://blog.csdn.net/seagal890/article/details/79772657
*/

TreeNode *buildTree(int inorder[], int alength,int postorder[],int blength);

/*
    * 二叉树的前序遍历
    * */
- (NSMutableArray *)preOrder:(TreeNode *)root;


/*
    * 二叉树的中序遍历
    * */
- (NSMutableArray *)inOrder:(TreeNode *)root;

 /*
     * 二叉树的后续遍历
     * */

- (NSMutableArray *)postOrder:(TreeNode *)root;

/*
    * 二叉树的层次遍历算法设计levelOrder
    * */
- (NSMutableArray *)levelOrder:(TreeNode *)root;



#pragma mark-- 判断单链表是否有环
#pragma mark-
/*
参考链接
https://blog.csdn.net/Leon_cx/article/details/81430822
 有几种方法
 1. 空间复杂度o (n),时间复杂度o(n)  hashset方法，每遍历一个就放在hashset中，直至找到相同的对象
 2. 空间复杂度o(1), 时间复杂度o(n*n), 遍历，每遍历到一个节点，再从前遍历一次找到是否有相同的
 3.  快慢指针，两个指针都到环中后，快指针一定会赶上慢指针
*/

LinkTreeNode *createLinkTree(int a[],int length);

//单链表是否有环
bool hasCycle(LinkTreeNode *node);

//找到环入口的节点
LinkTreeNode *cycleEnterPlace(LinkTreeNode *node);

#pragma mark-- 求数组里连续子数组的最大的和
#pragma mark-
/*
 如果已知前n-1个数的中的连续最大和，和靠右连续的最大连续和，便可以求得前n个数得连续最大和，因为只有3种情况：

 还是前n-1中得连续最大和
 靠右连续得最大连续和加上第n个元素
 第n个元素自己最大
 所以只需要把开始状态看作是第一个数，那么最大连续和 与 最右最大连续和 都是它本身，也就可以求到后面得n个数

 公式：max_right = max(arr[i], max_right + arr[i]);
            max_all = max(max_all, max_right);

 ————————————————

 版权声明：本文为CSDN博主「丶蓝色」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。

 原文链接：https://blog.csdn.net/lanse_l/article/details/84981694
 */
int maxSum(int array[],int length);

/*
    数组中两数和为target的 数组下边位置
 */
//std::vector<int>getIndexInTarget(int a[10],int target);

void quickSort(int a[10],int length,int left,int right);

/*
 字符串Z字型输出
 */
std::string convertString(std::string s,int numsRow);





@end

//NS_ASSUME_NONNULL_END
