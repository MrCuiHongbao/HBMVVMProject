//
//  HBOrderTools.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/3/6.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "HBOrderTools.h"
#include<stack>
#include<queue>
#include<string>
#include <vector>
#include <math.h>
using namespace std;

@implementation HBOrderTools
/*
 * 构造二叉树
 * */
TreeNode *buildTree(int inorder[], int alength,int postorder[],int blength) {
    int  alength1 = sizeof(inorder)/sizeof(int);/*当将数组作为实参传递到另一个函数中时, 另一个函数的形参相当于一个指针变量, 因为将数组的名作为实参时, 就是将数字的首地址作为实参, 所以在test函数中输出的sizeof(arr)其实得到的是一个整型数组的长度(所占的字节数), 所以结果是8, 再用其除以int所占的字节数(4), 结果就是2 */
    int  blength1 = sizeof(postorder)/sizeof(int);
    printf("数组a的长度为: %d\n",alength1);
    printf("数组b的长度为: %d\n",blength1);
    return buildBinaryTreeProcess(inorder, alength, postorder, blength, blength-1, 0, alength-1);
}
/*
* 根据二叉树中序遍历和后序遍历的结果构造二叉树
* */
TreeNode *buildBinaryTreeProcess(int inorder[],int inorderlength,int postorder[], int postorderlength,int ppos, int is, int ie ) {
    int postorder_length = postorderlength;
    int inorder_length = inorderlength;
    
    if(ppos >= postorder_length || is > ie) return NULL;
    
    TreeNode *node = (TreeNode *)malloc(sizeof(TreeNode));
    
    node->data = postorder[ppos];
    
    int pii = 0;
    for(int i = 0; i < inorder_length; i++){
      if(inorder[i] == postorder[ppos]) pii = i;
    }
    node->leftChild = buildBinaryTreeProcess(inorder,inorderlength,postorder,postorderlength, ppos - 1 - ie + pii, is, pii - 1);
    node->rightChild = buildBinaryTreeProcess(inorder,inorderlength,postorder,postorderlength, ppos - 1 , pii + 1, ie);
    return node;
}
/*
    * 二叉树的前序遍历
    * */
- (NSMutableArray *)preOrder:(TreeNode *)root{
    std::stack<TreeNode *> s;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1.0];
    if (!root) {
        return nil;
    }
    s.push(root);
    while (!s.empty()) {
        TreeNode *currentRoot = s.top();
        s.pop();
        [array addObject:@(currentRoot->data)];
        if (currentRoot->rightChild) {
            s.push(currentRoot->rightChild);
        }
        if (currentRoot->leftChild) {
            s.push(currentRoot->leftChild);
        }
    }
    NSLog(@"二叉树前序遍历结果为：%@",array);
    return array;
}
 int *preSort(TreeNode *node) {
    if(node == NULL) {
        return NULL;
    }
    stack<TreeNode *> s;
    s.push(node);
    int *a = new int(9);
     int index=0;
    while(!s.empty()) {
       TreeNode *treeNode =  s.top();
       s.pop();
       a[index] = treeNode->data;
        index++;
    if(treeNode->rightChild){
        s.push(treeNode->rightChild);
    }
    if(treeNode->leftChild) {
        s.push(treeNode->leftChild);
    }
    }
    return a;
}

/*
    * 二叉树的中序遍历
    * */
- (NSMutableArray *)inOrder:(TreeNode *)root{
    std::stack<TreeNode *> s;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1.0];
    if (!root) {
        return nil;
    }
    TreeNode *currentRoot = root;
    while (currentRoot||!s.empty()) {
        while (currentRoot) {
            s.push(currentRoot);
            currentRoot = currentRoot->leftChild;
        }
        TreeNode *current = s.top();
        s.pop();
        [array addObject:@(current->data)];
        currentRoot = current->rightChild;
    }
    NSLog(@"二叉树中序遍历结果为：%@",array);
    return array;
}
int *inOrder(TreeNode *root){
    if(root == NULL) {
        return NULL;
    }
    stack<TreeNode *>s;
    TreeNode *currentNode = root;
    int *a = new int(9);
    int i=0;
    while(!s.empty()||currentNode!=NULL) {
            while(currentNode){
                s.push(currentNode);
                currentNode = currentNode->leftChild;
            }
        TreeNode *popNode = s.top();
        s.pop();
        a[i++] = popNode->data;
       currentNode = popNode->rightChild;
    }
    return a;
}
 /*
     * 二叉树的后续遍历
     * */

- (NSMutableArray *)postOrder:(TreeNode *)root{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1.0];
    if(root == NULL){
        return nil;
    }
    [array addObjectsFromArray:[self postOrder:root->leftChild]];
    [array addObjectsFromArray:[self postOrder:root->rightChild]];
    [array addObject:@(root->data)];
    NSLog(@"二叉树后序遍历结果为：%@",array);
    return array;
}
int *postOrder(TreeNode *root){
    if(root == NULL) {
        return NULL;
    }
    stack<TreeNode *>s;
    TreeNode *currentNode;//当前结点
    TreeNode *preNode = NULL;//前一次访问的结点
    s.push(root);
    int *a = new int(9);
    int i=0;
    while(!s.empty()) {
        currentNode = s.top();
    if((currentNode->leftChild==NULL&&currentNode->rightChild==NULL)||(preNode!=NULL&&(preNode==currentNode->leftChild||preNode==currentNode->rightChild)))
        {
                a[i++] = currentNode->data;//如果当前结点没有孩子结点或者孩子节点都已被访问过
                s.pop();
                preNode=currentNode;
        } else {
            if(currentNode->rightChild!=NULL)
                s.push(currentNode->rightChild);
            if(currentNode->leftChild!=NULL)
                s.push(currentNode->leftChild);
        }

    }
    
    return a;
}
/*
    * 二叉树的层次遍历算法设计levelOrder
    * */
- (NSMutableArray *)levelOrder:(TreeNode *)root {
    std::queue<TreeNode *> queue;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1.0];
    if (root == NULL) {
        return array;
    }
    queue.push(root);
    while (!queue.empty()) {
        int leveNumer = (int)queue.size();
        NSMutableArray *subArray = [NSMutableArray arrayWithCapacity:1.0];
        for (int i=0;i<leveNumer; i++) {
            if (queue.front()->leftChild) {
                queue.push(queue.front()->leftChild);
            }
            if (queue.front()->rightChild) {
                queue.push(queue.front()->rightChild);
            }
            [subArray addObject:@(queue.front()->data)];
            queue.pop();
        }
        [array addObject:subArray];
    }
    NSLog(@"二叉树层序遍历结果为：%@",array);
    return array;
}
//创建单链表
LinkTreeNode *createLinkTree(int b[],int length) {
    LinkTreeNode *node = NULL;
    if (node==NULL) {
        node  = (LinkTreeNode *)malloc(sizeof(LinkTreeNode));
    }
    LinkTreeNode *currentNode = node;
    for (int i=0; i<=length-1; i++) {
        printf("createLinkTree array:%d\n",b[i]);
        if (currentNode) {
            currentNode->data = b[i];
            currentNode->index = i;
            if (i == length-1) {
                currentNode->nextNode = NULL;
            } else {
                LinkTreeNode *next = (LinkTreeNode *)malloc(sizeof(LinkTreeNode));
                currentNode->nextNode = next;
                currentNode = currentNode->nextNode;
            }
        }
    }
//    LinkTreeNode *indexNode = node;
//    LinkTreeNode *indexNode1 = node;
//    while (indexNode) {
//        indexNode = node->nextNode;
//        if (indexNode->data == indexNode1->data) {
//            <#statements#>
//        }
//    }
    return node;
}
//删除节点
LinkTreeNode *deleteNote(LinkTreeNode *treeNode,int num) {
    LinkTreeNode *p1=treeNode;
    linkTreeNode *p2 = NULL;
    while (num !=p1->data&&p1->nextNode!=NULL) {
        p2=p1;p1=p1->nextNode;
    }
    if (num == p1->data) {
        if (p1 == treeNode) {//头结点情况咱不考虑
            treeNode = p1->nextNode;
            free(p1);
        } else {
            p2->nextNode= p1->nextNode;
        }
    } else {
        printf("no  number you search wan:%dt",num);
    }
    return treeNode;
}
//链表倒叙
LinkTreeNode *reverLinkTreeNode(LinkTreeNode *node) {
    if (node == NULL) {
        return NULL;
    }
    LinkTreeNode *newLinkTree = NULL;
    LinkTreeNode *p = node;
    LinkTreeNode *tempLinkTree = NULL;
    while (p!=NULL) {
        tempLinkTree = p->nextNode;
        p->nextNode = newLinkTree;
        newLinkTree = p;
        p = tempLinkTree;
    }
    return newLinkTree;
}

//LinkTreeNode *insertNode(LinkTreeNode *treeNode,int num) {
//    LinkTreeNode *p1 = treeNode;
//    
//    
//}
//判断单链表是否有环
bool hasCycle(LinkTreeNode *node) {
    if (node == NULL||node->nextNode == NULL ) {
        return false;
    }
    LinkTreeNode *slowNode = node;
    LinkTreeNode *fastNode = node;
    while (slowNode!=NULL&&fastNode!=NULL) {
        if (slowNode->nextNode == fastNode->nextNode->nextNode) {
            return true;
        }
    }
    return false;
}
//找到环入口的节点
LinkTreeNode *cycleEnterPlace(LinkTreeNode *node) {
    if (node == NULL||node->nextNode ==NULL) {
        return node;
    }
    LinkTreeNode *slowNode = node;
    LinkTreeNode *fastNode = node;
    while (slowNode!=NULL&&fastNode!=NULL) {
        if (slowNode->nextNode ==fastNode->nextNode->nextNode) {
            LinkTreeNode *p = node;
            LinkTreeNode *q = slowNode->nextNode;//快指针等于慢指针
            while (p!=q) {
                p = p->nextNode;
                q = q->nextNode;
            }
            if (q==p) {
                return p;
            }
        }
    }
    return NULL;
}
//动态查找
int maxSum(int array[],int length) {
    int maxright = array[0];
    int maxSum = array[0];
    for (int i=1; i<length-1; i++) {
        maxright= MAX(maxright,array[i]+maxright);
        maxSum = MAX(maxright,maxSum);
    }
    return maxSum;
}
//二分查找非递归
int binarySearch(int a[],int length,int target) {
    int low = 0;
    int high = length-1;
    int middle = low+(high-low)/2;
    while (low < high) {
        if (a[middle] == target) {
            return middle;
        }
        if (a[middle] < target) {
            low = middle;
        }
        if (a[middle] >target) {
            high = middle;
        }
    }
    return -1;
}
//递归
int binaryTSearch(int a[],int target,int low,int high) {
    int middle = low+(high-low)/2;
    if (a[middle] == target) {
        return middle;
    }
    if (a[middle] < target) {
        low = binaryTSearch(a, target, middle, high);
    }
    if (a[middle] >target) {
        high = binaryTSearch(a, target, low, middle);
    }
    return -1;
}

//std::vector<int>getIndexInTarget(std::vector<int>&nums,int target){
////    unordered_map
//    std::unordered_map<int, int> m;
//    for (int i=0; i<nums.size(); i++) {
//        if (m.find(target-nums[i])!=m.end()) {
//            return {m[target -nums[i]],i};
//        }
//        m[nums[i]] = i;
//    }
//    return {};
//}
void quickSort(int a[11],int length,int left,int right) {
    if (left>length||right>length) {
        return;
    }
    if (left>right) {
        return;
    }
    int i = left;
    int j = right;
    int k = a[left];
    while (i<j) {
        while (k<=a[j]&&j>i) {
            j--;
        }
        while (k>=a[i]&&i<j) {
            i++;
        }
        if (i<j) {
            int temp = a[i];
            a[i] = a[j];
            a[j] = temp;
        }
    }
    a[left] = a[i];//key 和一遍排序后i的位置值交换 ，这样，i的位置左边都是小于a[i]右边都是大于a[i]
    a[i] = k;
    quickSort(a, length, left, i-1);
    quickSort(a, length, i+1, right);
}
std::string convertString(std::string s,int numsRow) {
    if (numsRow ==1 ) {
        return s;
    }
    vector<string> rows(MIN(numsRow,int(s.size())));
    int curRow = 0;
    bool goingDown = false;
    for (char c:s) {
        rows[curRow] += c;
        if (curRow == 0||curRow == numsRow-1) {
            goingDown = !goingDown;
        }
        curRow += goingDown?1:-1;
    }
    string ret;
    for (string row : rows) {
        ret  += row;
    }
    return ret;
}

int valueIndex(unordered_map<int, char> aMap,char c) {
        //通过value找 key
        for(unordered_map<int,char>::iterator it = aMap.begin();it!=aMap.end();it++)
        {
            if(it->second == c) {
                return  it->first;
            }
        }
        return -1;
}
//int lengthOfLongestSubstring(string s) {
//   unordered_map<int, char> aMap;
//   int index(0);
//   int start(0);
//   int end(0);
//   int result(0);
//    int max_result(0);//abcabcbb
//    for(char c:s){
//        int aInd =  valueIndex(aMap,c);
//        if(aInd == -1) {
//            aMap[index] = c;
//            end++;
//            result = end-start;
//        } else {
//            start = aInd+1;
//
//            result = end-start;
//        }
//        max_result = max(max_result, result);
//        index++;
//    }
//    return max_result;
//}
int lengthOfLongestSubstring(string s) {
   unordered_map<int, int> aMap;
   int index(0);
   int start(0);
   int end(0);
   int result(0);
    int max_result(0);//abcabcbb
    for(char c:s){
        if (aMap.find(c)!=aMap.end()) {
            aMap.erase(aMap.find(c));
            start = aMap[c];
            aMap[c] = index;
            result = end-start;
        } else {
            aMap[c] = index;
            end++;
            result = end-start;
        }
        max_result = max(max_result,result);
        index++;
    }
    return max_result;
}
vector<int> twoSum(vector<int>& nums, int target) {
    unordered_map <int,int>map;
    for(int i=0;i< nums.size();i++) {
        if(map.find(target-nums[i])!=map.end()) {
            return {map[target-nums[i]],i};
        }
        else{
            map[nums[i]] = i;
        }
    }
    return {};
}
//char *start = (char *)malloc(sizeof(char));
//memcpy(start, ccc, strlen(ccc));
void revertString(char *ccc) {
    char *start = ccc;
    char *end = ccc+strlen(ccc)-1;
    while (start<end) {
        char temp = *start;
        *(start++) = *end;
        *(end--) = temp;
    }
}
void buildMaxHeap(int a[],int length) {
    for(int i =length/2-1;i>0;i--) {
        heapify(a,i,length-1);
    }
    for (int i=length-1; i>0; i--) {
        swap(&a[0], &a[i]);
        heapify(a, 0, i-1);
    }
}
void heapify(int a[],int start, int end) {
    int dad = start;
    int son = 2*dad+1;
    while (son<=end) {
        if (son + 1 <= end&&a[son] >= a[son+1]) {
            son++;
        }
        if (a[dad] < a[son]) {
            return;
        } else {
            swap(&a[dad],&a[son]);
          dad = son;
          son = dad * 2 + 1;
            heapify(a, start, end);
        }
    }
}
void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int myatoi(string str) {
    int i=0;
    int flag = 1;
    int resu=0;
    while(str[i]== ' ') i++;
    if(str[i] == '-'){
        flag = -1;
        i++;
    }
    for(;i<str.size()&&isdigit(str[i]);i++) {
           resu = resu*10+(str[i]-'0');
           if(resu >= INT_MAX&&flag ==1) return INT_MAX;
           if(resu >INT_MAX&&flag ==-1)  return INT_MIN;
    }
    return flag*resu;
}
int deleteRepeatUnit(int *a,int length){
    if (length == 0) {
        return  0;
    }
    int i=0;
    for (int j= i; j<length-1; j++) {
        if (a[i]!=a[j]) {
            i++;
            a[i] = a[j];
        }
    }
    return i+1;
}
int returnOnePick(int *a) {
    return 0;
}
int* twoSum1(int* nums, int numsSize, int target, int* returnSize){
    for(int i=0;i<numsSize-1;i++) {
        int tt = target - nums[i];
        for(int j=i+1;j<numsSize-1;j++) {
            if(tt == nums[j]) {
                printf("number---->%d------>%d\n",i,j);
               int a[] = {i,j};
               returnSize = a;
            }
        }
    }
    return returnSize;
}
int revertINT(int numbers) {
    int x = numbers;
    int b;
    int sum = 0;
    while (x) {
        b = x%10;
        sum = sum*10+b;
        x/=10;
    }
    
    return sum;
}
@end
