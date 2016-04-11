function robot=Qlearning(robot,task,Rew,N)
% Q learning ArithmaticQѧϰ�㷨
[m,n]=size(Rew);           % load the task and the robotװ������ͻ�����
gam=robot.gamma;%��ȡ�ۿ�����
alp=robot.alpha;%��ȡѧϰϵ��
as=1:4; %����ѡ��ֵ
LearnN=0;
si=task.initialState;ki=sub2ind([m,n],si(1),si(2));%��ȡ��ʼλ���������е�����ֵ
st=task.terminalState;kt=sub2ind([m,n],st(1),st(2));%��ȡ�յ�λ���������е�����ֵ
sstemp =[];
suc_lp=0;
for lp=1:N
    alp=alp*exp((1-rem(lp,10))/N);%̰������   rem(x,y):x����y������
    Q=robot.Qtable;        % load the new table�����µı�
    robot.state=si;        % return to the initial state �ص���ʼ״̬
    s0=si;k0=ki;
    step=0;
    slist=[];
    %check_loop=zeros(10,10);
    %check_loop(s0(1),s0(2))=1;
    while k0~=kt %����һ�ε����У�Ҫ�ӳ�ʼ״̬�ҵ��յ�
        qs=Q(k0,:);
        q=min(qs);%q���ҳ�k0״̬����С��qֵ
        qmax=max(qs);
        i=1;
        for i=1:4
            if qs(i)==qmax
                break;
            end
        end
        a=i;
        s=exact(s0,a); %s����ת�ƺ��״̬
        if any(s<1)||any(s>m)||any(s>n)    % ��ֹ��Խ����
            Q(k0,a)=Q(k0,a)-100; break; %�����ת�Ʋ���Ū�ɸ�ֵ
        %elseif check_loop(s(1),s(2))==1
         %   Q(k0,a)=Q(k0,a)-100; break; %�����ת�Ʋ���Ū�ɸ�ֵ
        else               % feasible
            k=sub2ind([m,n],s(1),s(2)); %��ȡ�����е�����ֵ                      
            v=max(Q(k,:));                 % �ҳ�k״̬��qֵ����һ��
            D=Rew(k)+gam*v-Q(k0,a)-.2;
            Q(k0,a)=Q(k0,a)+alp*D; %����k0״̬��a�����qֵ
        end       
        slist=[slist;s0,a,s];%slist�ʹ洢�ţ�״̬��s0ͨ��a����ת�Ƶ�s
        s0=s;k0=k;step=step+1;
        %check_loop(s0(1),s0(2))=1;
      disp([num2str(s0),' | ',num2str(a),' | ',num2str(s),' LearnN ',num2str(LearnN),' step ',num2str(step)])  % ��ӡ״̬ת��
    end
    LearnN=LearnN+1;  
    
    robot.state=s;         % update the robot���»�����
    robot.Qtable=Q;
    if k0==kt
        sstemp=[sstemp,step];
        suc_lp=suc_lp+1;
        if isempty(robot.best), % record��¼
            robot.best=slist;
        elseif step<size(robot.best,1),
            robot.best=slist;
        end  
    end     
end
plot([1:suc_lp],sstemp)
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
