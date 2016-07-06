function Potential_Collisions  = collision_detection(TTC_PAEB,FLAG_PAEB,TTC_V2V,FLAG_V2V,TISdet)
%#codegen
persistent ttc;
persistent flag;

coder.extrinsic('fprintf')

if isempty(ttc)
    ttc = 4;
end

if isempty(flag)
    flag = 0;
end

if ((FLAG_PAEB>0) || (FLAG_V2V>0))
    flag = 1;
    ttc = min(TTC_PAEB,TTC_V2V);
end

Potential_Collisions = zeros(2,1);

Potential_Collisions(1) = flag;
Potential_Collisions(2) = ttc;

%fprintf('Potential Collision Prediction: final flag = %f, final ttc = %f\n',flag,ttc);
end