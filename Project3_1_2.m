n = 4;
T= 1;
dt = 10^-5;
ft = [0,0,0,0];
u0 = [1,0,0,0];
A = [-2,1,0,0; 1,-2,1,0;0,1,-2,1;0,1,-1,0];


%% Backwards Euler Method doesnt work
t = 0:dt:T; 

i = 0;
for j = 0:dt:T
    i = i+1;
    x(:,i+1) = x(:,i) + dt;
    
    u(:,i+1) = u(:,i) + dt*
    
    
    
end

%% also doesnt work

u = zeros(n,n);
u(:,1) = u0;

for i = 2:n
   u(:,i) = (eye(n)-dt*A)*u(:,i-1);
end

%% extra ALSO doesnt work

for i = 2:n
    J = eye(n) - dt*A;
    u(:,i) = J\u(:,i-1);
end