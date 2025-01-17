/**
 * File: unbounded_knapsack.dart
 * Created Time: 2023-08-11
 * Author: liuyuxin (gvenusleo@gmail.com)
 */

import 'dart:math';

/* 完全背包：动态规划 */
int unboundedKnapsackDP(List<int> wgt, List<int> val, int cap) {
  int n = wgt.length;
  // 初始化 dp 表
  List<List<int>> dp = List.generate(n + 1, (index) => List.filled(cap + 1, 0));
  // 状态转移
  for (int i = 1; i <= n; i++) {
    for (int c = 1; c <= cap; c++) {
      if (wgt[i - 1] > c) {
        // 若超过背包容量，则不选物品 i
        dp[i][c] = dp[i - 1][c];
      } else {
        // 不选和选物品 i 这两种方案的较大值
        dp[i][c] = max(dp[i - 1][c], dp[i][c - wgt[i - 1]] + val[i - 1]);
      }
    }
  }
  return dp[n][cap];
}

/* 完全背包：状态压缩后的动态规划 */
int unboundedKnapsackDPComp(List<int> wgt, List<int> val, int cap) {
  int n = wgt.length;
  // 初始化 dp 表
  List<int> dp = List.filled(cap + 1, 0);
  // 状态转移
  for (int i = 1; i <= n; i++) {
    for (int c = 1; c <= cap; c++) {
      if (wgt[i - 1] > c) {
        // 若超过背包容量，则不选物品 i
        dp[c] = dp[c];
      } else {
        // 不选和选物品 i 这两种方案的较大值
        dp[c] = max(dp[c], dp[c - wgt[i - 1]] + val[i - 1]);
      }
    }
  }
  return dp[cap];
}

/* Driver Code */
void main() {
  List<int> wgt = [1, 2, 3];
  List<int> val = [5, 11, 15];
  int cap = 4;

  // 动态规划
  int res = unboundedKnapsackDP(wgt, val, cap);
  print("不超过背包容量的最大物品价值为 $res");

  // 状态压缩后的动态规划
  int resComp = unboundedKnapsackDPComp(wgt, val, cap);
  print("不超过背包容量的最大物品价值为 $resComp");
}
