---
title: "为什么教科书里的简谐运动推导是错的"
date: 2026-07-08
journal: "The Physics Teacher"
authors: "R. A. Mors, abc"
year: 2019
doi: "10.1119/1.5092484"
summary: "大多数教材用力的分解推导单摆，但这个推导在大角度下会彻底失效。"
tags: ["力学", "简谐运动", "教学法"]
draft: false
---

## 论文在说什么

这篇文章指出，标准教材对单摆简谐运动的推导有一个根本性的问题：它在小角度近似 $\sin\theta \approx \theta$ 之前就已经做了不该做的假设。

标准推导的步骤大概是：

1. 写出切向力 $F = -mg\sin\theta$
2. 说"小角度时 $\sin\theta \approx \theta$"
3. 得到 $F \approx -mg\theta = -\frac{mg}{L}x$
4. 对比 $F = -kx$，得到 $\omega = \sqrt{g/L}$

问题在步骤 2。我们把 $\theta$ 当成弧度，但在步骤 3 里又把 $x$ 当成线位移。这两者之间差了一个 $L$，推导在这里偷偷地做了一次替换。

## 正确的推导

从能量角度出发更干净。势能：

$$U(\theta) = mgL(1 - \cos\theta)$$

小角度展开 $\cos\theta \approx 1 - \frac{\theta^2}{2}$：

$$U \approx \frac{1}{2}mgL\theta^2$$

对比 $U = \frac{1}{2}k x^2$，其中 $x = L\theta$：

$$\frac{1}{2}mgL\theta^2 = \frac{1}{2}k L^2\theta^2 \implies k = \frac{mg}{L}$$

因此 $\omega = \sqrt{k/m} = \sqrt{g/L}$，结果相同，但推导没有偷换概念。

## 我的想法

这种"结果对了，但推导有漏洞"的情况在 ALevel 教学里很常见。学生背下来正确答案，但对推导过程的理解是错的。

这篇论文提醒我：在教学里，过程比结果更重要。
