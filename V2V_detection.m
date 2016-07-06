function [TTC_min_out,all_flags] = V2V_detection(V2V_Data,vehicle_state,TISdet)
%#codegen
persistent ttc;
persistent flag;

coder.extrinsic('fprintf')

if isempty(ttc)
    ttc = 4;
end

if isempty(flag)
    flag = 0;
end

%m is number of rows, and n is number of comumns
%[m,n] = size(radar_data);

%fprintf('The demision of Radar Sensor data:  m = %d , n = %d \r\n',m,n);

%Radar_Data_Rows_Per_Object = 10;


vehicle_x = vehicle_state(1);
vehicle_y = vehicle_state(2);
vehicle_z = vehicle_state(3);
vehicle_rot_x = vehicle_state(4);
vehicle_rot_y = vehicle_state(5);
vehicle_rot_z = vehicle_state(6);
vehicle_lat = vehicle_state(7);
vehicle_long = vehicle_state(8);
vehicle_alt = vehicle_state(9);
vehicle_speed = vehicle_state(10);
vehicle_heading = vehicle_state(11);
vehicle_yaw = vehicle_state(12);

%Get the demension of pedestrian_info_v2v
[m2,n2] = size(V2V_Data);

%{
%fprintf('Potential Collision Prediction: pedestrian_info_v2v m = %d, pedestrian_info_v2v n = %d\n',m2,n2);
for i=1:m2
    for j=1:n2
        %fprintf('%f ',V2V_Data(i,j));
        if(j==10)
            %fprintf('\r\n');
        end
    end
end
%}


%Predict the collision point

for i=1:n2
    
    ped_id = V2V_Data(1,i);
    ped_type = V2V_Data(2,i);
    ped_size = V2V_Data(3,i);
    ped_color = V2V_Data(4,i);
    ped_speed = V2V_Data(5,i);
    ped_heading = V2V_Data(6,i);
    ped_acc = V2V_Data(7,i);
    ped_range = V2V_Data(8,i);
    ped_theta = V2V_Data(9,i);
    ped_drotz = V2V_Data(10,i);
    ped_dx = V2V_Data(11,i);
    ped_dy = V2V_Data(12,i);
    ped_dz = V2V_Data(13,i);
    
    %fprintf('Potential Collision Prediction: ped_id=%f, ped_type=%f, ped_size=%f, ped_color=%f, ped_speed=%f, ped_heading=%f, ped_acc=%f, ped_range=%f\n',ped_id,ped_type,ped_size,ped_color,ped_speed,ped_heading,ped_acc,ped_range);  
    %fprintf('Potential Collision Prediction: ped_theta=%f, ped_drotz=%f, ped_dx=%f, ped_dy=%f, ped_dz=%f\n',ped_theta,ped_drotz,ped_dx,ped_dy,ped_dz); 
    
    if ped_dx>0 && ped_dy>0
       ttc_x = ped_dx/vehicle_speed;
       ttc_y = ped_dy/ped_speed;
       
       %fprintf('Potential Collision Prediction: ttc_x=%f, ttc_y=%f\n',ttc_x,ttc_y); 
      
       if(ttc_y < ttc)
            ttc = ttc_y;
            flag = 1;
       end
       
    end
end



TTC_min_out = ttc;
all_flags = flag;
end