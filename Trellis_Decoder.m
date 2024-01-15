

function [dec, pathS] = Trellis_Decoder(rx, pathL)

% rx 


a = [0 0 0];
b = [0 0 1];
c = [0 1 0];
d = [0 1 1];
e = [1 0 0];
f = [1 0 1];
g = [1 1 0];
h = [1 1 1];


%% Node by Node
    
A = pathL(1);
B = pathL(2);
C = pathL(3);
D = pathL(4);

pathDist = [A; B; C; D];
flagDist = pathDist;

pathA = zeros(length(rx),3);
pathB = zeros(length(rx),3);
pathC = zeros(length(rx),3);
pathD = zeros(length(rx),3);
pathAflag = pathA;
pathBflag = pathB;
pathCflag = pathC;
pathDflag = pathD;

% EUCs = zeros(length(rx),10);

for idx = 1:length(rx)
    
%     INDEX_BUGGING = idx

    
%% Calculate Squared Euclidean distances between rx and expected

% eucA = Euclidean(rx(idx),1); 
% eucB = Euclidean(rx(idx),exp((2*pi/8)*1i*1));
% eucC = Euclidean(rx(idx),exp((2*pi/8)*1i*2));
% eucD = Euclidean(rx(idx),exp((2*pi/8)*1i*3));
% eucE = Euclidean(rx(idx),exp((2*pi/8)*1i*4));
% eucF = Euclidean(rx(idx),exp((2*pi/8)*1i*5));
% eucG = Euclidean(rx(idx),exp((2*pi/8)*1i*6));
% eucH = Euclidean(rx(idx),exp((2*pi/8)*1i*7));

eucA = abs(rx(idx) - exp((2*pi/8)*1i*0))^2;
eucB = abs(rx(idx) - exp((2*pi/8)*1i*1))^2;
eucC = abs(rx(idx) - exp((2*pi/8)*1i*2))^2;
eucD = abs(rx(idx) - exp((2*pi/8)*1i*3))^2;
eucE = abs(rx(idx) - exp((2*pi/8)*1i*4))^2;
eucF = abs(rx(idx) - exp((2*pi/8)*1i*5))^2;
eucG = abs(rx(idx) - exp((2*pi/8)*1i*6))^2;
eucH = abs(rx(idx) - exp((2*pi/8)*1i*7))^2;

% idx

% EUCs(idx,:) = [rx(idx), idx, eucA, eucB, eucC, eucD, eucE, eucF, eucG, eucH];

%%     "Node A"      

    %decide most likely from each path   
    if(eucA < eucE)
        %pick a
        choice1 = [eucA,a];
    else
%         pick e
        choice1 = [eucE,e];
    end
    
    if(eucC < eucG)
        %pick c
        choice2 = [eucC,c];
    else
%         pick g
        choice2 = [eucG,g];
    end

    %decide most likely path
    if(pathDist(1) + choice1(1))<(pathDist(3) + choice2(1))
        %pick choice1
        pathAflag(idx,:) = choice1(2:4); %answer is a or e
        
        flagDist(1) = pathDist(1) + choice1(1);
    else
        %pick choice2
        pathAflag = pathC;
        pathAflag(idx,:) = choice2(2:4); %answer is c or g
        
        flagDist(1) = pathDist(3) + choice2(1);
    end

%%     "Node B"

  %decide most likely from each path
    if(eucC < eucG)
        %pick c
        choice1 = [eucC,c];
    else
%         pick g
        choice1 = [eucG,g];
    end
    
    if(eucA < eucE)
        %pick a
        choice2 = [eucA,a];
    else
%         pick e
        choice2 = [eucE,e];
    end

    %decide most likely path
    if(pathDist(1) + choice1(1))<(pathDist(3) + choice2(1))
        %pick choice1
        pathBflag = pathA;
        pathBflag(idx,:) = choice1(2:4); %answer is c or g
        
        flagDist(2) = pathDist(1) + choice1(1);
    else
        %pick choice2
        pathBflag = pathC;
        pathBflag(idx,:) = choice2(2:4); %answer is a or e
        
        flagDist(2) = pathDist(3) + choice2(1);
    end

%%     "NodeC"

  %decide most likely from each path
    if(eucB < eucF)
        %pick b
        choice1 = [eucB,b];
    else
%         pick f
        choice1 = [eucF,f];
    end
    
    if(eucD < eucH)
        %pick d
        choice2 = [eucD,d];
    else
%         pick h
        choice2 = [eucH,h];
    end
    
    %decide most likely path
    if(pathDist(2) + choice1(1))<(pathDist(4) + choice2(1))
        %pick choice1
        pathCflag = pathB;
        pathCflag(idx,:) = choice1(2:4); %answer is b or f
        
        flagDist(3) = pathDist(2) + choice1(1);
    else
        %pick choice2
        pathCflag = pathD;
        pathCflag(idx,:) = choice2(2:4); %answer is d or h
        
        flagDist(3) = pathDist(4) + choice2(1);
    end

%%     "NodeD"

  %decide most likely from each path
    if(eucD < eucH)        
        %pick d
        choice1 = [eucD,d];
    else
        %pick h
        choice1 = [eucH,h];
    end

    if(eucB < eucF)
        %pick b
        choice2 = [eucB,b];
    else
%         pick f
        choice2 = [eucF,f];
    end

    
    %decide most likely path
    if(pathDist(2) + choice1(1))<(pathDist(4) + choice2(1))
        %pick choice1
        pathDflag = pathB;
        pathDflag(idx,:) = choice1(2:4); %answer is d or h
        
        flagDist(4) = pathDist(2) + choice1(1);
       
    else
        %pick choice2
        pathDflag = pathD;
        pathDflag(idx,:) = choice2(2:4); %answer is b or f
        
        flagDist(4) = pathDist(4) + choice2(1);

    end



%     pathDistANS = pathDist;
%     flagDistANS = flagDist;
    pathDist = flagDist;
    
    pathA = pathAflag;
    pathB = pathBflag;
    pathC = pathCflag;
    pathD = pathDflag;
    
end
%%
pathS = pathDist;


 %% Shortest Euclidean D
[M, I] = min(pathDist);

% shortest = I

if(I == 1)
    ShortestPath = pathA;
elseif(I == 2)
    ShortestPath = pathB;
elseif(I == 3)
    ShortestPath = pathC;
elseif(I == 4)
    ShortestPath = pathD;
end 

dec = ShortestPath;



end

