%k is in nm2/us, s is nm, D is nm2/us, time is in us.
%Return int(0 time) k(dtau) dtau, for all values in time.
function ktinttot=integral_kt2D(k,s,D,time)
scalarshorttime=0.001; %set to zero, it only uses exact integral
scalarlongtime=10;%set to Inf, only use exact.

%the smoother k(t) is, i.e. at more time points, the more accurate the integration
%will be, as it defines values based on linear interpolation.

%the time vector will be evaluated using log-spacing, so smaller spacing at
%lower t. It starts at time(0) and goes to time(end)

numtimepts=1000;

[ktvec,tvec] = ktassister(time,D,k,s,scalarlongtime,scalarshorttime, numtimepts);

ktint=zeros(length(time),1);

for i = 1:length(time)
    
    ts = time(i);
    if ts == 0
        ktint(i) = 0;
    else
        ktint(i) = integral(@(t) givekt(t,ktvec,tvec),0,ts);
    end
  
    
end


ktinttot=[time, ktint];
    
    
function kt = givekt(t,ktvec,tvec)
% find kt interpolated

kt = interp1(tvec,ktvec,t);