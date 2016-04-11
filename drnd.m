function rv=drnd(x,p)
% discrete random variable 离散随机变量
% Input:
%      [x,p]: distribution分布、分配
% Output:
%      rv: 
%---------------------------------
% Principle: P(xi=x(i))=P(r:[Fi-1,Fi))(F0=0)
%                      =Pi;
% Attention: sum(p)=1
%---------------------------------
% Date: 15-Nov-2010
% Designer: William Song

l=size(x,2);%size(X,1),返回矩阵X的行数；size(X,2),返回矩阵X的列数；
   
if p==0
    p=ones(1,l)/l;    % uniform distribution 均匀分布
elseif sum(p)~=1
    p=p/sum(p);
end

F=cumsum(p);F0=[0,F(1:end-1)];
r=rand(1);
rv=x(:,(F0<=r)&(r<F));
