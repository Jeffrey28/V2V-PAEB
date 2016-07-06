function all_flag  = PAEB_detection_flag(flags,TISdet)
%#codegen
coder.extrinsic('fprintf')
all_flag = 0;

%fprintf('The demision of Radar Sensor data:  m = %d , n = %d \r\n',m,n);

for i=1:TISdet
    if flags(i)==1
        all_flag = 1;
    end
end
end