clc, clear all;

%creating the substance
sub=Solution('liquidvapor.cti', 'carbondioxide');

%Taking Extreme temperatures and preventing boundary errors
tmin=minTemp(sub) + 0.01;
tmax=maxTemp(sub)-0.15;

%Setting at max temp
set(sub,'T',tmax)
smax= entropy_mass(sub);

% getting entropy for Min temp, liquid state
set(sub, 'T',tmin, 'Liquid', 1.0);
smin=entropy_mass(sub);

%the assumptions and incremental constant
nt=100; 
dt=(tmax-tmin)/nt;
ns=100;
dlogs= log10(smax/smin)/ns;

%creating the required matrices
%s=zeros(ns,1);
%t = zeros(nt,1);
%p=zeros(nt,ns); 

%collecting data in matrices
for i = 1:ns
    logs(i)=log10(smin) + (i-1)*log10(smax/smin)/ns; 
    s=10.0^logs(i);
    for m=1:nt
        t(m) = tmin+ (m-1)*(tmax-tmin)/nt;                                                                                                                                                                                    
        set(sub,'T',t(m),'Entropy',s);
        logp(m,i) = log10(pressure(sub));
    end
end

%plotting the data and creating an stl file
Z=logp;
[X,Y] =meshgrid(logs,t); 
s=surf(X,Y,Z);
s.FaceColor='interp';
%surf2stl('surface.stl',X*30, Y/100, Z)