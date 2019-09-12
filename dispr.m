function [akk,dkk] = dispr(h,f);
%   function [akk, dkk] = dispr(h, f);
%   The fastest dispersion solver in the West. Written by C.S. Wu.
%   f=freqency   akk=wave no. * depth   dkk=wave no
%   h=depth in meters
%
%   h and f can be scalars, vectors (same size), or one of each

%convert to radians

if (length(f)>1)
  akk = zeros(length(f),1);
elseif (length(h)>1)
  akk = zeros(length(h),1);
end

sig=2*pi*f;
a=h.*sig.^2/9.81;

m = (a >=1);

yhat = a(m).*(1 + 1.26*exp(-1.84*a(m)));
t = exp(-2*yhat);
akk(m) = a(m).*(1 + 2*t.*(1+t));
akk(~m) = sqrt(a(~m)).*(1 + a(~m)/6.*(1 + a(~m)/5));
 
dkk=akk./h;


%short periods, deep water --> some issues
    