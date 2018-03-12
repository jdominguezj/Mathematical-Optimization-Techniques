function [gbest,fvalues] = getbest(gb,POSITIONS,OPERATION,functionObj)
%% FUNCTION: finds gBest
%--------------------------------------------------------------------------
% parameter description:
% gbest_in     ---- Initial best global position
% POSITIONS    ---- Particule's positions
% OPERATION    ---- ¿ What do you want ?  ¿ maximize or minimize?
% functionObj  ---- function to minimize or to maximize
% return : gbest -the best solution we have got
%--------------------------------------------------------------------------

if size(POSITIONS,1) < size(POSITIONS,2)
    POSITIONS = POSITIONS';
end
if size(gb,1) > size(gb,2)
    gb = gb';
end

f = functionObj;
% If you want to maximize  
if OPERATION == 'MAXIMIZE'
    for i = 1:size(POSITIONS,1)
        if (f(POSITIONS(i,:)) > f(gb))
            gb = POSITIONS(i,:);
        end
        fvalues(i) = f(POSITIONS(i,:));
    end
% If you want to minimize    
elseif OPERATION == 'MINIMIZE'
    for i = 1:size(POSITIONS,1)
        if (f(POSITIONS(i,:)) < f(gb))
            gb = POSITIONS(i,:);
        end
        fvalues(i) = f(POSITIONS(i,:));
    end
end
gbest = gb;
fvalues = fvalues';
end


