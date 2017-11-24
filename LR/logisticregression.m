datatrain = load('E:\graduate\name\总特征分类\新建文件夹\C5.txt');
datatest  = load('E:\graduate\name\总特征分类\新建文件夹\D5.txt');
m = size(datatrain, 1);
n = size(datatrain, 2);
X = datatrain;
y = [yi(28);zeros(28,1)];

%---低阶---%
X = [ones(m, 1) X];
datatest = [ones(14,1) datatest];
y2 = [yi(7);zeros(7,1)];

%---高阶---%
%X = mapFeature(X(:,1), X(:,2));

initial_theta = zeros(size(X, 2), 1);

% 正则化参数，不对theta0惩罚，在costfunction中体现。避免过拟合。
% lambda值越大，theta值越小。
lambda = 0.001;

[cost, grad] = costFunction(initial_theta, X, y, lambda);

fprintf('Cost at initial theta (zeros): %f\n', cost);

% GradObj-on 表示costFunction同时返回cost和grad
options = optimset('GradObj', 'on', 'MaxIter', 400);

% f = @(t)(...t...) 创建了一个函数句柄。
% f为函数名称，t为输入变量，后面为执行语句。
f = @(t)(costFunction(t, X, y, lambda));
[theta, J, exit_flag] = fminunc(f, initial_theta, options);


% Compute accuracy on our training set
p = predict(theta, datatest);

fprintf('Train Accuracy: %f\n', mean(double(p == y2)) * 100);