%Rew=zeros(5);Rew(5,5)=100;    % rewards
task=struct('initialState',[1,1],'terminalState',[8,9]); % task   initialState  初始状态  terminalState 终止状态
robot=struct('alpha',1,'gamma',1,'Qtable',zeros(100,4),'best',[],'state',[1,1]);%alpha（学习效率） gamma(折扣因子) 学习参数  best 最优路径 state 状态 Qtable存储5*5每个状态Q值
robot=Qlearning(robot,task,Rew,50);

disp('前驱状态 | 动作 | 后继状态')
for l=1:size(robot.best,1)
    s0=robot.best(l,[1,2]);
    a=robot.best(l,3);
    s=robot.best(l,[4,5]);
    disp([num2str(s0),'  |  ',num2str(a),'  |  ',num2str(s)]);
end
size(robot.best,1)