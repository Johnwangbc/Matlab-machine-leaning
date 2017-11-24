function gaSVMcgForClassdraw(cg,bestacc,bestc,bestg)
cstep = 0.8;
gstep = 0.8;
gmax = 8;
gmin = -8;
cmax = 7;
cmin = -8;
accstep = 4.5;
[X,Y] = meshgrid(cmin:cstep:cmax,gmin:gstep:gmax);
%% to draw the acc with different c & g
figure;
[C,h] = contour(X,Y,cg,70:accstep:100);
clabel(C,h,'Color','r');
xlabel('log2c','FontSize',12);
ylabel('log2g','FontSize',12);
firstline = 'SVC参数选择结果图(等高线图)[GridSearchMethod]'; 
secondline = ['Best c=',num2str(bestc),' g=',num2str(bestg), ...
    ' CVAccuracy=',num2str(bestacc),'%'];
title({
firstline;secondline
},'Fontsize',12);
grid on; 
 
figure;
meshc(X,Y,cg);
% mesh(X,Y,cg);
% surf(X,Y,cg);
axis([cmin,cmax,gmin,gmax,30,100]);
xlabel('log2c','FontSize',12);
ylabel('log2g','FontSize',12);
zlabel('Accuracy(%)','FontSize',12);
firstline = 'SVC参数选择结果图(3D视图)[GridSearchMethod]'; 
secondline = ['Best c=',num2str(bestc),' g=',num2str(bestg), ...
    ' CorrectAccuracy=',num2str(bestacc),' BestAccuracy=',num2str(max(cg(:))),'%'];
title({
firstline;secondline
},'Fontsize',12);