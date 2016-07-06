function [velocity,yaw] = extract_state_data_3(vehicle_state)
%#codegen
coder.extrinsic('fprintf')


%fprintf('The demision of Radar Sensor data:  m = %d , n = %d \r\n',m,n);

velocity = vehicle_state(10);
yaw = vehicle_state(12);


end