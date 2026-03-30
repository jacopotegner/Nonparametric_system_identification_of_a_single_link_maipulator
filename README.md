# Nonparametric_system_identification_of_a_single_link_maipulator

*QUESTION 1

According to the results you found, does the estimated model describe well the manipulator system? Motivate the answer.

*ANSWER

Yes, the model describes the manipulator system very well. With the default parameters ($\lambda = 10$, $\beta = 100$), it can be seen that the MAP estimated output closely resembles the validation data. Because the estimator performs so well on this validation dataset, it proves that the model generalizes properly the data.

*QUESTION 2

According to the results you found, which is the role of λ and β?

*ANSWER

Lowering $\lambda$ (e.g., to 0.1) greatly restricted the amplitude of the estimation, resulting in underfitting. The parameter $\lambda$ seems to acts as a control of the amplitude of the estimation. Lowering $\beta$ (e.g., to 1) reduced the correlation between data points, making the model much more sensitive to noise and creating a jittery estimation. $\beta$ seems to acts as a control of the smoothness of the curve.

*QUESTION 3

According to the results you found, does the feedforward action improve the control action? Motivate the answer.

*ANSWER

Yes, the feedforward action significantly improves the control action. Without it, the system has a noticeable delay. With the MAP-estimated feedforward activated we notice a vast improvement in the response that minimizes the tracking error. We also obtain a perfect fit in the asymptote.
