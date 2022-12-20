clc, clear all;

car = Solution('liquidvapor.cti', 'carbondioxide');

tmin = minTemp(car) + 1;
tmax = maxTemp(car) - 1;
n = 100;
dt = (tmax-tmin)/n;

set(car, 'T', tmax);
vmax = 1/density(car);

set(car, 'T', tmin, 'Liquid', 1.0);
vmin = 1/density(car);

dlogs = log10(vmax/vmin)/n;

%h = zeros(n, 1);
%t = zeros(n, 1);
%p = zeros(n, n);

for i=1:n
	logh(i) = log10(vmin) + (i-1)*dlogs;
	h = 10.0^logh(i);
	for j=1:n
		t(j) =tmin + (j-1)*dt;
		set(car, 'T', t(j), 'Enthalpy', h)
		logp(j, i) = log10(pressure(car));
	end
end

Z = logp;
[X, Y] = meshgrid(logh, t);
surface = surf(X, Y, Z);
%surface.Facecolor = 'interp';