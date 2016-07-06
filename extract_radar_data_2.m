function ped_info = fcn(det_flag,radar_data,vehicle_state,TISdet)
%#codegen
coder.extrinsic('vpa')
coder.extrinsic('fprintf')
%m is number of rows, and n is number of comumns
[m,n] = size(radar_data);


%Radar_Data_Rows_Per_Object = 16;

%Them max number of objects that the radar sensor can detect
Max_Num_Detected_objects = TISdet;%m/Radar_Data_Rows_Per_Object;

Num_Prarams_Per_Pedestrian = 16;

%fprintf('The demision of Ped Info:  m = %d , n = %d \r\n',Max_Num_Detected_objects,Num_Prarams_Per_Pedestrian);

ped_info = zeros(m,n);

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


for i=1:Max_Num_Detected_objects
  beam_id = radar_data(Max_Num_Detected_objects*0 + i);
   %beam_id = radar_data(Max_Num_Detected_objects)
    range = radar_data(Max_Num_Detected_objects*1 + i);
    velocity = radar_data(Max_Num_Detected_objects*2 + i);
    velocity_x = radar_data(Max_Num_Detected_objects*3 + i);
    velocity_y = radar_data(Max_Num_Detected_objects*4 + i);
    velocity_z = radar_data(Max_Num_Detected_objects*5 + i);
    theta = radar_data(Max_Num_Detected_objects*6 + i);
    phi = radar_data(Max_Num_Detected_objects*7 + i);
    target_id = radar_data(Max_Num_Detected_objects*8 + i);
    target_type = radar_data(Max_Num_Detected_objects*9 + i);
    velocity_trans_x = radar_data(Max_Num_Detected_objects*10 + i);
    velocity_trans_y = radar_data(Max_Num_Detected_objects*11 + i);
    velocity_trans_z = radar_data(Max_Num_Detected_objects*12 + i);
    velocity_rot_x = radar_data(Max_Num_Detected_objects*13 + i);
    velocity_rot_y = radar_data(Max_Num_Detected_objects*14 + i);
    velocity_rot_z = radar_data(Max_Num_Detected_objects*15 + i);
    ped_coordinate_angle = vehicle_heading + theta;
    dx = range*sin(ped_coordinate_angle*pi/180);
    dy = range*cos(ped_coordinate_angle*pi/180);
    dz = range*sin(phi*pi/180);
    
    ped_x = vehicle_x + dx + 2.59859099224801;
    % ped_info(1,i) = ped_x;%(1)ped_x
    
    ped_y = vehicle_y + dy + 10.8900413460814;
 % ped_info(2,i) = ped_y;%(2)ped_y
    
   ped_z = vehicle_z + dz - 0.550530907121998;
     % ped_info(3,i) = ped_z;%(3)ped_z
      
      
    %fprintf('The object type = %d \r\n',target_type);
    
    if target_type == 4 %This is a pedestrian
        ped_info(Max_Num_Detected_objects*0 + i) = beam_id;
      % ped_info(Max_Num_Detected_objects*1 + i) = ped_x;
      % ped_info(Max_Num_Detected_objects*2 + i) = ped_y;
      % ped_info(Max_Num_Detected_objects*3 + i) = ped_z;
        ped_info(Max_Num_Detected_objects*1 + i) = range;
        ped_info(Max_Num_Detected_objects*2 + i) = velocity;
        ped_info(Max_Num_Detected_objects*3 + i) = velocity_x;
        ped_info(Max_Num_Detected_objects*4 + i) = velocity_y;
        ped_info(Max_Num_Detected_objects*5 + i) = velocity_z;
        ped_info(Max_Num_Detected_objects*6 + i) = theta;
        ped_info(Max_Num_Detected_objects*7 + i) = phi;
        ped_info(Max_Num_Detected_objects*8 + i) = target_id;
        ped_info(Max_Num_Detected_objects*9 + i) = target_type;
        ped_info(Max_Num_Detected_objects*10 + i) = velocity_trans_x;
        ped_info(Max_Num_Detected_objects*11 + i) = velocity_trans_y;
        ped_info(Max_Num_Detected_objects*12 + i) = velocity_trans_z;
        ped_info(Max_Num_Detected_objects*13 + i) = velocity_rot_x;
        ped_info(Max_Num_Detected_objects*14 + i) = velocity_rot_y;
        ped_info(Max_Num_Detected_objects*15 + i) = velocity_rot_z;
        
    end
    
    %fprintf('The Pedestrian type = %d \r\n',ped_info(Max_Num_Detected_objects*9 + i));
    
end

%{
for i=1:Max_Num_Detected_objects
    
    beam_id = radar_data(Max_Num_Detected_objects*0 + i);
    range = radar_data(Max_Num_Detected_objects*1 + i);
    velocity = radar_data(Max_Num_Detected_objects*2 + i);
    velocity_x = radar_data(Max_Num_Detected_objects*3 + i);
    velocity_y = radar_data(Max_Num_Detected_objects*4 + i);
    velocity_z = radar_data(Max_Num_Detected_objects*5 + i);
    theta = radar_data(Max_Num_Detected_objects*6 + i);
    phi = radar_data(Max_Num_Detected_objects*7 + i);
    target_id = radar_data(Max_Num_Detected_objects*8 + i);
    target_type = radar_data(Max_Num_Detected_objects*9 + i);
    
    ped_coordinate_angle = vehicle_heading + theta;
    dx = range*sin(ped_coordinate_angle*pi/180);
    dy = range*cos(ped_coordinate_angle*pi/180);
    dz = range*sin(phi*pi/180);
    
    %Calculate the X coordinate of current pedestrian
    ped_x = vehicle_x + dx;
    ped_info(1,i) = ped_x;%(1)ped_x
    
    
    %Calculate the Y coordinate of current pedestrian
    ped_y = vehicle_y + dy;
    ped_info(2,i) = ped_y;%(2)ped_y
    
    %Calculate the Z coordinate of current pedestrian
    ped_z = vehicle_z + dz;
    ped_info(3,i) = ped_z;%(3)ped_z
    
    
    objBearingAngle =(vehicle_heading+theta)*pi/180;%Degree to Radian
    %Calculate the GPS Latitude coordinate of current pedestrian
    ped_lat = vehicle_lat+(cos(objBearingAngle)*range*180*2)/(pi*6335439.8775);
    
    vpa(ped_lat,15);
    ped_info(4,i) = ped_lat;%(4)ped_lat
    
    %Calculate the GPS Longitude coordinate of current pedestrian
    ped_long = vehicle_long+(sin(objBearingAngle)*range*180*2)/(pi*6378137.55);
    vpa(ped_long,15);
    ped_info(5,i) = ped_long;%(5)ped_long
    
    %Calculate the GPS Altitude coordinate of current pedestrian
    ped_info(6,i) = vehicle_alt;%(6)ped_alt
    
    
    %Calculate the Heading direction coordinate of current pedestrian
    ped_info(7,i) = 90;%(7)ped_heading
    
    %Calculate the Speed coordinate of current pedestrian
    ped_info(8,i) = 1.5;%(8)ped_speed
    
    %Calculate the TTC coordinate of current pedestrian
    ped_info(9,i) = ttc;%(9)ped_ttc
end
%}