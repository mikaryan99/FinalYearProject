%% Sliding Window Protocol
%Used in both Convolutional coding simulation and TCM simulation. Therefore
%must change function which is called... Trellis_Decoder or Decoder

function slide = Slider(message,dimension) %,bits)



output = [];

xprev = 1;

pathL = [0, 1000, 1000, 1000];



for x = dimension:dimension/2:length(message)

    window = message(xprev:x,:); %Trellis_
%     comparison = bits(xprev:x, :);
%     comparison = comparison(1:dimension/2,:);
 
    [slide, pathS] = Decoder(window(1:dimension/2,:), pathL); %CHANGE THIS: when plotting convultional or TCM
    %pathS is the hamming distance at each step
    %pathL is total hammming distance at end of each window for each state 1-4
    
    pathL = pathS;
    
    output = [output; slide]; %could probably initiate with size if errors are gone
    
    xprev = xprev+dimension/2;
    
% %     Used in Convolutional simulation to shorten run timw by running for
% % specific number of errors
%     s = comparison ~= slide; %this is NOT a boolean vector that will be 1 if the entries are the same and 0 if different
%     errors = errors + sum(s) %trying to reach 40 errors
%     
%     if(errors > 999)
%         break
%     end
    
end


%% print out last window
if  (length(output) ~= length(message)) % && errors < 1000
        
    window = message(xprev:end,:);
    
    %CHANGE THIS: when plotting convultional or TCM
    
    [slide, pathL] = Decoder(window, pathL);
%     [slide, pathL] = Trellis_Decoder(window, pathL);
    output = [output; slide];
    
end


slide = output;

end
