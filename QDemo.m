%Rew=zeros(5);Rew(5,5)=100;    % rewards
task=struct('initialState',[1,1],'terminalState',[21,23]); % task   initialState  ��ʼ״̬  terminalState ��ֹ״̬
robot=struct('alpha',0.3,'gamma',0.95,'Qtable',zeros(625,4),'best',[],'state',[1,1]);%alpha��ѧϰЧ�ʣ� gamma(�ۿ�����) ѧϰ����  best ����·�� state ״̬ Qtable�洢5*5ÿ��״̬Qֵ
robot=Qlearning(robot,task,Rew,1000);

disp('ǰ��״̬ | ���� | ���״̬')
for l=1:size(robot.best,1)
    s0=robot.best(l,[1,2]);
    a=robot.best(l,3);
    s=robot.best(l,[4,5]);
    disp([num2str(s0),'  |  ',num2str(a),'  |  ',num2str(s)]);
end
