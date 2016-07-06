function [camera_out,roi_data] = camera_data_preprocessing(camera_data,vehicle_state,radar_data,num_objs,TISdet)
%#codegen

coder.extrinsic('fprintf')

%We can do the preprocessing to the original camera image. For example,
%change the color depth from RGB to Grey.
camera_out = camera_data;

%m is number of rows, and n is number of colums
%[m,n] = size(radar_data);
[res_h,res_v] = size(camera_data);

%fprintf('The demision of Camera Sensor data:  m = %d , n = %d \r\n',res_h,res_v);

%Radar sensor output ten rows of information for each detected object.
%Radar_Data_Rows_Per_Object = 10;

%Them max number of objects that the radar sensor can detect
Max_Num_Detected_objects = TISdet;%m/Radar_Data_Rows_Per_Object;

%One ROI is described as (start_X,start_Y,end_X,end_Y)----From left to
%right and from top to bottom
roi_data = zeros(Max_Num_Detected_objects,4);

%Extract the radar data and check if any objects has been detected
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
    velocity_trans_x = radar_data(Max_Num_Detected_objects*10 + i);
    velocity_trans_y = radar_data(Max_Num_Detected_objects*11 + i);
    velocity_trans_z = radar_data(Max_Num_Detected_objects*12 + i);
    velocity_rot_x = radar_data(Max_Num_Detected_objects*13 + i);
    velocity_rot_y = radar_data(Max_Num_Detected_objects*14 + i);
    velocity_rot_z = radar_data(Max_Num_Detected_objects*15 + i);
    
    %fprintf('Radar Data:  beam_id = %d , range = %d, velocity = %d, velocity_x = %d, velocity_y = %d, velocity_z = %d \r\n',beam_id,range,velocity,velocity_x,velocity_y,velocity_z);
    %fprintf('Radar Data:  theta = %d, phi = %d, target_id = %d, target_type = %d \r\n',theta,phi,target_id,target_type);
    
    %Calculate the ROI in the camera frame for each detected object.
    %Currently, we set ROI to be the whole frame.
    if range > 0 && target_id > 0
        roi_data(i,1) = 0;%start x
        roi_data(i,2) = 0;%start y
        roi_data(i,3) = res_h;%end x
        roi_data(i,4) = res_v;%end y
    end
end