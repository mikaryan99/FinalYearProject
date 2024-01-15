%Decoder is uses the Viterbi algorith and Hamming distance to decoce
%convolutional code

function [dec, pathS] = Decoder(rxAWGN, pathL)

rx = zeros(length(rxAWGN),2);


%% demodulation
rx = rxAWGN>0;

% rx

%% Node by Node
    
%CHANGEd
A = pathL(1);   %0;
B = pathL(2);  %1000;
C = pathL(3);  %1000;
D = pathL(4);  %1000;

% pathL

a = [0 0];
b = [1 0];
c = [0 1];
d = [1 1];

pathDist = [A; B; C; D];
flagDist = pathDist;

pathA = zeros(length(rx),2);
pathB = zeros(length(rx),2);
pathC = zeros(length(rx),2);
pathD = zeros(length(rx),2);
pathAflag = pathA;
pathBflag = pathB;
pathCflag = pathC;
pathDflag = pathD;

for i = 1:length(rx)
%     DEBUGGER = i
    
%%     "Node A"      
    X = xor(rx(i,:),a);
    Y = xor(rx(i,:),d);
    dX = X(1)+X(2);
    dY = Y(1)+Y(2);
    
    if (pathDist(1) + dX)<(pathDist(3) + dY)
%         "pick path X"
        pathAflag(i,:) = a;

        flagDist(1) = pathDist(1) + dX;
    else
            pathAflag = pathC;
            pathAflag(i,:) = d;
            flagDist(1) = pathDist(3) + dY;
        
    end
    
%%     "Node B"
    X = xor(rx(i,:),d);
    Y = xor(rx(i,:),a);
    dX = X(1)+X(2);
    dY = Y(1)+Y(2);

    if (pathDist(1) + dX)<(pathDist(3) + dY)
%         "pick path X"
        pathBflag = pathA;
        pathBflag(i,:) = d;
        flagDist(2) = pathDist(1) + dX;
    else
            pathBflag = pathC;
            pathBflag(i,:) = a;
            flagDist(2) = pathDist(3) + dY;
        
    end
    
%%     "NodeC"
    X = xor(rx(i,:),b);
    Y = xor(rx(i,:),c);
    dX = X(1)+X(2);
    dY = Y(1)+Y(2);

    if (pathDist(2) + dX)<(pathDist(4) + dY)
       % "pick path X"
        pathCflag = pathB;
        pathCflag(i,:) = b;
        flagDist(3) = pathDist(2) + dX;
    else
            pathCflag = pathD;
            pathCflag(i,:) = c;
            flagDist(3) = pathDist(4) + dY;
        
    end
    
%%     "NodeD"
   
    X = xor(rx(i,:),c);
    Y = xor(rx(i,:),b);
    dX = X(1)+X(2);
    dY = Y(1)+Y(2);

    if (pathDist(2) + dX)<(pathDist(4) + dY)
        %"pick path X"
        pathDflag = pathB;
        pathDflag(i,:) = c;
        flagDist(4) = pathDist(2) + dX;
    else
%             pathD = PathD;
            pathDflag(i,:) = b;
            flagDist(4) = pathDist(4) + dY;
        
    end
%     pathDistANS = pathDist;
%     flagDistANS = flagDist;
    pathDist = flagDist;
    
    pathA = pathAflag;
    pathB = pathBflag;
    pathC = pathCflag;
    pathD = pathDflag;
    
end



pathS = pathDist;


 %% Shortest Hamming D
[M, I] = min(pathDist);

if(I == 1)
    ShortestPath = pathA;
elseif(I == 2)
    ShortestPath = pathB;
elseif(I == 3)
    ShortestPath = pathC;
elseif(I == 4)
    ShortestPath = pathD;
end 

deCode = zeros(length(rx),1);


        if(isequal(ShortestPath(1,:),a))
            if(isequal(ShortestPath(2,:),a) || isequal(ShortestPath(2,:),d))
                deCode(1) = 0;
            else
                deCode(1) = 1;
            end
        end
        
        if(isequal(ShortestPath(1,:),b))
            if(isequal(ShortestPath(2,:),b) || isequal(ShortestPath(2,:),c))
                deCode(1) = 1;
            else
                deCode(1) = 0;
            end
        end
        
        if(isequal(ShortestPath(1,:),c))
            if(isequal(ShortestPath(2,:),c) || isequal(ShortestPath(2,:),b))
                deCode(1) = 1;
            else
                deCode(1) = 0;
            end
        end
        
        if(isequal(ShortestPath(1,:),d))
            if(isequal(ShortestPath(2,:),d) || isequal(ShortestPath(2,:),a))
                deCode(1) = 0;
            else
                deCode(1) = 1;
            end
        end

 
for i = 2:(length(rx)) %must be 2 as there is i-1
    
        if(isequal(ShortestPath(i,:),a))
            if(isequal(ShortestPath(i-1,:),a) || isequal(ShortestPath(i-1,:),d))
                deCode(i) = 0;
            else
                deCode(i) = 1;
            end
        end
        
        if(isequal(ShortestPath(i,:),b))
            if(isequal(ShortestPath(i-1,:),b) || isequal(ShortestPath(i-1,:),c))
                deCode(i) = 1;
            else
                deCode(i) = 0;
            end
        end
        
        if(isequal(ShortestPath(i,:),c))
            if(isequal(ShortestPath(i-1,:),c) || isequal(ShortestPath(i-1,:),b))
                deCode(i) = 0;
            else
                deCode(i) = 1;
            end
        end
        
        if(isequal(ShortestPath(i,:),d))
            if(isequal(ShortestPath(i-1,:),d) || isequal(ShortestPath(i-1,:),a))
                deCode(i) = 1;
            else
                deCode(i) = 0;
            end
        end
end

 dec = deCode;
end

