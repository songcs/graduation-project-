function robot=Qlearning(robot,task,Rew,N)
% Q learning ArithmaticQ学习算法
[m,n]=size(Rew);           % load the task and the robot装载任务和机器人
gam=robot.gamma;%提取折扣因子
alp=robot.alpha;%提取学习系数
as=1:4; %方向选择值
LearnN=0;
si=task.initialState;ki=sub2ind([m,n],si(1),si(2));%提取开始位置在数组中的索引值
st=task.terminalState;kt=sub2ind([m,n],st(1),st(2));%提取终点位置在数组中的索引值
sstemp =[];
for lp=1:N
    alp=alp*exp((1-rem(lp,10))/N);%贪婪策略   rem(x,y):x除以y的余数
    Q=robot.Qtable;        % load the new table载入新的表
    robot.state=si;        % return to the initial state 回到初始状态
    s0=si;k0=ki;
    step=0;
    slist=[];
    %check_loop=zeros(10,10);
    %check_loop(s0(1),s0(2))=1;
    while k0~=kt %在这一次迭代中，要从初始状态找到终点
        qs=Q(k0,:);
        q=min(qs);%q是找出k0状态，最小的q值
        qmax=max(qs);
        i=1;
        for i=1:4
            if qs(i)==qmax
                break;
            end
        end
        a=i;
        s=exact(s0,a); %s就是转移后的状态
        if any(s<1)||any(s>m)||any(s>n)    % 防止超越环境
            Q(k0,a)=Q(k0,a)-100; break; %给这个转移策略弄成负值
        %elseif check_loop(s(1),s(2))==1
         %   Q(k0,a)=Q(k0,a)-100; break; %给这个转移策略弄成负值
        else               % feasible
            k=sub2ind([m,n],s(1),s(2)); %提取数组中的索引值                      
            v=max(Q(k,:));                 % 找出k状态中q值最大的一个
            D=Rew(k)+gam*v-Q(k0,a)-.2;
            Q(k0,a)=Q(k0,a)+alp*D; %更新k0状态下a方向的q值
        end       
        slist=[slist;s0,a,s];%slist就存储着：状态由s0通过a方向转移到s
        s0=s;k0=k;step=step+1;
        %check_loop(s0(1),s0(2))=1;
      disp([num2str(s0),' | ',num2str(a),' | ',num2str(s),' LearnN ',num2str(LearnN),' step ',num2str(step)])  % 打印状态转移
    end
    LearnN=LearnN+1;  
    sstemp=[sstemp,step];
    robot.state=s;         % update the robot更新机器人
    robot.Qtable=Q;
    if k0==kt
        if isempty(robot.best), % record记录
            robot.best=slist;
        elseif step<size(robot.best,1),
            robot.best=slist;
        end  
    end     
end
plot([1:LearnN],sstemp)
function s=exact(s,a)
switch(a)
    case 1   % dowm
        s=s+[1,0];
    case 2   % right
        s=s+[0,1];
    case 3   % up
        s=s+[-1,0];
    case 4   % left
        s=s+[0,-1];
    otherwise
end
