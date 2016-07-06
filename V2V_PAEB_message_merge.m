function ped_info  = V2V_PAEB_message_merge(num_peds,ped_id,ped_type,ped_size,ped_color,ped_speed,ped_heading,ped_acc,ped_range,ped_theta,ped_dRotz,dx,dy,dz)
%#codegen
coder.extrinsic('fprintf')


%fprintf('The demision of Radar Sensor data:  m = %d , n = %d \r\n',m,n);

%currently we do a simple mearge operation simply according to the range
%and theta value. If two pedestrians have the same range and theta values,
%they will be considered as the same pedestrian.

%The max number of pedestirans after merge. we choose the 10 pedestrians that
%most dangerous to the vhicle.
Max_Num_Pedestrians = 10;

ped_info = zeros(13,Max_Num_Pedestrians);

TotalPeds = 0;

%Get the total number of pedestrians in all received messages
[m,n] = size(num_peds);
for i=1:m
    TotalPeds = TotalPeds + num_peds(i);
end % end for

%fprintf('Audi: The total number of pedestrians detected from messages is %d\r\n',TotalPeds);

%we do something only if there is at least 1 pedestrian
if(TotalPeds > 0)

    CandidatePeds = zeros(Max_Num_Pedestrians*10,1);
    FinalTotalPeds = TotalPeds;
    index = 0;
    
    %Get all the pedestrians
    for i=1:Max_Num_Pedestrians*10
        if ped_range(i) > 0
            index = index +1;
            CandidatePeds(index) = i;
        end
    end
    
    %Filter out the duplicate pedestrians
    if TotalPeds > 1
        for x=1:TotalPeds-1
            if CandidatePeds(x) > 0
                for y=(x+1):TotalPeds
                    if ped_range(CandidatePeds(x)) == ped_range(CandidatePeds(y)) && ped_theta(CandidatePeds(x)) == ped_theta(CandidatePeds(y))
                        CandidatePeds(y) = 0;
                        FinalTotalPeds = FinalTotalPeds - 1;
                        %fprintf('Find a duplicate pedestrian\r\n');
                    end
                end %end for
            end %end if 
        end %end for
    end %end if
    
    
    %Sort these pedestrians if necessary
    if FinalTotalPeds <= Max_Num_Pedestrians %In this case, all the pedestrians will be handled
        
        %fprintf('FinalTotalPeds <= Max_Num_Pedestrians\r\n');
        index = 1;
        for i=1:TotalPeds
            %fprintf('in the loop now\r\n');
           if CandidatePeds(i) > 0
                %fprintf('set values for pedestrian information\r\n');
                ped_info(1,index) = ped_id(CandidatePeds(i));%Pedestrian Id
                ped_info(2,index) = ped_type(CandidatePeds(i));%Pedestrian type
                ped_info(3,index) = ped_size(CandidatePeds(i));%Pedestrian Size
                ped_info(4,index) = ped_color(CandidatePeds(i));%Pedestrian Color
                ped_info(5,index) = ped_speed(CandidatePeds(i));%Pedestrian Speed
                ped_info(6,index) = ped_heading(CandidatePeds(i));%Pedestrian Heading
                ped_info(7,index) = ped_acc(CandidatePeds(i));%Pedestrian Acceleration
                ped_info(8,index) = ped_range(CandidatePeds(i));%Pedestrian Range
                ped_info(9,index) = ped_theta(CandidatePeds(i));%Pedestrian Theta
                ped_info(10,index) = ped_dRotz(CandidatePeds(i));%Pedestrian dRotZ
                ped_info(11,index) = dx(CandidatePeds(i));%Pedestrian dx
                ped_info(12,index) = dy(CandidatePeds(i));%Pedestrian dy
                ped_info(13,index) = dz(CandidatePeds(i));%Pedestrian dz
                index = index + 1;
           end
        end
       
    else %In this case,we choose ten pedestrians that most dangers to the host vehicle
        %Currently, we leave it blank because we only have one pedestrian.
    end
    
    %{
    
    for i=1:13
        for j=1:Max_Num_Pedestrians
            fprintf(' %f',ped_info(i,j));
        end
        
        fprintf('\r\n');
    end
    %}
    
    
    
end % end if