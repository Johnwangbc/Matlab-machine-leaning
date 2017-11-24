clear all;
clc;

datatemp1 = load('E:\graduate\name\总特征.txt');


%k-means聚类
[u re]=KMeans(datatemp1,2);  %最后产生带标号的数据，标号在所有数据的最后，意思就是数据再加一维度
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
