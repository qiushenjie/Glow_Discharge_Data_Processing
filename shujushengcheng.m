clear all
ff=dir('*.asc');                                    %�����ļ�����С��������ļ���
ceshi={};
l=length(ff);                                        %�ļ�����
for i=1:l
ceshi{i,2}=ff(i).name;                               %�ļ�������׺д��ceshi{i,2}
for ll=1:length(ff(i).name)                            %����name��ÿ��Ԫ�ص��ַ�
         if ff(i).name(ll)=='.'                       %�ж��ǲ��ǵ�
             dwz=ll;                                  %�õ����һ���㡱.����λ��  
         else
         end
end
ceshi{i,1}=str2num(ff(i).name(1:dwz-1));             %�ļ�����������׺д��ceshi{i,1}

end                            
mingcheng=sortrows(ceshi,1);                    %����
shuchu1=[];
shuchu2=[];
jieguotu={};                              %���ٳ��������ݴ���jieguotu��cell��
jieguotu1={};
qq=1;                                    %jieguotu�ĳ�ʼλ��
for i=1:l
M=dlmread(mingcheng{i,2},'\t','LF160..NY750');% 'A1..B7'�Ƕ�ȡ��Χ����excel��ʽһ���������ݶ�ȡ����֮��������͡�
jieguotu1{i}=M;% 'A1..B7'�Ƕ�ȡ��Χ����excel��ʽһ���������ݶ�ȡ����֮��������͡�
M=medfilt2(M);   %��ֵ�˲���ȥ����
wenjianming(i)=mingcheng{i,1};   
mhang=sum(M)';                  %�Զ�ȡ�����ݽ�������Ͳ���ֵ��һ����������ת�ó�������(excel��һ�м��������ֵ)
mhangmin=min(mhang);             %���mhang����Сֵ
mhang1=mhang-mhangmin;           %excel�ڶ��м��������ֵ
mhang1max=max(mhang1);           %excel��������ĵڶ��е����ֵ
jieguo1=mhang1/mhang1max;        %excel��������ĵ�����,��һ��
jieguo2=mhang1max;               %����ÿһ�е����ֵ��������Ϊͼ��ǿ��  
shuchu1=[shuchu1,jieguo1];
shuchu2=[shuchu2,jieguo2];
jieguotu=[jieguotu,M];
end
%figure
mesh(fliplr(shuchu1')),view(2)
axis ij;  %����ԭ�������Ͻǣ�Ĭ�ϣ���axis xy����ԭ�������½�  
%figure
contourf(fliplr(shuchu1')),view(2)
   %����x�ᡮ��ʾλ�á���С����  y�ᡮ��ʾʱ�䡯�Ӵ�С
shuchu3=[wenjianming;shuchu1];
shuchu2=[wenjianming;shuchu2];
%�����д�� shuchu1.xls ��shuchu2.xls
   dlmwrite('shuchu.txt',shuchu3,'\t');   %�ѽ��д�� shuchu1.xls �ļ���
   dlmwrite('shuchu2.txt',shuchu2,'\t');  
%�����һ������shuchu1.mat��ʱ��仯ǿ�ȶ�ά����shuchu2.mat
save shuchu1 shuchu1;
save shuchu2 shuchu2;

%δ��һ����̬ͼ
for i=1:length(jieguotu1)                       %����̬ͼ���ȶ�̬ͼ����Ϳ������أ�
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
imwrite(imind,cm,'δ��һ��.gif','gif', 'Loopcount',inf,'DelayTime',1e-4);%��һ�α��봴����
else
imwrite(imind,cm,'δ��һ��.gif','gif','WriteMode','append','DelayTime',1e-4);
end
end
%��һ����̬ͼ
for i=1:length(jieguotu)                       %����̬ͼ���ȶ�̬ͼ����Ϳ������أ�
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
imwrite(imind,cm,'��һ��.gif','gif', 'Loopcount',inf,'DelayTime',1e-4);%��һ�α��봴����
else
imwrite(imind,cm,'��һ��.gif','gif','WriteMode','append','DelayTime',1e-4);
end
end