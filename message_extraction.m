function [NumPeds,Ped_ID,Ped_Type,Ped_Size,Ped_Color,Ped_Lat,Ped_Long,Ped_Alt,Ped_Speed,Ped_Heading,Ped_Acc] = MsgExt(Msg1,Msg2,Msg3,Msg4,Msg5,Msg6,Msg7,Msg8,Msg9,Msg10,currentTime)

%Extract the message header
coder.extrinsic('clock');
coder.extrinsic('vpa');
coder.extrinsic('fprintf');
coder.extrinsic('format');
format long g;

%The max number of messages the receiver can handle at a time
Max_Num_Messages_Can_Handle = 10;

%The max number of pedestrians included in one single message
Max_Num_Peds_Per_Message = 10;


    MsgBuf = zeros(1,400);
    
    NumPeds = zeros(1,10);
    
    Ped_ID = zeros(1,100);%10 messages * 10 pedestrians per message
    Ped_Type = zeros(1,100);
    Ped_Size = zeros(1,100);
    Ped_Color = zeros(1,100);
    Ped_Lat = zeros(1,100);
    Ped_Long = zeros(1,100);
    Ped_Alt = zeros(1,100);
    Ped_Speed = zeros(1,100);
    Ped_Heading = zeros(1,100);
    Ped_Acc = zeros(1,100);


for V_ID=1:Max_Num_Messages_Can_Handle
    if(V_ID==1)
        MsgBuf = Msg1;
    elseif(V_ID==2)
        MsgBuf = Msg2;
    elseif(V_ID==3)
        MsgBuf = Msg3;
    elseif(V_ID==4)
        MsgBuf = Msg4;
    elseif(V_ID==5)
        MsgBuf = Msg5;
    elseif(V_ID==6)
        MsgBuf = Msg6;
    elseif(V_ID==7)
        MsgBuf = Msg7;
    elseif(V_ID==8)
        MsgBuf = Msg8;
    elseif(V_ID==9)
        MsgBuf = Msg9;
    elseif(V_ID==10)
        MsgBuf = Msg10;
    end %End if
    
    %for tt=1:400
     %   fprintf('Receiver: vId = %d, index = %d, value = %f\n',V_ID,tt,MsgBuf(tt));
    %end
    
    Msg_Dst = MsgBuf(2); %Message Destination
    Msg_Src = MsgBuf(4); %Message From
    Msg_Type = MsgBuf(6); %Message Type
    Msg_SubType = MsgBuf(8); %Message Subtype
    Msg_Priority = MsgBuf(10); %Message Priority
    Msg_EventTime = MsgBuf(12); %Message Event Time
    Msg_TotalPacks = MsgBuf(14); %Message Total Packs
    Msg_PackId = MsgBuf(16); %Message Package Id
    Msg_PaylaodLength = MsgBuf(18);%Message Payload Length
    
    if (Msg_PaylaodLength == 0)
        continue;
    end

    %Get the Sender's information
    Self_ID = MsgBuf(20); %Sender Self Id
    Self_Type = MsgBuf(22); %Sender Self Type
    Self_Color = MsgBuf(24); %Sender Self Color
    Self_GpsLat = MsgBuf(26); %Sender Self Latitude
    Self_GpsLong = MsgBuf(28); %Sender Self Longtitue
    Self_GpsAlt = MsgBuf(30); %Sender Self Altitude
    Self_Speed = MsgBuf(32); %Sender Self Speed
    Self_Heading = MsgBuf(34); %Sender Self Heading
    Self_Acc = MsgBuf(36); %Sender Self Acceleration
    Self_GpsAcc = MsgBuf(38); %Sender Self GPS precision
   
    %The time has passed from the time the message was generated on the
    %sender to now
    timeElapsed = currentTime - Msg_EventTime;

    %Get the information of pedestrians
    NumPeds(V_ID) = MsgBuf(40); %Total number of objects detected
    vOffset = (V_ID-1)*Max_Num_Peds_Per_Message;
    
    fprintf('NumPeds = %f\r\n',NumPeds(V_ID));
    
    for i=1:NumPeds(V_ID)
        offset = (i-1)*10*2; % Ten Items for each pedestrian. Two bytes for each item.
        
        %Filter out the expired messages
        if(timeElapsed >= 0 && timeElapsed <= 2)
            Ped_ID(vOffset+i) = MsgBuf(42+offset); %Object Id
            Ped_Type(vOffset+i) = MsgBuf(44+offset); %Object Type
            Ped_Size(vOffset+i) = MsgBuf(46+offset); %Object Size
            Ped_Color(vOffset+i) = MsgBuf(48+offset); %Object Color
            
            MsgPedLat = MsgBuf(50+offset); %Object Latitude
            MsgPedLong = MsgBuf(52+offset); %Object Longitude
            MsgPedAlt = MsgBuf(54+offset); %Object Altitude
            
            fprintf('Receiver: Lat = %f, Long = %f, Alt = %f, Speed = %f, Heading = %f \r\n',MsgPedLat,MsgPedLong,MsgPedAlt,MsgBuf(56+offset),MsgBuf(58+offset));
            
            r_range = timeElapsed*MsgBuf(56+offset);%pedestrian moved distance   Object Speed
            objBearingAngle = MsgBuf(58+offset)*pi/180;%pedestrian moving direction Object Heading
            
            

            %Predict current GPS latitude for the pedestrian
            CurrPedLat = MsgPedLat;% + (cos(objBearingAngle)*r_range*180*2)/(pi*6335439.8775);
            vpa(CurrPedLat,15);
            Ped_Lat(vOffset+i) = CurrPedLat;
            %fprintf('CurrPedLat = %f\r\n',CurrPedLat);


            %Predict current GPS longitude for the pedestrian
            CurrPedLong = MsgPedLong;% + (sin(objBearingAngle)*r_range*180*2)/(pi*6378137.55);
            vpa(CurrPedLong,15);
            Ped_Long(vOffset+i) = CurrPedLong;
            %fprintf('CurrPedLong = %f\r\n',CurrPedLong);

            %Predict current GPS altitude for the pedestrian
            Ped_Alt(vOffset+i) = MsgPedAlt;
            Ped_Speed(vOffset+i) = MsgBuf(56+offset); %Object Speed
            Ped_Heading(vOffset+i) = MsgBuf(58+offset);
            Ped_Acc(vOffset+i) = MsgBuf(60+offset); 
            
        else
            Ped_ID(vOffset+i) = 0;
            Ped_Type(vOffset+i) = 0;
            Ped_Size(vOffset+i) = 0;
            Ped_Color(vOffset+i) = 0;

            Ped_Lat(vOffset+i) = 0;
            Ped_Long(vOffset+i) = 0;
            Ped_Alt(vOffset+i) = 0;


            Ped_Speed(vOffset+i) = 0;
            Ped_Heading(vOffset+i) = 0;
            Ped_Acc(vOffset+i) = 0;
        end %endif
    end %End for loop
    
end %End for loop

end %End function
