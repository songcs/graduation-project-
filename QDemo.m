%Rew=zeros(20);Rew(19,15)=100;    % rewards
task=struct('initialState',[1,1],'terminalState',[19,15]); % task   initialState  ��ʼ״̬  terminalState ��ֹ״̬
robot=struct('alpha',1,'gamma',1,'Qtable',zeros(400,4),'best',[],'state',[1,1]);%alpha��ѧϰЧ�ʣ� gamma(�ۿ�����) ѧϰ����  best ����·�� state ״̬ Qtable�洢20*20ÿ��״̬Qֵ
robot=Qlearning(robot,task,Rew,200);

disp('ǰ��״̬ | ���� | ���״̬')
for l=1:size(robot.best,1)
    s0=robot.best(l,[1,2]);
    a=robot.best(l,3);
    s=robot.best(l,[4,5]);
    disp([num2str(s0),'  |  ',num2str(a),'  |  ',num2str(s)]);
end