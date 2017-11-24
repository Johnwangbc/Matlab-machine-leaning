datatrain = load('E:\graduate\name\����������\�½��ļ���\C5.txt');
datatest  = load('E:\graduate\name\����������\�½��ļ���\D5.txt');
m = size(datatrain, 1);
n = size(datatrain, 2);
X = datatrain;
y = [yi(28);zeros(28,1)];

%---�ͽ�---%
X = [ones(m, 1) X];
datatest = [ones(14,1) datatest];
y2 = [yi(7);zeros(7,1)];

%---�߽�---%
%X = mapFeature(X(:,1), X(:,2));

initial_theta = zeros(size(X, 2), 1);

% ���򻯲���������theta0�ͷ�����costfunction�����֡��������ϡ�
% lambdaֵԽ��thetaֵԽС��
lambda = 0.001;

[cost, grad] = costFunction(initial_theta, X, y, lambda);

fprintf('Cost at initial theta (zeros): %f\n', cost);

% GradObj-on ��ʾcostFunctionͬʱ����cost��grad
options = optimset('GradObj', 'on', 'MaxIter', 400);

% f = @(t)(...t...) ������һ�����������
% fΪ�������ƣ�tΪ�������������Ϊִ����䡣
f = @(t)(costFunction(t, X, y, lambda));
[theta, J, exit_flag] = fminunc(f, initial_theta, options);


% Compute accuracy on our training set
p = predict(theta, datatest);

fprintf('Train Accuracy: %f\n', mean(double(p == y2)) * 100);