function [range,velocity,theta] = extract_PAEB_data(PAEB_Data,TISdet)
%#codegen
coder.extrinsic('fprintf')

%m is number of rows, and n is number of comumns
%[m,n] = size(radar_data);

%fprintf('The demision of Radar Sensor data:  m = %d , n = %d \r\n',m,n);

%Radar_Data_Rows_Per_Object = 10;

%Them max number of objects that the radar sensor can detect
Max_Num_Detected_objects = TISdet;%m/Radar_Data_Rows_Per_Object;

range = zeros(Max_Num_Detected_objects,1);
velocity = zeros(Max_Num_Detected_objects,1);
theta = zeros(Max_Num_Detected_objects,1);


%Extract the information from the radar data

for i=1:Max_Num_Detected_objects
    range(i) = PAEB_Data(Max_Num_Detected_objects*1 + i);
    velocity(i) = PAEB_Data(Max_Num_Detected_objects*2 + i);
    theta(i) = PAEB_Data(Max_Num_Detected_objects*6 + i);
    
    %fprintf('The Radar Data Audi:  range = %f , velocity = %f ,theta = %f\r\n',range(i),velocity(i),theta(i));
end

end