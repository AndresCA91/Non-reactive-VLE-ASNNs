%% Fitting Parameter Assignation

% Wilson (H)   parameters for Ethanol (1) - Cyclohexane (2) 
alpha0 = 1; % alpha
A0 = [-0.6428;-0.8404]; % Binary interaction parameters (Constant)
B0 = [-0.1927;-0.1679]; % Binary interaction parameters (T-dependent)

% Wilson (S-H) parameters for Ethanol (1) - Cyclohexane (2)
% alpha0 = -1.4924; % alpha
% A0 = [0.7191;-0.0080]; % Binary interaction parameters (Constant)
% B0 = [0.0722;0.2011]; % Binary interaction parameters (Temperature dependent)

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

alpha = alpha0; % Eq. 10
A   = A0; % Eq. 11
B   = B0; % Eq. 12
BT  = (k1*t).*(k3*B); % Eq. 13
W   = exp(k2*A + k4*BT); % Eq. 14
L1  = (k6*x).*(k5*W); % Eq. 15
L2  = (k7*L1); % Eq. 16
L3  = 1./(k8*L2); % Eq. 17
L4  = tanh(k8*L3-k9); % Eq. 18  - (GE/RT)/xi
L5  = (k8*L3); % Eq. 19
L6  = (-k10*W) + (k6*L2); % Eq. 20
L7  = sech(k8*L3-k9).^2; % Eq. 21
L8  = (k6*x).*(k6*L3).*(k6*L5).*(k5*L6).*(k6*L7); % Eq. 22
L9  = (k8*L4)+(k7*L8); % Eq. 23
L10 = exp((k8*L9).*(k9*alpha)); % Eq. 24

LR  = (k8*x).*(k8*psat).*(k8*L10); % Eq. 78
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
