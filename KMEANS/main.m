clear all;
clc;

datatemp1 = load('E:\graduate\name\������.txt');


%k-means����
[u re]=KMeans(datatemp1,2);  %����������ŵ����ݣ�������������ݵ������˼���������ټ�һά��
[m n]=size(re);

num = 0;
label = re(:,80);
for i = 1:36
    if label(i) ~= 2
        num = num + 1;
    end
end

for i = 37:71
    if label(i) ~= 1
        num = num + 1;
    end
end

acc = (num/71)*100
