


function [PSKsymbols, labels] = Trellis_Encoder(input)

labels = zeros(length(input),3);
zout = zeros(length(input),1);
State1 = 0;
State2 = 0;
z = 100;

for idx = 1:length(input)

%     INDEX_BUGGING_ENCODER = i
    
    Out1 = input(idx,1);
    
    if (input(idx,2)+State2 == 2) || (input(idx,2)+State2 == 0)
        Out2 = 0;
    else
        Out2 = 1;
    end
    
    Out3 = State1;
    
    labels(idx,:) = [Out1 Out2 Out3];
    
    State2 = State1;
    State1 = input(idx,2);
    
    
% labels;

%1
if(isequal(labels(idx,:),[0 0 0]))
    z = exp((2*pi/8)*1i*0);
end
%2
if(isequal(labels(idx,:),[0 0 1]))
    z = exp((2*pi/8)*1i*1);
end
%3
if(isequal(labels(idx,:),[0 1 0]))
    z = exp((2*pi/8)*1i*2);
end
%4
if(isequal(labels(idx,:),[0 1 1]))
    z = exp((2*pi/8)*1i*3);
end
%5
if(isequal(labels(idx,:),[1 0 0]))
    z = exp((2*pi/8)*1i*4);
end
%6
if(isequal(labels(idx,:),[1 0 1]))
    z = exp((2*pi/8)*1i*5);
end
%7
if(isequal(labels(idx,:),[1 1 0]))
    z = exp((2*pi/8)*1i*6);
end
%8
if(isequal(labels(idx,:),[1 1 1]))
    z = exp((2*pi/8)*1i*7);
end
    
zout(idx) = z;
end
% labels 
PSKsymbols = zout;

end