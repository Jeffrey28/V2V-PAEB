function [radar_out,num_det_objs] = radar_data_preprocessing(radar_in,vechicle_state,TISdet)
%#codegen

coder.extrinsic('fprintf')


radar_out = radar_in;


%m is number of rows, and n is number of comumns
%[m,n] = size(radar_in);

%fprintf('The demision of Radar Sensor data:  m = %d , n = %d \r\n',m,n);

%Radar_Data_Rows_Per_Object = 10;

%Them max number of objects that the radar sensor can detect
Max_Num_Detected_objects = TISdet;%m/Radar_Data_Rows_Per_Object;

num_det_objs = false(Max_Num_Detected_objects,1);


%Extract the radar data and check if any objects has been detected
for i=1:Max_Num_Detected_objects
    beam_id = radar_in(Max_Num_Detected_objects*0 + i);
    range = radar_in(Max_Num_Detected_objects*1 + i);
    velocity = radar_in(Max_Num_Detected_objects*2 + i);
    velocity_x = radar_in(Max_Num_Detected_objects*3 + i);
    velocity_y = radar_in(Max_Num_Detected_objects*4 + i);
    velocity_z = radar_in(Max_Num_Detected_objects*5 + i);
    theta = radar_in(Max_Num_Detected_objects*6 + i);
    phi = radar_in(Max_Num_Detected_objects*7 + i);
    target_id = radar_in(Max_Num_Detected_objects*8 + i);
    target_type = radar_in(Max_Num_Detected_objects*9 + i);
    velocity_trans_x = radar_in(Max_Num_Detected_objects*10 + i);
    velocity_trans_y = radar_in(Max_Num_Detected_objects*11 + i);
    velocity_trans_z = radar_in(Max_Num_Detected_objects*12 + i);
    velocity_rot_x = radar_in(Max_Num_Detected_objects*13 + i);
    velocity_rot_y = radar_in(Max_Num_Detected_objects*14 + i);
    velocity_rot_z = radar_in(Max_Num_Detected_objects*15 + i);
    
    %fprintf('Radar Data:  beam_id = %d , range = %d, velocity = %d, velocity_x = %d, velocity_y = %d, velocity_z = %d \r\n',beam_id,range,velocity,velocity_x,velocity_y,velocity_z);
    %fprintf('Radar Data:  theta = %d, phi = %d, target_id = %d, target_type = %d \r\n',theta,phi,target_id,target_type);
    
    if range > 0 && target_id > 0
        num_det_objs(i) = true;
    end
    
    %We can do some filter thing here, and delete the objects that are not
    %likely to be pedestrians or not be dangerous.
    
end
