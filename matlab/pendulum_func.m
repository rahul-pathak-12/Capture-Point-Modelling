
function X = pendulum_func( series, time, height, vel)
    % control effort: ankle torque applied to the pendulum, definition of + sign, right handed rule
    len = size(series);
    
    m = 320;
    g = 9.81;
    L = 1;
    %L=1.0;
    rc=1*L; % pivot to COM vector length
    Ic=1/3*m*rc*rc; % approximation of inertia tensor
    I=Ic+0.5*m*rc^2;
    B = height;
    Ac = [0 , 1;
        m*g*rc/I, -B/I];  % B is damping coefficient at ankle (viscousity of the mechanism), parallel to pure torque input

    Bc =[0;1/I];

    Cc=zeros(1,2);
    Dc=[-1/(m*g)];

    % Ac, Bc, Cc, Dc, where subscript c stands for continous time system
    T=0.005;
    sys=ss(Ac,Bc,Cc,Dc);

    % quiz 1: discretize the continous time state space equations
    sysd = c2d(sys,T);

    Ad = sysd.A;
    Bd = sysd.B;
    Cd = sysd.C;
    Dd = sysd.D;
    % now you will have Ad, Bd, Cd, Dd

    % quiz 2: pls complete the At Bt Ct Dt matrcies for the tracking control
    At = [Ad zeros(2,1); Cd 1];
    Bt = [Bd;Dd];
    Ct = [Cd 0];
    Dt = [Dd];

    %%
    pos = height;
    vel = vel;

    % trials: you can change the weight err and see how it affects the tracking
    err = 1;
    Q=diag([pos vel err]); % same number as state variables

    % trials: you can change the weight R for control effort and see how it affects the tracking
    R =  1e+1;               % same number as control input
    [K, P, E] = dlqr(At,Bt,Q,R); % see the gain matrix K

    %%
    simTime = len(1); 
    time=0:T:simTime-T;
    N=floor(simTime/T);

    % initialize matrices for storing data
    X=zeros(3,N);
    % X(1,1) = 1e-3;
    X(1,1) = 1;
    joint=zeros(3,N);
    COM=zeros(3,N);
    Y=zeros(1,N);

    ecopx = 0; % error of center of pressure
    e_sum = 0;  % integral of errors (sum of errors)

    % Square or SIN wave
    %ref = 0.1*sin(2*pi*time);
    ref = 0.1*square(0.5*pi*time);

    for i=1:N
        joint(:,i) = [ L*sin(X(1,i)); 0; L*cos(X(1,i)) ];   % for visualization
        COM(:,i) = [ rc*sin(X(1,i)); 0; rc*cos(X(1,i)) ];    
        X(3,i) = e_sum; % feedback of the sum of errors
        u(i)=-K*X(:,i);
        X(:,i+1)=At*X(:,i)+Bt*u(i);
        Y(:,i)=Ct*X(:,i)+Dt*u(i);      
        error = (deg2rad(90)-joint(1,i));
        e_sum= e_sum +error; %e_sum+ecopx; 
    end
    X(:,end) = []; % remove the last index since X has i+1 term in the loop, we need to remove extra +1 index.

end
