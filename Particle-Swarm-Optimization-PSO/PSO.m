%% PSO Algorithm
%-------------------------------------------------------------------------------------
% Particle Swarm Optimization ---> The basic concept of the algorithm is to create a 
% swarm of particles which move in the space around them (the problem space) searching 
% for their goal, the place which best suits their needs given by a fitness function.

% In this algorithm we have a completely connected swarm, meaning that all the particles 
% share information, any particle knows what is the best position ever visited by any 
% particle in the swarm.

% http://web.ist.utl.pt/gdgp/VA/pso.htm

% This code is part of research work done by Jesus Pineda Castro, Jackson Meza and 
% Juan Dominguez. Universidad Tecnológica de Bolívar , Cartagena, Colombia.
%-------------------------------------------------------------------------------------
% parameter description:
% --------------------------
% PARTICULES_NUM       ---- The number of particles
% PARTICULES_POSITIONS ---- Particules positions
% PARTICULES_VELOCITY  ---- Particules velocities
% DIMENSION            ---- Dimension being consider
% COGNITIVE_COMP       ---- Cognitive parameter
% SOCIAL_COMP          ---- Social parameter
% XMIN                 ---- Min position of particules
% XMAX                 ---- Max position of particules
% VMAX                 ---- Max velocity of particules
% MAX_NUM_ITERATION    ---- The maximum number of iteration
% return : gbest -the best solution we have got
%% Set values
XMIN = [0 0]; XMAX = [5 3];
PARTICULES_NUM = 20; DIMENSION = 2;
VMAX= 10; VMAX=[VMAX,VMAX];
MAX_NUM_ITERATION = 3000;

% PSO parameters -- D. Bratton and J. Kennedy, "Defining a standard 
% for particle swarm optimization", IEEE SIS, 2007, pp. 120-127.
chi = 0.72984;
COGNITIVE_COMP = 2.05 * chi;
SOCIAL_COMP = 2.05 * chi;
% ====================== INITIALIZATION ===================================
% Function to minimize
functionObj = @(inputs) U(inputs); % Here put your function as [x1,x2,x3,...xn]
functionGraph = @(input1,input2) U(input1,input2); % This is for graph
[X,Y] = meshgrid(0:0.1:5,0:0.1:3); 
U1 = functionGraph(X,Y);
figure(1), surf(X,Y,U1)
% Positions between XMIN and XMAX
PARTICULES_POSITIONS = (XMAX-XMIN).*rand(PARTICULES_NUM,DIMENSION)+XMIN;
% Particules velocities ---> [-VMAX/3 VMAX/3] 
% check here: http://web.ist.utl.pt/gdgp/VA/pso.htm
PARTICULES_VELOCITY = (0.6667*VMAX(1))*rand(PARTICULES_NUM,DIMENSION)-0.3333*VMAX(1);
% Initialize particule's best position
gbest = PARTICULES_POSITIONS(1,:); % Initial best value (Global)
OPERATION = 'MINIMIZE'; % ¿What do you want? ¿MAXIMIZE or MINIMIZE?
[gbest,fvalues] = getbest(gbest,PARTICULES_POSITIONS,OPERATION,functionObj);
% initialize lBest
lBest = PARTICULES_POSITIONS;
% ====================== Particle Swarm Optimization ======================
for iter = 1 : MAX_NUM_ITERATION
    % Draw graph
    figure(1),contour(X,Y,U1,100),hold on,
    Graph(PARTICULES_POSITIONS), 
    pause(0.1), hold off
    for i = 1 : size(PARTICULES_POSITIONS,1)
        PREV_PARTICULES_POSITIONS = PARTICULES_POSITIONS;
        % Update the velocity that will be used to update the new position after
        % each iteration.
        PARTICULES_VELOCITY(i,:) = PARTICULES_VELOCITY(i,:) + COGNITIVE_COMP*rand*(lBest(i,:)...
            - PARTICULES_POSITIONS(i,:)) + SOCIAL_COMP*rand*(gbest-PARTICULES_POSITIONS(i,:));
        
        % Limit particule's velocities
        temp = abs(PARTICULES_VELOCITY(i,:))-VMAX>0;
        PARTICULES_VELOCITY(i,temp) = sign(PARTICULES_VELOCITY(i,temp)).*VMAX(temp);
        
        % Update particule's positions
        PARTICULES_POSITIONS(i,:) = PARTICULES_POSITIONS(i,:) + PARTICULES_VELOCITY(i,:);
        
        % Limit particule's positions
        temp = abs(PARTICULES_POSITIONS(i,:))-XMAX>0;
        PARTICULES_POSITIONS(i,temp) = sign(PARTICULES_POSITIONS(i,temp)).*XMAX(temp);
        temp = PARTICULES_POSITIONS(i,:) - XMIN<0;
        PARTICULES_POSITIONS(i,temp) = sign(PARTICULES_POSITIONS(i,temp)).*XMIN(temp);
        
        % Update lBest
        if (functionObj(PREV_PARTICULES_POSITIONS(i,:)) < functionObj(PARTICULES_POSITIONS(i,:)))
            lBest(i,:) = PREV_PARTICULES_POSITIONS(i,:);
        end
        
        % Update Z values
        Z(i,1) = functionObj(PARTICULES_POSITIONS(i,:));
    end
    % Update gbest
    [gbest,fvalues] = getbest(gbest,PARTICULES_POSITIONS,OPERATION,functionObj);
end
%%
