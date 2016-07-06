function actions = decision_making(potential_collisions,vehicle_state)
%#codegen

persistent det_flag;
persistent ped_detection;
persistent ttc;
persistent flag06;
persistent flag16;
persistent s;
persistent ped_speed_static;

coder.extrinsic('fprintf')

if isempty(det_flag)
    det_flag = 0;
end

if isempty(ped_detection)
    ped_detection = 0;
end

if isempty(ttc)
    ttc = 12340;
end

if isempty(flag06)
    flag06 = 0;
end

if isempty(flag16)
    flag16 = 0;
end

if isempty(s)
    s = 0;
end

if isempty(ped_speed_static)
    ped_speed_static = 0;
end

collision_flag = potential_collisions(1);
collision_ttc = potential_collisions(2);

%fprintf('Potential Collision Prediction: final flag = %f, final ttc = %f\n',collision_flag,collision_ttc);

if collision_ttc > 0 && collision_flag >0
   ttc=collision_ttc;
   flag = collision_flag;
end

if(ttc > 0 && ttc <= 2)
    det_flag = 1;
end

if(ttc > 0 && ttc <= 1.90)
    ped_detection = 1;
end

if(ttc > 0 && ttc <= 1.60)
    flag16 = 1;
end

if(ttc > 0 && ttc <= 0.60)
    flag06 = 1;
end

actions = [0; 0; 0; 0; 0];
% actions = zeros(1,5);
% 
% actions(1,1) = 0;
% 
% if(flag06==1)
% actions(1,2) = 100;
% actions(1,3) = 1;
% actions(1,4) = 1;
% actions(1,5) = 1;
% else
% actions(1,2) = 0;
% actions(1,3) = 0;
% actions(1,4) = 0;
% actions(1,5) = 0;
% end


end