
% Problem Constants and vectors
L12 = 0.1; a = 200; b = 2; theta = 20; T = 1; L = 1; Nt = 1000; dt = T/Nt; 
Nx = 1000; dx = L/Nx; k1 = 10; k2 = 0.1; L1 = 0.7; L2 = 0.2; 
xvec = 0:dx:L; tvec = 0:dt:T; n = length(xvec)-1;
Qext =  a*exp(-b*xvec).*sin(theta*xvec); 

Htimederiv = [-100/dx.^2; zeros(length(tvec)-2,1)]';
H = [100 zeros(1,length(xvec)-1); zeros(length(tvec)-1,length(xvec))];
H(:,1) = 100;

k1vec = ones(1,700) * k1 ;
k2vec = (k2 - k1) * ( (xvec(701:799)-L1) / L12  ) + k1;
k3vec =  ones(1,201) * k2;
% making second derivative matrix A

%creates 1 -2 1 diagnal matrix

e = ones(n,1);
A = spdiags([e -2*e e],-1:1,n,n);



% change the last element of last row
A(end,end) = -1;



for i = 1:length(tvec)-1
    
  aprx = ( ( (A / dx^2)*(H(i+1,2:end))' )  )';
  Htimederiv = [ (aprx(1:700).* k1vec), (aprx(701:799).* k2vec), (aprx(800:1000).*k3vec) ] + Qext(2:end);

% cycles tempature values through time
 H(i+1,2:end) = Htimederiv*dt + H(i,2:end);
% calculates new temapture with respect to time derivative values 
    % have to make sure variable k values are taken into account

 
end


plot(xvec,H(end,:));
