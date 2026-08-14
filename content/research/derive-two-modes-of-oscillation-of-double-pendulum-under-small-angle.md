---
title: "推导小角度下的双摆振动频率"
date: 2025-03-10
author: "P. JIA"
summary: "在质量相等、摆线相等的双摆模型中，推导两种振动频率"
tags: ["双摆", "拍"]
draft: false
---





对于质量相等、摆长相等且在小角度近似下的双摆系统，分析两球的运动方程，求解系统的特征频率（角频率）。

<center>
  <img src="fig1.avif" alt="Description of the image" style="width:30%; max-width:800px;">
</center>

假设两个小球质量均为 $m$，摆线长度均为 $l$，且满足小角度近似  $sin \theta \approx \theta$， $cos\theta =1-\frac{\theta^2}{2}$。

写出系统的动能 $T$：

$$
T = \frac{1}{2}ml^2\left( 2\dot{\theta_1}^2+\dot{\theta_2}^2 + 2\dot{\theta_1}\dot{\theta_2}  \right)
$$

系统势能 $V$:

$$
V=\frac{1}{2} mgl\left(2\theta_1^2 +\theta_2^2  \right) -3mgl
$$

写出拉格朗日方程：

$$
\frac{d}{dt}\left( \frac{\partial L}{\partial \dot{\theta_i}} \right) - \frac{\partial L}{\partial \theta_i} = 0
$$

角度 $\theta_i$ 有两个 $\theta_1$，$\theta_2$，有两个拉格朗日方程。

$$
2\ddot{\theta_1} + \ddot{\theta_2}+2\frac{g}{l}\theta_1=0
$$

$$
\ddot{\theta_1} + \ddot{\theta_2}+\frac{g}{l}\theta_2=0
$$

假设运动满足简谐振动： $\theta_1 = Acos(\omega t)$，$\theta_2 = Bcos(\omega t)$，代入可得：
$$
  2g/l-2\omega^2)A  -\omega^2 B=0
$$

$$
   -\omega^2 A + (g/l-\omega^2)B =0
$$

有解使得系数行列式为零，则有解为 $\omega =  \sqrt{\frac{g}{l}(2\pm\sqrt{2})}$。

得到两种振动的频率为 $\omega_1 =\sqrt{\frac{g}{l}(2+\sqrt{2})} $， $\omega_2=\sqrt{\frac{g}{l}(2-\sqrt{2})} $。

则小球的运动可以是这两种振动的线性叠加。

当两种振动频率接近时，会出现 拍 现象。

> 但是两个振动频率如何才会接近呢？
> 嗯！改变两摆球的质量！

当我们考虑摆球质量，则两种振动频率可以表示为：

$$
\omega^2 = \frac{g}{l} \left[ 1+\mu \pm \sqrt{(1+\mu)\mu}  \right]
$$

其中 $\mu = \frac{m_2}{m_1}$[1]。


假设 $g/l = 1$，频率 $\omega_1$, $\omega_2$ 和质量比 $\mu$ 的关系如下图所示


<center>
  <img src="fig2.png" alt="Description of the image" style="width:50%; max-width:800px;">
</center>



当 $\mu$ 非常接近 $0$，即上摆球质量 $m_1$ 远大于下摆球质量 $m_2$，两球振动频率接近，出现拍现象。

---
Reference: 
[1] https://math24.net/double-pendulum.htm

