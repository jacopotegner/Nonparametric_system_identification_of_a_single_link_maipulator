# Nonparametric_system_identification_of_a_single_link_maipulator

*QUESTION 1

According to the results you found, does the estimated model describe well the manipulator system? Motivate the answer.

*ANSWER

Yes, the model describes the manipulator system very well. With the default parameters ($\lambda = 10$, $\beta = 100$), it can be seen that the MAP estimated output closely resembles the validation data. It accurately tracks both the amplitude and the dynamic frequency of the torque with minimal interference from the noise. Because the estimator performs so well on this validation dataset, it proves that the model generalizes properly the data without overfitting.

*QUESTION 2

According to the results you found, which is the role of λ and β?

*ANSWER

The parameter $\lambda$ acts as a scaling factor that controls the prior variance (the allowed amplitude) of the estimation. Lowering $\lambda$ (e.g., to 0.1) greatly restricted the amplitude of the estimation, creating a severely flattened model that fails to reach the true peaks, resulting in underfitting. On the other hand, $\beta$ acts as the length scale of the kernel, controlling the smoothness of the curve. Lowering $\beta$ (e.g., to 1) reduced the correlation between data points, making the model much more sensitive to noise and creating a jittery, overfitted estimation of the manipulator system.

*QUESTION 3

According to the results you found, does the feedforward action improve the control action? Motivate the answer.

*ANSWER

Yes, the feedforward action significantly improves the control action. Without it, the system relies solely on the proportional feedback controller, which is sluggish and has a noticeable delay. With the MAP-estimated feedforward activated, the system injects an anticipatory torque just as the step occurs. As a result, we notice a vast improvement in the transient response that minimizes the tracking error and rise time. We also obtain a perfect fit in the asymptote (steady-state), allowing the angular position to track the target reference more closely.
