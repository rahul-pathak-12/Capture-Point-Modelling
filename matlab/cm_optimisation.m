% run main_modelling.m
function weights = cm_optimisation( data )

pos = data.ADJ_COMX;
vel = diff(pos)/(1/100);
acc = diff(vel)/(1/100);

init = [pos(1);
        vel(1);
        acc(1)];

options = optimoptions('fmincon','Display','none');
tic
%    0.191772705642497   2.044316978685702  -0.320327002659518   0.099999813160539   1.310081513726380

weights = fmincon(@(x) run_sim_sin(x,init,vel),...
                                        [ 2,  2, 2, 2, 2],...
                                        [],...        matrix
                                        [],...        b matrix
                                        [],...        Aeq matrix
                                        [],...        beq matrix
                                        [0.1, -1, -1, -0.1, -1.5],...        lb matrix
                                        [3, 3, 1, 0.1, 2],...        ub matrix
                                        [],...        nonlcon matrix
                                        options...
                                        );
