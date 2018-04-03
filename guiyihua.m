load('shuchu1.mat');
load('shuchu2.mat')
xx=[];
yy=[];
[m,n]=size(shuchu1);
for i=1:m
    xx(i)=i;
end
for i=1:n
   yy(i)=shuchu2(1,i)-200.2;
end
figure1=figure;
surf(xx,yy,fliplr(shuchu1')),view(2)
xlabel('Distance(mm)');
ylabel('Time Delay(��s)');
set(get(gca,'YLabel'),'Fontsize',18);
set(get(gca,'XLabel'),'Fontsize',18);
set(gca, 'FontSize', 18);
set(gcf, 'position', [0 0 700 600]);
set(gca,'XTick',[xx(1):(xx(m)-xx(1))/5:xx(m)], 'YTick',[yy(35):0.5:yy(n)]);   %����y��̶ȷ�Χ
% set(gca,'yticklabel',sprintf('%03.1f|',get(gca,'ytick')));     %����y��̶ȱ���С����λ��
set(gca,'xticklabel',{'0.0' '0.5' '1.0' '1.5' '2.0' '2.5' })   %����x��̶ȷ�Χ
colorbar('Fontsize',18);
xlim([1,m]);      %����x�᷶Χ [A,B]A:X����Сֵ��B:X�����ֵ
ylim([-0.2,2.8]);  %����y�᷶Χ,[A,B]A:Y����Сֵ��B:Y�����ֵ
grid off
colormap('jet')
shading interp