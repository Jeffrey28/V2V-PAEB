function [v_lat,v_long,v_alt] = extract_state_data_1(vehicle_state)
%#codegen
coder.extrinsic('fprintf')


%fprintf('The demision of Radar Sensor data:  m = %d , n = %d \r\n',m,n);

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


v_lat = vehicle_lat;
v_long = vehicle_long;
v_alt = vehicle_alt;

end