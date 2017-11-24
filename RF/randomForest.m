clc;
clear all;
datatemp1 = load('E:\graduate\name\总特征分类\新建文件夹\C5.txt');
datatemp2 = load('E:\graduate\name\总特征分类\新建文件夹\D5.txt');
TRAIN_DATA = datatemp1;
TRAIN_LABEL = [yi(28);fuyi(28)];
TEST_DATA = datatemp2;
TEST_LABEL = [yi(7);fuyi(7)];

%% 数据预处理
% 数据预处理,将训练集和测试集归一化到[-1,1]区间
[mtrain,ntrain] = size(TRAIN_DATA);
[mtest,ntest] = size(TEST_DATA);
dataset = [TRAIN_DATA;TEST_DATA];
%mapminmax为MATLAB自带的归一化函数
[dataset_scale,ps] = mapminmax(dataset',-1,1);
dataset_scale = dataset_scale';
train = dataset_scale(1:mtrain,:);
test = dataset_scale((mtrain+1):(mtrain+mtest),:);
%% 测试样本测试   
num=0;
num1=0;
tic;
% datatemp1 = [datatemp1;datatemp2];
% train = datatemp1(:,2:28);
% TRAIN_LABEL = datatemp1(:,1);
%   [dataset_scale,ps] = mapminmax(train',-1,1);
%   train = dataset_scale';
model = classRF_train(train,TRAIN_LABEL,1000);
 %a = 1- mean(model.errtr(:,1));
    Y_hat1 = classRF_predict(test,model);
    fprintf('acc1: %f\n',length(find(Y_hat1==TEST_LABEL))/length(TEST_LABEL))
%     for i=1:81
%         if(Y_hat1(i)==1)
%             num=num+1;
%         end
%     end
%     
%      for j=82:162
%         if(Y_hat1(j)==-1)
%             num1=num1+1;
%         end
%     end
% %% 训练样本测试
% model = classRF_train(train,TRAIN_LABEL);
%     Y_hat = classRF_predict(train,model);
%     fprintf('acc: %f\n',length(find(Y_hat==TRAIN_LABEL))/length(TRAIN_LABEL));
%      fprintf('t: %f\n', RF_test_time);

%% mtry 大小不同，则分类准确率分布图
% acc=[];
% t=[];
% for i=1:45
%     tic
%     model = classRF_train(train,TRAIN_LABEL,500,i);
%     t(i)=toc;
%     Y_hat = classRF_predict(test,model);
%     acc(i)=length(find(Y_hat==TEST_LABEL))/length(TEST_LABEL);
% end
 



% % example 1:  simply use with the defaults
%     model = classRF_train(train,TRAIN_LABEL);
%     Y_hat = classRF_predict(test,model);
%     fprintf('\nexample 1: error rate %f\n',   length(find(Y_hat~=TEST_LABEL))/length(TEST_LABEL));
% % 
%  % example 2:  set to 100 trees
%     model = classRF_train(train,TRAIN_LABEL,31,4);
%     Y_hat = classRF_predict(test,model);
%     fprintf('\nexample 2: error rate %f\n',   length(find(Y_hat~=TEST_LABEL))/length(TEST_LABEL));
   


% example 3:  set to 9 trees, mtry = 8
% double accary;
% double accary1;
% double p;
% double q;
% model = classRF_train(train,TRAIN_LABEL);
%     Y_hat = classRF_predict(test,model);
%     accary1=length(find(Y_hat==TEST_LABEL))/length(TEST_LABEL);
% for i=0:180
%     for j=0:60
% model = classRF_train(train,TRAIN_LABEL, i,j);
%     Y_hat = classRF_predict(test,model);
%     accary=length(find(Y_hat==TEST_LABEL))/length(TEST_LABEL);
%     if accary>accary1
%         accary1=accary
%         p=i
%         q=j
%     end
%     end
% end
%     fprintf('\nexample 3: acc rate %f %d %d\n',   accary1,p,q);
%    


%     % example 4:  set to defaults trees and mtry by specifying values as 0
%     model = classRF_train(train,TRAIN_LABEL, 0,0);
%     Y_hat = classRF_predict(test,model);
%     fprintf('\nexample 4: error rate %f\n',   length(find(Y_hat~=TEST_LABEL))/length(TEST_LABEL));
  
    % example 5: set sampling without replacement (default is with replacement)
%     extra_options.replace = 1 ;
%     model = classRF_train(train,TRAIN_LABEL, 24, 14, extra_options);
%     Y_hat = classRF_predict(test,model);
%     fprintf('\nexample 5: error rate %f\n',   length(find(Y_hat~=TEST_LABEL))/length(TEST_LABEL));
%     
    % example 6: Using classwt (priors of classes)
%     clear extra_options;
%     extra_options.classwt = [1 1]; %for the [-1 +1] classses in twonorm
%     % if you sort the labels in training and arrange in ascending order then
%     % for twonorm you have -1 and +1 classes, with here assigning 1 to
%     % both classes
%     % As you have specified the classwt above, what happens that the priors are considered
%     % also is considered the freq of the labels in the data. If you are
%     % confused look into src/rfutils.cpp in normClassWt() function
% 
%     model = classRF_train(train,TRAIN_LABEL, 9, 8, extra_options);
%     Y_hat = classRF_predict(test,model);
%     fprintf('\nexample 6: error rate %f\n',   length(find(Y_hat~=TEST_LABEL))/length(TEST_LABEL));
   
%     % example 7: modify to make class(es) more IMPORTANT than the others
%     %  extra_options.cutoff (Classification only) = A vector of length equal to
%     %                       number of classes. The 'winning' class for an observation is the one with the maximum ratio of proportion
%     %                       of votes to cutoff. Default is 1/k where k is the number of classes (i.e., majority
%     %                       vote wins).    clear extra_options;
%     extra_options.cutoff = [1/4 3/4]; %for the [-1 +1] classses in twonorm
%     % if you sort the labels in training and arrange in ascending order then
%     % for twonorm you have -1 and +1 classes, with here assigning 1/4 and
%     % 3/4 respectively
%     % thus the second class needs a lot less votes to win compared to the first class
%     
%     model = classRF_train(train,TRAIN_LABEL, 24, 14, extra_options);
%     Y_hat = classRF_predict(test,model);
%     fprintf('\nexample 7: error rate %f\n',   length(find(Y_hat~=TEST_LABEL))/length(TEST_LABEL));
%    fprintf('   TRAIN_LABEL is almost 50/50 but y_hat now has %f/%f split\n',length(find(Y_hat~=TEST_LABEL))/length(TEST_LABEL),length(find(Y_hat~=1))/length(TEST_LABEL));
%    
%    % example 8: sampsize example
%     %  extra_options.sampsize =  Size(s) of sample to draw. For classification, 
%     %                   if sampsize is a vector of the length the number of strata, then sampling is stratified by strata, 
%     %                   and the elements of sampsize indicate the numbers to be drawn from the strata.
%     clear extra_options
%     extra_options.sampsize = size(train,1)*2/3;
%     
%     model = classRF_train(train,TRAIN_LABEL, 100, 4, extra_options);
%     Y_hat = classRF_predict(test,model);
%     fprintf('\nexample 8: error rate %f\n',   length(find(Y_hat~=TEST_LABEL))/length(TEST_LABEL));
%     
%     
%     % example 9: nodesize
%     %  extra_options.nodesize = Minimum size of terminal nodes. Setting this number larger causes smaller trees
%     %                   to be grown (and thus take less time). Note that the default values are different
%     %                   for classification (1) and regression (5).
%     clear extra_options
%     extra_options.nodesize = 2;
%     
%     model = classRF_train(train,TRAIN_LABEL, 100, 4, extra_options);
%     Y_hat = classRF_predict(test,model);
%     fprintf('\nexample 9: error rate %f\n',   length(find(Y_hat~=TEST_LABEL))/length(TEST_LABEL));
%         
% 
% example 10: calculating importance
%     clear extra_options
%     extra_options.importance =1; %(0 = (Default) Don't, 1=calculate)
%    
%     model = classRF_train(train,TRAIN_LABEL, 31, 6, extra_options);
%     Y_hat = classRF_predict(test,model);
%     fprintf('\nexample 10: acc rate %f\n',   length(find(Y_hat==TEST_LABEL))/length(TEST_LABEL));
%     
%     %model will have 3 variables for importance importanceSD and localImp
%     %importance = a matrix with nclass + 2 (for classification) or two (for regression) columns.
%     %           For classification, the first nclass columns are the class-specific measures
%     %           computed as mean decrease in accuracy. The nclass + 1st column is the
%     %           mean decrease in accuracy over all classes. The last column is the mean decrease
%     %           in Gini index. For Regression, the first column is the mean decrease in
%     %           accuracy and the second the mean decrease in MSE. If importance=FALSE,
%     %           the last measure is still returned as a vector.
%     figure('Name','Importance Plots')
% %     subplot(2,1,1);
%     bar(model.importance(:,end-1));xlabel('特征个数','fontsize',14);ylabel('量级','fontsize',14);
% %     title('Mean decrease in Accuracy');
%     title('准确率下降');
%     
  
%     bar(model.importance(:,end));xlabel('特征个数','fontsize',14);ylabel('量级','fontsize',14);
%     title(' Gini指数下降');
% %     
%     
%     %importanceSD = The ?standard errors? of the permutation-based importance measure. For classification,
%     %           a D by nclass + 1 matrix corresponding to the first nclass + 1
%     %           columns of the importance matrix. For regression, a length p vector.
%     model.importanceSD
% 
% % example 11: calculating local importance
%     %  extra_options.localImp = Should casewise importance measure be computed? (Setting this to TRUE will
%     %                   override importance.)
%     %localImp  = a D by N matrix containing the casewise importance measures, the [i,j] element
%     %           of which is the importance of i-th variable on the j-th case. NULL if
%     %          localImp=FALSE.
%     clear extra_options
%     extra_options.localImp = 1; %(0 = (Default) Don't, 1=calculate)
%    
%     model = classRF_train(train,TRAIN_LABEL, 100, 4, extra_options);
%     Y_hat = classRF_predict(test,model);
%     fprintf('\nexample 11: error rate %f\n',   length(find(Y_hat~=TEST_LABEL))/length(TEST_LABEL));
% 
%     model.localImp
%     
% % example 12: calculating proximity
%     %  extra_options.proximity = Should proximity measure among the rows be calculated?
%     clear extra_options
%     extra_options.proximity = 1; %(0 = (Default) Don't, 1=calculate)
%    
%     model = classRF_train(train,TRAIN_LABEL, 179, 4, extra_options);
%     Y_hat = classRF_predict(test,model);
%     fprintf('\nexample 12: error rate %f\n',   length(find(Y_hat~=TEST_LABEL))/length(TEST_LABEL));
% 
%     model.proximity;
%     
% 
% example 13: use only OOB for proximity
    %  extra_options.oob_prox = Should proximity be calculated only on 'out-of-bag' data?
%     clear extra_options
%     extra_options.proximity = 1; %(0 = (Default) Don't, 1=calculate)
%     extra_options.oob_prox = 1; %(Default = 1 if proximity is enabled,  Don't 0)
%    
%     model = classRF_train(train,TRAIN_LABEL, 31, 4, extra_options);
%     Y_hat = classRF_predict(test,model);
%     fprintf('\nexample 13: acc rate %f\n',   length(find(Y_hat==TEST_LABEL))/length(TEST_LABEL));


% % example 14: to see what is going on behind the scenes    
% %  extra_options.do_trace = If set to TRUE, give a more verbose output as randomForest is run. If set to
% %                   some integer, then running output is printed for every
% %                   do_trace trees.
%     clear extra_options
%     extra_options.do_trace = 1; %(Default = 0)
%    
%     model = classRF_train(train,TRAIN_LABEL, 100, 4, extra_options);
%     Y_hat = classRF_predict(test,model);
%     fprintf('\nexample 14: error rate %f\n',   length(find(Y_hat~=TEST_LABEL))/length(TEST_LABEL));
% 
% % example 14: to see what is going on behind the scenes    
% %  extra_options.keep_inbag Should an n by ntree matrix be returned that keeps track of which samples are
% %                   'in-bag' in which trees (but not how many times, if sampling with replacement)
% %
%     clear extra_options
%     extra_options.keep_inbag = 1; %(Default = 0)
%    
%     model = classRF_train(train,TRAIN_LABEL, 100, 4, extra_options);
%     Y_hat = classRF_predict(test,model);
%     fprintf('\nexample 15: error rate %f\n',   length(find(Y_hat~=TEST_LABEL))/length(TEST_LABEL));
%     
%     model.inbag
% 
% example 16: getting the OOB rate. model will have errtr whose first
% column is the OOB rate. and the second column is for the 1-st class and
% so on
%  tic;
%     model = classRF_train(train,TRAIN_LABEL,500,4);
%     Y_hat = classRF_predict(test,model);
%     fprintf('\nexample 16: acc rate %f\n',   length(find(Y_hat==TEST_LABEL))/length(TEST_LABEL));
    
%     figure('Name','OOB误差');
%     plot(model.errtr(:,1)); title('OOB error rate');  xlabel('树的个数','fontsize',14); ylabel('OOB误差','fontsize',14);
%     g=mean(model.errtr(:,1));
% toc


% m1=[500];
% for i=1:500
%     model = classRF_train(train,TRAIN_LABEL,i,4);
%     Y_hat = classRF_predict(test,model);
%     m1(i)=mean(model.errtr(:,1));
% end



% example 17: getting prediction per tree, votes etc for test set
%     model = classRF_train(train,TRAIN_LABEL,9,8);
%     
%     test_options.predict_all = 1;
%     [Y_hat, votes, prediction_pre_tree] = classRF_predict(test,model,test_options);
%     fprintf('\nexample 17: error rate %f\n',   length(find(Y_hat~=TEST_LABEL))/length(TEST_LABEL));
    
