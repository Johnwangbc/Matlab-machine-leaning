function [bestc,bestg] = gaSVMcgForClassmyerror(train_label,train,test_label,test,cmin,cmax,gmin,gmax,v,cstep,gstep,accstep)
%SVMcg cross validation by faruto
%% about the parameters of SVMcg 
cstep = 0.8;
gstep = 0.8;
gmax = 8;
gmin = -8;
cmax = 8;
cmin = -8;
%% X:c Y:g cg:CVaccuracy
[X,Y] = meshgrid(cmin:cstep:cmax,gmin:gstep:gmax);
[m,n] = size(X);
num = zeros(m,n);
rightrate = zeros(m,n);
 
eps = 10^(-4);
 
%% record acc with different c & g,and find the bestacc with the smallest c
bestc = 1;
bestg = 0.1;
bestacc = 0;
basenum = 2;
for i = 1:m
    for j = 1:n
        cmd2 = ['-c ',num2str( basenum^X(i,j) ),' -g ',num2str( basenum^Y(i,j) )];
        model2 = svmtrain(train_label, train, cmd2);
        [pre,acc,dec] = svmpredict(train_label,train,model2);
        [pre2,acc2,dec2] = svmpredict(test_label,test,model2);
        for temp = 1:7
            if pre2(temp) ~= 1
                num(i,j)  = num(i,j)+1;
            end
        end
        for temp = 8:14
            if pre2(temp) ~= -1
                num(i,j)  = num(i,j)+10;
            end
        end 
         
        if acc2(1)-num(i,j) <= 55
            continue;
        end
         
        if acc2(1)-num(i,j)> bestacc
            bestacc = acc2(1)-num(i,j);
            bestc = basenum^X(i,j);
            bestg = basenum^Y(i,j);
        end        
         
        if abs( acc2(1)-num(i,j)-bestacc )<=eps && bestc > basenum^X(i,j) 
            bestacc = acc2(1)-num(i,j);
            bestc = basenum^X(i,j);
            bestg = basenum^Y(i,j);
        end        
         
    end
end