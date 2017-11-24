clc
clear
%% ѵ������Ԥ������
datatrain=importdata('E:\graduate\name\����������\�½��ļ���\C5.txt');
datatest = importdata('E:\graduate\name\����������\�½��ļ���\D5.txt');
%��1��768���������
%k=rand(1,71);
%[m,n]=sort(k);
%�����������
%�����ȡ500������Ϊѵ��������268������ΪԤ������
input_train=datatrain';
output_train=[yi(28);fuyi(28)]';
input_test=datatest';
output_test=[yi(7);fuyi(7)]';
%�������ݹ�һ��
[inputn,inputps]=mapminmax(input_train);
%% BP����ѵ��
% %��ʼ������ṹ
net=newff(inputn,output_train,10);
net.trainParam.epochs=1000;
net.trainParam.lr=0.1;
net.trainParam.goal=0.0000004;
%% ����ѵ��
net=train(net,inputn,output_train);
%% BP����Ԥ��
%Ԥ�����ݹ�һ��
inputn_test=mapminmax('apply',input_test,inputps);
 
%����Ԥ�����
BPoutput=sim(net,inputn_test);
%% �������
%������������ҳ�������������
BPoutput(find(BPoutput<0.5))= -1;
BPoutput(find(BPoutput>=0.5))= 1;
%% �������
%����Ԥ�������ʵ������ķ���ͼ
% figure(1)
% plot(BPoutput,'og')
% hold on
% plot(output_test,'r*');
% legend('Ԥ�����','������')
% title('BP����Ԥ�������ʵ�����ȶ�','fontsize',12)
% ylabel('����ǩ','fontsize',12)
% xlabel('������Ŀ','fontsize',12)
% ylim([-0.5 1.5])

%Ԥ����ȷ��
rightnumber=0;
for i=1:size(output_test,2)
    if BPoutput(i)==output_test(i)
        rightnumber=rightnumber+1;
    end
end
rightratio=rightnumber/size(output_test,2)*100;
sprintf('����׼ȷ��=%0.2f',rightratio)