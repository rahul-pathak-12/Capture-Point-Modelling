function lipm_acc_control()
% set initial states
X = [0.0052; % comX position
    0.1610]; % comX velocity 

% Dynamics params
g = 9.81; %Gravity - is magnitude of gravity, not direction 
z = 1; % CoMZ height

% Time params
total_time = 1515/1000; % 1.51 seconds at 1000 hz
Ts=total_time/1000;
t = 0:Ts:total_time; %sequence of timesteps
Tc = sqrt(z/g); %Time constant
[x_list,dx_list,u_track]= deal(zeros(1,length(t)));

% LIPM dynamics matrices 
C = cosh (Ts/Tc);
S = sinh (Ts/Tc);
A = [    C, Tc*S ; ...
      S/Tc,  C  ];
B = [0;
     1];
% lqr control
% K = lqr_control(A,B,[1,1],1e-3);
    
for i = 1:length(t)
% Control Method. Set u=0 if you don't want control
%         u = mpc_control_lipm(X,1,1,1e-5);
        u = 0;
        X = A * X + B * u;
        x_list(i) = X(1);
        dx_list(i) = X(2);
        u_track(i) = u;
end

ddx_list = diff(dx_list)/Ts;
x_list(1) = []; % stuff to plot, COM movement. which is what we want. 
dx_list(1) = [];
animate_lipm(x_list,dx_list,ddx_list,z,t,Ts);

end