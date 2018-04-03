load('shuchu2.mat')

xx=[];
yy=[];
yyy=[];
[m,n]=size(shuchu2);
for i=1:n
    xx(i)=shuchu2(1,i)-200.2;
end
for i=1:n
    yy(i)=shuchu2(2,i);
end
yymax=max(yy);
for i=1:n
    yyy(i)=1000*yy(i)/yymax;
end
norImageIntensity=[xx;yyy];
ImageIntensity=[xx;yy];
csvwrite('norImageIntensity.csv',norImageIntensity');
csvwrite('ImageIntensity.csv',ImageIntensity');
plot(xx,yy)
xlabel('Time Delay(¦Ìs)');
ylabel('Image Intensity(a.u.)');
set(get(gca,'YLabel'),'Fontsize',18);
set(get(gca,'XLabel'),'Fontsize',18);
set(gca, 'FontSize', 18);
set(gcf, 'position', [0 0 1000 500]);
set(gca,'XTick',[-0.2:0.2:xx(n)]);
xlim([-0.2,xx(n)]);
grid off