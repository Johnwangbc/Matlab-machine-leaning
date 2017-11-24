clc
clear
%% 训练数据预测数据
datatrain=importdata('E:\graduate\name\总特征分类\新建文件夹\C5.txt');
datatest = importdata('E:\graduate\name\总特征分类\新建文件夹\D5.txt');
%从1到768间随机排序
%k=rand(1,71);
%[m,n]=sort(k);
%输入输出数据
%随机提取500个样本为训练样本，268个样本为预测样本
input_train=datatrain';
output_train=[yi(28);fuyi(28)]';
input_test=datatest';
output_test=[yi(7);fuyi(7)]';
%输入数据归一化
[inputn,inputps]=mapminmax(input_train);
%% BP网络训练
% %初始化网络结构
net=newff(inputn,output_train,10);
net.trainParam.epochs=1000;
net.trainParam.lr=0.1;
net.trainParam.goal=0.0000004;
%% 网络训练
net=train(net,inputn,output_train);
%% BP网络预测
%预测数据归一化
inputn_test=mapminmax('apply',input_test,inputps);
 
%网络预测输出
BPoutput=sim(net,inputn_test);
%% 结果分析
%根据网络输出找出数据属于哪类
BPoutput(find(BPoutput<0.5))= -1;
BPoutput(find(BPoutput>=0.5))= 1;
%% 结果分析
%画出预测种类和实际种类的分类图
% figure(1)
% plot(BPoutput,'og')
% hold on
% plot(output_test,'r*');
% legend('预测类别','输出类别')
% title('BP网络预测分类与实际类别比对','fontsize',12)
% ylabel('类别标签','fontsize',12)
% xlabel('样本数目','fontsize',12)
% ylim([-0.5 1.5])

%预测正确率
rightnumber=0;
for i=1:size(output_test,2)
    if BPoutput(i)==output_test(i)
        rightnumber=rightnumber+1;
    end
end
rightratio=rightnumber/size(output_test,2)*100;
sprintf('测试准确率=%0.2f',rightratio)