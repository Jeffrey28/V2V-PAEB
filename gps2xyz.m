%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vehicle1 detects object coordinates in local coordinate and sends it to vehicle2,vehicle2 converts the object coordinate from the vehicle1
% coordinte to vehicle2 coordinate.Final output(x,y) is the object coordinates in vehicle2 coordinate.
% Object_LAT is the lattitude of object
% Object_LONG is the longitude of object
% My_LAT is the lattitude of vehicle2
% My_LONG is the longitude of vehicle2
% My_Object_Angle is the angle between vehicle2 y axis and object to vehicle2(origninal point) 
% My_True_Bearing_Angle is the truebearing angle of vehicle2 (0,360)
% My_Object_Distance is the distance between the vehicle2 and object in meter
% north is defined as follow: north is one of the four cardinal directions or compass points. It is the opposite of south and is perpendicular to east and west.
% (x,y) is the object cordinates in vehilce 2 coordinate system
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 

function [dx,dy]=gps2xyz(Object_LAT,Object_LONG,My_LAT,My_LONG)
%calculate the distance between object and vehicle2(My_Object_Distance)
%Convert to radians

coder.extrinsic('vpa');
coder.extrinsic('format');
coder.extrinsic('fprintf');

format long g;

dx = zeros(1,100);
dy = zeros(1,100);

for V_ID=1:10

    vOffset = (V_ID-1)*10;
    
    for i=1:10
        if Object_LAT(vOffset+i)>0

            dy(vOffset+i)= (Object_LAT(vOffset+i) - My_LAT)*(pi/180/2)*6335439.8775;
            dx(vOffset+i)= (Object_LONG(vOffset+i) - My_LONG)*(pi/180/2)*6378137.55;
            %fprintf('dx = %f\r\n',dx(vOffset+i));
            %fprintf('dy = %f\r\n',dy(vOffset+i));
            % Variable-precision arithmetic,10 digits precision
            vpa(dx(vOffset+i),15);
            vpa(dy(vOffset+i),15);
        end %end if
    end %end for
end %end for
end %end function