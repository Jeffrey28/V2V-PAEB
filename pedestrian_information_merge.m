function [PedestriansPAEB,PedestriansV2V,PedestrianMerged] = pedestrian_information_merge(pedestrian_info_pcs,pedestrian_info_v2v,vehicle_state,TISdet)
%#codegen

coder.extrinsic('fprintf');


%Get the demension of pedestrian_info_pcs
[m1,n1] = size(pedestrian_info_pcs);

%{
fprintf('Receiver: pedestrian_info_pcs m = %d, pedestrian_info_pcs n = %d\n',m1,n1);
for i=1:m1

    fprintf('%f ',pedestrian_info_pcs(i,1));
    if(mod(i,10)==0)
        fprintf('\r\n');
    end

end
%}

%for ii=1:400
%    fprintf('Receiver: vId = %d, index = %d, value = %f\n',V_ID,tt,MsgBuf(tt));
%end

%Get the demension of pedestrian_info_v2v
[m2,n2] = size(pedestrian_info_v2v);

%{
fprintf('Receiver: pedestrian_info_v2v m = %d, pedestrian_info_v2v n = %d\n',m2,n2);
for i=1:m2
    for j=1:n2
        fprintf('%f ',pedestrian_info_v2v(i,j));
        if(j==10)
            fprintf('\r\n');
        end
    end
end
%}



%Merge the two sets of pedestrians together

%Currently we do not merge them, just put them together
PedestrianMerged = zeros(ceil((m1/TISdet))+m2,max(n1,n2));

PedestriansPAEB = pedestrian_info_pcs;

PedestriansV2V = pedestrian_info_v2v;
end