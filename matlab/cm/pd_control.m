function [u] = pd_control(x,dx,p_ref,d_ref)
%PD_CONTROL Calculates current control output based on PD control law
%   Input:
%     - x = Current State
%     - dx = Current Speed
%     - p_ref = Target Position
%     - d_ref = Target Velocity
%   Output: 
%     - u = Control Signal 


Kp = 10;
Kd = 0.5;


u = Kp*(p_ref-x) + Kd*(d_ref-dx);
    
end

