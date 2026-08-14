---
title: "Derive two modes of oscillation of double pendulum under small angle"
date: 2025-03-10
author: "P. JIA"
summary: "Derive two frequencies of oscillation of double pendulum under small angle"
tags: ["Beat", "Double pendulum"]
draft: false
---




For a double pendulum system with equal masses, equal string lengths, and under the small-angle approximation, analyze the equations of motion for the two bobs and solve for the characteristic frequencies (angular frequencies) of the system.

<center>
  <img src="/research/derive-two-modes-of-oscillation-of-double-pendulum-under-small-angle/fig1.avif" alt="Description of the image" style="width:30%; max-width:800px;">
</center>

Assume both bobs have same mass $m$ and the massless string length $l$. All pivots are assumed to be frictionless.

Under the small angle approximation,  $sin \theta \approx \theta$ and $cos\theta =1-\frac{\theta^2}{2}$.

The kinetic energy $T$ of the system can be rewriten as follows.

$$
T = \frac{1}{2}ml^2\left( 2\dot{\theta_1}^2+\dot{\theta_2}^2 + 2\dot{\theta_1}\dot{\theta_2}  \right)
$$

The potential energy $V$ of the system can be rewriten as follows.

$$
V=\frac{1}{2} mgl\left(2\theta_1^2 +\theta_2^2  \right) -3mgl
$$

Apply Lagrangian eqution.

$$
\frac{d}{dt}\left( \frac{\partial L}{\partial \dot{\theta_i}} \right) - \frac{\partial L}{\partial \theta_i} = 0
$$

Two Lagrangian equations for $\theta_1$ and $\theta_2$ are as follows.

$$
2\ddot{\theta_1} + \ddot{\theta_2}+2\frac{g}{l}\theta_1=0
$$

$$
\ddot{\theta_1} + \ddot{\theta_2}+\frac{g}{l}\theta_2=0
$$

Assume the solutions satisfy the Simple-Harmonic Motion with the form of  $\theta_1 = Acos(\omega t)$ and $\theta_2 = Bcos(\omega t)$, the following equations are as follows.
$$
  2g/l-2\omega^2)A  -\omega^2 B=0
$$

$$
   -\omega^2 A + (g/l-\omega^2)B =0
$$

There exists a solution such that the coefficient determinant is zero, giving the solution: $\omega =  \sqrt{\frac{g}{l}(2\pm\sqrt{2})}$。

Thus, two frequencies of modes of oscillation are $\omega_1 =\sqrt{\frac{g}{l}(2+\sqrt{2})} $ and $\omega_2=\sqrt{\frac{g}{l}(2-\sqrt{2})} $. The motion of the pendulum can be expressed as linear superposition of two oscillations.

When two frequncies are close to each other, a beating phenomenon occurs.

> But hwo can the two frequencies be close to each other?   
> Yes! Changing the mass of two bobs.

As we consider the mass of bobs, the frequencies can be obtained as 

$$
\omega^2 = \frac{g}{l} \left[ 1+\mu \pm \sqrt{(1+\mu)\mu}  \right]
$$

where $\mu = \frac{m_2}{m_1}$[1].

Provided that $g/l = 1$, dependencies of the frequencies $\omega_1$, $\omega_2$ are shown as follows.


<center>
  <img src="/research/derive-two-modes-of-oscillation-of-double-pendulum-under-small-angle/fig2.png" alt="Description of the image" style="width:50%; max-width:800px;">
</center>


As $\mu$ is close to $0$, namely mass of top bob $m_1$ is much greater than that of bottom bob $m_2$, the two frequencies are close, which a beating phenomenon occurs. 

---
Reference: 
[1] https://math24.net/double-pendulum.htm



