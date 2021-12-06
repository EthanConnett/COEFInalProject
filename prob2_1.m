T = 1; L = 1;
Nt = 1000; dt = T/Nt;
Nx = 1000; dx = L/Nx;
k1 = 10; k2 = 0.1;
L12 = 0.1; L1 = 0.7; L2 = 0.2;
alpha = 200; beta = 2; theta = 20;

t = 0:dt:T;
x = 0:dx:L;
h = zeros(length(t),length(x));
h(:,1) = 100*ones(1,length(t));

for i = 1:length(x)
    if (x(i) <= L1)
        k(i) = k1;
    elseif (x(i) >= L1 + L12)
        k(i) = k2;
    else
        k(i) = k1 + (k2 - k1)*(x(i) - L1)/L12;
    end
end

for i = 1:length(t)
    for j = 1:length(x)
        q(i,j) = alpha*exp(-beta*x(j))*sin(theta*x(j)); %function independent of t, could be written as vector
    end
end

Q = q(1,:);
H = h(:,1);
H(1) = [];
A = zeros(Nx,Nx);

dhdt = zeros(length(t),length(x));
dhdx2 = zeros(length(t),length(x));

%approximation for (6) not working;
%somehow need to incorporate h or H function in the for loop so that it
%can continue with its iterations;
%I think this requires us figuring out the A matrix equation (11)
for j = 2:length(x)
    for i = 1:length(t)
                        
        if j == (Nx + 1)
            dhdx2(i,Nx+1) = (-1/dx)*((h(i,Nx+1) - h(i,Nx))/dx);
        else
            dhdx2(i,j) = (h(i,j+1) - 2*h(i,j) + h(i,j-1))/(dx^2); 
        end
        
        dhdt(i,j) = k(j)*dhdx2(i,j) + q(i,j);
    end
end