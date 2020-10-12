function lipm = LIPM( height, velocity, interval )
X = [height; % First entry of COM X
     velocity];
g = 9.81;   % Gravity
z = height;      % CoM Z height
Ts = interval; 
mdl_time = linspace( 0, 1.31, 131 );

t = mdl_time;
Tc = sqrt(z/g); %Time constant
[x_list,dx_list,u_track]= deal(zeros(1,length(t)));

% LIPM dynamics matrices 
C = cosh (Ts/Tc);
S = sinh (Ts/Tc);
A = [    C, Tc*S ; ...
      S/Tc,  C  ];
B = [0;
     1];

    for i = 1:length(t)
            u = 0;
            X = A * X + B * u;
            x_list(i) = X(1);
            dx_list(i) = X(2);
            u_track(i) = u;
    end

lipm = x_list';

end