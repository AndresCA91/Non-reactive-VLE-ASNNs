%% Code for Wilson (H) and Wilson (S-H)

NP          = 100;                      % Number of datapoints for the plot
xv          = linspace(0,1,NP)';        % Molar composition vector for the plot
xv          = [xv,1-xv]';               % Molar composition matrix for the plot
T           = 283.15*ones(1,NP);        % Temperature vector for the plot

%% Fitting Parameter Assignation

betaalphas  = -1.5398;                  % Scaling factor
betaW       = [0;0.6450;0.0018;0];      % Binary interaction parameters (Constant)
muW         = [0        0;              % Binary interaction parameters (Temperature dependent)
               0.0907   0
               0.1898   0
               0        0
               ];

%% Pure component vapor pressure (Ethanol (1) - Cyclohexane (2))

Parameters = [
    66.39624472	44.17924472
    -7122.3	-5226.4
    0	0
    0	0
    -7.1424	-4.2278
    2.8853E-06	9.7554E-18
    2	6
    159.05	279.69
    514	553.8
];
Psat = exp(Parameters(1,:)+Parameters(2,:)./(T'+Parameters(3,:)) + Parameters(4,:).*T' + Parameters(5,:).*log(T') + Parameters(6,:).*T'.^(Parameters(7,:)))'; % kPa

%% Auxiliary Matrices

nc          = size(xv,1);
I1          = eye(nc);
I2          = eye(nc^2);
IV1         = ones(nc,1); 
IV2         = ones(nc^2,1);
MA          = repelem(I1,nc,1);
MB          = repmat(I1,1,nc);
MC          = zeros(nc^2);
for k = 1:nc
    MC(nc^3*(k-1)+k:nc^2+nc:nc^3*k) = 1;
end

%% Artificial Neural Network

% Input 
x           = xv;                                                       % Eq. (11)
t           = [1000./T;0.001*T];                                        % Eq. (12)

% DNN
LW          = exp(betaW + muW*t);                                       % Eq. (13)
L1          = (MA*x).*(I2*LW);                                          % Eq. (14)
L2          = (MB*L1);                                                  % Eq. (15)
L3          = 1./(I1*L2);                                               % Eq. (16)
L4          = tanh((I1*L3)-IV1);                                        % Eq. (17) - hyperbolic tangent transfer function
L5          = (I1*L3);                                                  % Eq. (18)
L6          = (-MC*LW) + (MA*L2);                                       % Eq. (19)
L7          = sech((I1*L3)-IV1).^2;                                     % Eq. (20) - derivative of the hyperbolic tangent transfer function
L8          = (MA*x).*(MA*L3).*(MA*L5).*(I2*L6).*(MA*L7);               % Eq. (21)
L9          = (I1*L4)+(MB*L8);                                          % Eq. (22) 
L10         = betaalphas;                                               % Eq. (23) - beta10
L11         = exp((IV1*L10).*(I1*L9));                                  % Eq. (24) - activity coefficients

LR          = (I1*x).*(I1*Psat).*(I1*L11);                              % Eq. (50)
LD          = 1./(IV1'*LR);                                             % Eq. (51)
Ly          = (I1*LR).*(IV1*LD);                                        % Eq. (52)

%% Plot

hold on
plot(x(1,:),1./LD,'-r','linewidth',2)
plot(Ly(1,:),1./LD,'-b','linewidth',2)
xlabel('x_1')
ylabel('P / kPa')

