n = 4;
T= 1;
deltat = 10.^-5;
N = floor(T/deltat);
t= linspace(0,T,N);
x = zeros(4,N);
u0 = [1,0,0,0];
x(:,1) = u0;
%dudt = A*u(t) + f(t);
f = [0,0,0,0];
A = [-2,1,0,0; 1,-2,1,0;0,1,-2,1;0,1,-1,0];

for i = 2:N
    D = A * x(i-1) + f(i-1)
    test = deltat * D + x(i-1)
end
