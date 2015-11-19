function pedestrians = preprocessing(pedestrian_info,vehicle_state)
%#codegen
coder.extrinsic('fprintf')


pedestrians = pedestrian_info;

%{

[m,n] = size(pedestrian_info);
fprintf('The demision of pedestrians:  m = %d , n = %d \r\n',m,n);

for i=1:m
    for j=1:n
        fprintf('*%f ',pedestrians(i,j));
        if(j==10)
            fprintf('\r\n');
        end
    end
end

%}
