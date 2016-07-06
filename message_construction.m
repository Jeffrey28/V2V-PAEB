function message = message_construction(ped_info,vehicle_info,time,actor_info)
%#codegen

%coder.extrinsic('clock');
coder.extrinsic('vpa');
coder.extrinsic('abs');
coder.extrinsic('format');
coder.extrinsic('fprintf');

format long g;

v_x = vehicle_info(1);
v_y = vehicle_info(2);
v_z = vehicle_info(3);
v_rotx = vehicle_info(4);
v_roty = vehicle_info(5);
v_rotz = vehicle_info(6);
v_lat = vehicle_info(7);
v_long = vehicle_info(8);
v_alt = vehicle_info(9);
v_velocity = vehicle_info(10);
v_head = vehicle_info(11);
v_yaw = vehicle_info(12);

ped_x = actor_info(1,1);
ped_y = actor_info(1,2);
ped_z = actor_info(1,3);
ped_lat = actor_info(1,4);
ped_long = actor_info(1,5);
ped_alt = actor_info(1,6);
ped_heading = actor_info(1,7);
ped_speed = actor_info(1,8);


%Get the max number of objects can be detected by the radar sensor
%MaxNumObjs = length(ped_info)/8;

temp_buf = zeros(200,1);
%Set the sender's information Start.....................................
%Header
index = 1;
temp_buf(index) = 255; %[1]the message destination

index = index+1;
temp_buf(index) = 1; %[2]the message source

index = index+1;
temp_buf(index) = 16; %[3]the message type

index = index+1;
temp_buf(index) = 1; %[4]the message subtype

index = index+1;
temp_buf(index) = 7; %[5]the message priority

%clc = zeros(1,6);%[year month day hour minute seconds]
%clc = clock;
%fix(clc);

index = index+1;
temp_buf(index) = time;%clc(5)*60 + clc(6); %[6]the message event time in seconds

index = index+1;
temp_buf(index) = 1; %[7]the message total packs

index = index+1;
temp_buf(index) = 1; %[8]the message pack id

index = index+1;
temp_buf(index) = 11; %[9]the message body length,11 is the least length when there is no pedestrian info

%Body
index = index+1;
temp_buf(index) = 1; %[10]the sender's id

index = index+1;
temp_buf(index) = 2; % [11]the sender's type

index = index+1;
temp_buf(index) = 3; % [12]the sender's color

index = index+1;
temp_buf(index) = v_lat; % [13]the sender's gps latitude

index = index+1;
temp_buf(index) = v_long; % [14]the sender's gps longitude

index = index+1;
temp_buf(index) = v_alt; % [15]the sender's gps altitude

index = index+1;
temp_buf(index) = v_velocity; % [16]the sender's moving speed

index = index+1;
temp_buf(index) = v_head; % [17]the sender's heading direction

index = index+1;
temp_buf(index) = 9; % [18]the sender's acceleration

index = index+1;
temp_buf(index) = 10; % [19]the sender's gps accuracy
%Set the sender's information End.....................................



%Set the pedestrians' information Start...............................
index = index+1;
temp_buf(index) = 1; % [20]the number of pedestrians, default value is 0

index = index+1;
temp_buf(index) = 1;%pedestrian id

index = index+1;
temp_buf(index) = 100;%pedestrian confidence

index = index+1;
temp_buf(index) = 1;%pedestrian size

index = index+1;
temp_buf(index) = 1;%pedestrian color

index = index+1;
temp_buf(index) = ped_lat;%pedestrian gps latitude location/x coordinate

index = index+1;
temp_buf(index) = ped_long;%pedestrian gps longitude location / y coordinate

index = index+1;
temp_buf(index) = ped_alt;%pedestrian gps altitude location / z coordinate

index = index+1;
temp_buf(index) = ped_speed;%pedestrian velocity

index = index+1;
temp_buf(index) = ped_heading;%pedestrian heading

index = index+1;
temp_buf(index) = 0;%pedestrian acceleration


message = temp_buf;
%Set the pedestrians' information End.................................
end