function [n_peds,pspeed] = message_get(u)
%#codegen
coder.extrinsic('fprintf');
%coder.extrinsic('format');

n_peds = u(40);

pspeed = u(40);

%for i=1:length(u)
%   fprintf(' %f',u(i));
    
%    if mod(i,10)==0
%       fprintf('\r\n'); 
%    end
%end
end