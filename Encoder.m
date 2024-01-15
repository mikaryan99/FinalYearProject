

function enc = Encoder(input)

Output = zeros(length(input),2);
State1 = 0;
State2 = 0;

for i = 1:length(input)
    in = input(i);
    
    if (in+State1+State2 == 2) || (in+State1+State2 == 0)
        Out1 = 0;
    else
        Out1 = 1;
    end
    
    if (in+State2 == 2) || (in+State2 == 0)
        Out2 = 0;
    else
        Out2 = 1;
    end

    Output(i,:) = [Out1 Out2];
    
    State2 = State1;
    State1 = in;

end

enc = Output;

end

