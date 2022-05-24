%% Fitting Parameter Assignation

% NRTLH parameters for Ethanol (1) - Cyclohexane (2) 
alpha0 = [-0.7723;-0.7723]; % alpha
A0 = [0.6509;0.1943]; % Binary interaction parameters (Constant)
B0 = [0.1176;0.1769]; % Binary interaction parameters (T-dependent)

%% Fixed Model Parameters / Auxiliary Matrices

n  = length(A0); % Number of components
p  = size(B0,1)/n; % Number of temperature dependent parameters
[k1,k2,k3,k4,k5,k6,k7,k8,k9,k10] = AuxMatrices_Poly(n,p); % Auxiliary matrices

%% Input preparation

NP = 100; % Number of datapoints for the plot
x  = linspace(0,1,NP)'; % Molar composition vector for the plot
x  = [x,1-x]'; % Input vector #1
T  = 283.15*ones(1,NP); % Temperature values
t  = [1000./T]; % Input vector # 2
psat = psatf(T); % Input vector #3

%% Algorithmically Structure Neural Network (ASNN)

alpha = alpha0; % Eq. 30
A   = A0; % Eq. 31
B   = B0; % Eq. 32
BT  = (k1*t).*(k3*B); % Eq. 33
tau = (k2*A)+(k4*BT); % Eq. 34
W   = exp((-k2*alpha).*(k5*tau)); % Eq. 35
V   = (k5*tau).*(k5*W); % Eq. 36
L1  = (k6*x).*(k5*W); % Eq. 37
L2  = (k7*L1); % Eq. 38
L3  = (k6*x).*(k5*V); % Eq. 39
L4  = (k7*L3); % Eq. 40
L5  = 1./(k8*L2); % Eq. 41
L6  = tanh((k8*L4).*(k8*L5)); % Eq. 42
L7  = (k8*L5); % Eq. 43
L8  = (k10*W).*(k6*L4); % Eq. 44
L9  = (k10*V).*(k6*L2); % Eq. 45
L10 = (-k5*L8) + (k5*L9); % Eq. 46
L11  = sech((k8*L4).*(k8*L5)).^2; % Eq. 47
L12 = (k6*x).*(k6*L5).*(k6*L7).*(k5*L10).*(k6*L11); % Eq. 48
L13 = exp((k8*L6)+(k7*L12)); % Eq. 49

LR  = (k8*x).*(k8*psat).*(k8*L13); % Eq. 78
LD  = 1./(k9'*LR); % Eq. 79
Ly  = (k8*LR).*(k9*LD); % Eq. 80

%% Thermodynamic Functions

GEX = (8.314*sum(x.*L4).*T.^2)'; % Excess molar Gibbs energy
pi  = LR'; % Partial pressure
P   = 1./LD'; % Total pressure
y   = Ly'; % Vapor molar fractions

%% P-xy plot

hold on
box on
K1 = plot(x(1,:),1./LD,'-r','linewidth',2);
K2 = plot(Ly(1,:),1./LD,'-b','linewidth',2);
xlabel('{\itx_1},{\ity_1}')
ylabel('{\itP} / kPa')
legend([K1,K2],'Liquid phase', 'Vapor phase','Location','Southwest','NumColumns',1)
set(gca,'FontSize',18)
set(gca,'linewidth',1.5)