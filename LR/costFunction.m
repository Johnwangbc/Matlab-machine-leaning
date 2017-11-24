function [J, grad] = costFunction(theta, X, y, lambda)
    m = length(y);
    grad = zeros(size(theta));

    J = 1 / m * sum( -y .* log(sigmoid(X * theta)) - (1 - y) .* log(1 - sigmoid(X * theta)) ) + lambda / (2 * m) * sum( theta(2 : size(theta), :) .^ 2 );

    for j = 1 : size(theta)
        if j == 1
            grad(j) = 1 / m * sum( (sigmoid(X * theta) - y)' * X(:, j) );
        else
            grad(j) = 1 / m * sum( (sigmoid(X * theta) - y)' * X(:, j) ) + lambda / m * theta(j);
        end
    end

end