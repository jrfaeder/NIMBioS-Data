function[At, ktvec, tvec, ktintvec] = irrAA_2D(A0,k,s,D,time)
% Concentrations are in units of molecules per nm^{2}
% Length scale s is in units of nm
% time is in us ({\mu}s)  
% A0(molecules per nm^{2})
% k and D are in units of nm^2/({\mu}s)

scalarshorttime=0.001; %shortime asymptote
scalarlongtime=10; %long time asymptote
%to avoid using asymptotes, set shorttime=0 and longtime>time(end)*sig^2/D.

%%% FOR RXN TYPE: A+A->0

At = zeros(length(time),1);
numTsample=1000; %length of the time vector for k(t)
[ktvec,tvec] = ktassister(time,D,k,s,scalarlongtime,scalarshorttime, numTsample);

for i = 1:length(time)
    
    ts = time(i);
    if ts == 0
        ktint = 0;
    else
        ktint = integral(@(t) givekt(t,ktvec,tvec),0,ts);
    end
    ktintvec(i)=ktint;
    At(i) = A0/(1+A0*ktint);
    
end


function kt = givekt(t,ktvec,tvec)
% find kt interpolated

kt = interp1(tvec,ktvec,t);