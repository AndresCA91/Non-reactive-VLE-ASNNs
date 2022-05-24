function [k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16] = AuxMatrices_NN(n,p,q)
k1  = repelem(eye(p),n^2,1); % Not used in the NRTL with sigmoid function parametrization
k2  = zeros(n^2,n*(n-1));
for k = 1:n-1
    k2((k-1)*n+k+1:(k-1)*n+n+k,(k-1)*n+1:(k-1)*n+n) = eye(n);
end
k3  = kron(eye(p),k2);
k4  = repmat(eye(n^2),1,p);
k5  = eye(n^2);
k6  = repelem(eye(n),n,1);
k7  = repmat(eye(n),1,n);
k8  = eye(n);
k9  = ones(n,1);
k10 = zeros(n^2);
for k = 1:n
    k10(n^3*(k-1)+k:n^2+n:n^3*k) = 1;
end
k11 = repmat(k1,q,1);
k12 = kron(eye(q),k3);
k13 = kron(eye(q),k2);
k14 = kron(eye(q),k4);
k15 = eye(n^2*q);
k16 = repmat(k5,1,q);
end
