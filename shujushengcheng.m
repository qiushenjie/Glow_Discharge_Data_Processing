clear all
ff=dir('*.asc');                                    %按照文件名大小排序出来文件名
ceshi={};
l=length(ff);                                        %文件个数
for i=1:l
ceshi{i,2}=ff(i).name;                               %文件名及后缀写入ceshi{i,2}
for ll=1:length(ff(i).name)                            %遍历name列每个元素的字符
         if ff(i).name(ll)=='.'                       %判断是不是点
             dwz=ll;                                  %得到最后一个点”.“的位置  
         else
         end
end
ceshi{i,1}=str2num(ff(i).name(1:dwz-1));             %文件名不包括后缀写入ceshi{i,1}

end                            
mingcheng=sortrows(ceshi,1);                    %排序
shuchu1=[];
shuchu2=[];
jieguotu={};                              %将抠出来的数据存入jieguotu的cell里
jieguotu1={};
qq=1;                                    %jieguotu的初始位置
for i=1:l
M=dlmread(mingcheng{i,2},'\t','LF160..NY750');% 'A1..B7'是读取范围，和excel形式一样，将数据读取出来之后再行求和。
jieguotu1{i}=M;% 'A1..B7'是读取范围，和excel形式一样，将数据读取出来之后再行求和。
M=medfilt2(M);   %中值滤波，去噪声
wenjianming(i)=mingcheng{i,1};   
mhang=sum(M)';                  %对读取的数据进行列求和并赋值给一个行向量再转置成列向量(excel第一列计算出来的值)
mhangmin=min(mhang);             %求出mhang的最小值
mhang1=mhang-mhangmin;           %excel第二列计算出来的值
mhang1max=max(mhang1);           %excel计算出来的第二列的最大值
jieguo1=mhang1/mhang1max;        %excel计算出来的第三列,归一化
jieguo2=mhang1max;               %保存每一列的最大值，用来作为图像强度  
shuchu1=[shuchu1,jieguo1];
shuchu2=[shuchu2,jieguo2];
jieguotu=[jieguotu,M];
end
%figure
mesh(fliplr(shuchu1')),view(2)
axis ij;  %坐标原点在左上角（默认），axis xy则是原点在左下角  
%figure
contourf(fliplr(shuchu1')),view(2)
   %画出x轴‘表示位置’从小到大，  y轴‘表示时间’从大到小
shuchu3=[wenjianming;shuchu1];
shuchu2=[wenjianming;shuchu2];
%将结果写入 shuchu1.xls 和shuchu2.xls
   dlmwrite('shuchu.txt',shuchu3,'\t');   %把结果写入 shuchu1.xls 文件中
   dlmwrite('shuchu2.txt',shuchu2,'\t');  
%保存归一化矩阵shuchu1.mat与时间变化强度二维矩阵shuchu2.mat
save shuchu1 shuchu1;
save shuchu2 shuchu2;

%未归一化动态图
for i=1:length(jieguotu1)                       %画动态图，等动态图画完就可以下载；
mesh(jieguotu1{i});
view(2);
axis off;
colormap('jet');
set(gcf, 'position', [0 0 100 600]);
grid off;
pause(0.1);
frame=getframe(gcf);
imind=frame2im(frame);
[imind,cm] = rgb2ind(imind,256);
if i==1
imwrite(imind,cm,'未归一化.gif','gif', 'Loopcount',inf,'DelayTime',1e-4);%第一次必须创建！
else
imwrite(imind,cm,'未归一化.gif','gif','WriteMode','append','DelayTime',1e-4);
end
end
%归一化动态图
for i=1:length(jieguotu)                       %画动态图，等动态图画完就可以下载；
mesh(jieguotu{i});
view(2);
axis off;
colormap('jet');
set(gcf, 'position', [0 0 100 600]);
grid off;
pause(0.1);
frame=getframe(gcf);
imind=frame2im(frame);
[imind,cm] = rgb2ind(imind,256);
if i==1
imwrite(imind,cm,'归一化.gif','gif', 'Loopcount',inf,'DelayTime',1e-4);%第一次必须创建！
else
imwrite(imind,cm,'归一化.gif','gif','WriteMode','append','DelayTime',1e-4);
end
end