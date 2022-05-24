%% ANN Architecture

net                           = network;
net.numInputs                 = 3;
net.numLayers                 = 23;
net.biasConnect               = [0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	1	1	0	0]';
net.inputConnect(3,1)         = 1; 
net.inputConnect(5,1)         = 1; 
net.inputConnect(13,1)        = 1; 
net.inputConnect(15,1)        = 1;
net.inputConnect(15,2)        = 1; 
net.inputConnect(22,3)        = 1; 
net.layerConnect              = [
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0
1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0
1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
1	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	1	0	1	0	0	1	0	0	0	0	0	0	0	0	0	0	1
0	0	0	0	0	0	0	1	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	1	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0
0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
];
                         
net.outputConnect             = [0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	0	0	0	0	0	0];
net.inputs{1}.size            = n;
net.inputs{2}.size            = n;
net.inputs{3}.size            = p;

%% Hidden layer features

net.layers{1}.size            = n^2;
net.layers{1}.netInputFcn     = 'netprod';
net.layers{1}.transferFcn     = 'expf';
net.layers{1}.initFcn         = 'initnw';

net.layers{2}.size            = n^2;
net.layers{2}.netInputFcn     = 'netprod';
net.layers{2}.transferFcn     = 'purelin';
net.layers{2}.initFcn         = 'initnw';

net.layers{3}.size            = n^2;
net.layers{3}.netInputFcn     = 'netprod';
net.layers{3}.initFcn         = 'initnw';

net.layers{4}.size            = n;
net.layers{4}.transferFcn     = 'purelin';
net.layers{4}.initFcn         = 'initnw';

net.layers{5}.size            = n^2;
net.layers{5}.netInputFcn     = 'netprod';
net.layers{5}.transferFcn     = 'purelin';
net.layers{5}.initFcn         = 'initnw';

net.layers{6}.size            = n;
net.layers{6}.transferFcn     = 'purelin';
net.layers{6}.initFcn         = 'initnw';

net.layers{7}.size            = n;
net.layers{7}.transferFcn     = 'netinv';
net.layers{7}.initFcn         = 'initnw';

net.layers{8}.size            = n;
net.layers{8}.netInputFcn     = 'netprod';
net.layers{8}.transferFcn     = 'tansig';
net.layers{8}.initFcn         = 'initnw';

net.layers{9}.size            = n;
net.layers{9}.transferFcn     = 'purelin';
net.layers{9}.initFcn         = 'initnw';

net.layers{10}.size           = n^2;
net.layers{10}.netInputFcn    = 'netprod';
net.layers{10}.initFcn        = 'initnw';

net.layers{11}.size           = n^2;
net.layers{11}.netInputFcn    = 'netprod';
net.layers{11}.initFcn        = 'initnw';
 
net.layers{12}.size           = n^2;
net.layers{12}.transferFcn    = 'purelin';
net.layers{12}.initFcn        = 'initnw';

net.layers{13}.size           = n^2;
net.layers{13}.netInputFcn    = 'netprod';
net.layers{13}.transferFcn    = 'purelin';
net.layers{13}.initFcn        = 'initnw';

net.layers{14}.size           = n;
net.layers{14}.transferFcn    = 'purelin';
net.layers{14}.transferFcn    = 'expf';
net.layers{14}.initFcn        = 'initnw';

net.layers{15}.size           = n;
net.layers{15}.netInputFcn    = 'netprod';
net.layers{15}.transferFcn    = 'purelin';
net.layers{15}.initFcn        = 'initnw';

net.layers{16}.size           = 1;
net.layers{16}.transferFcn    = 'netinv';
net.layers{16}.initFcn        = 'initnw';

net.layers{17}.size           = n;
net.layers{17}.netInputFcn    = 'netprod';
net.layers{17}.initFcn        = 'initnw';

net.layers{18}.size           = 1;
net.layers{18}.transferFcn    = 'purelin';
net.layers{18}.initFcn        = 'initnw';

net.layers{19}.size           = n^2;
net.layers{19}.transferFcn    = 'purelin';
net.layers{19}.initFcn        = 'initnw';

net.layers{20}.size           = n*(n-1);
net.layers{20}.transferFcn    = 'purelin';
net.layers{20}.initFcn        = 'initnw';

net.layers{21}.size           = n*(n-1)*p;
net.layers{21}.transferFcn    = 'purelin';
net.layers{21}.initFcn        = 'initnw';

net.layers{22}.size           = n^2*p;
net.layers{22}.netInputFcn    = 'netprod';
net.layers{22}.initFcn        = 'initnw';

net.layers{23}.size           = n;
net.layers{23}.netInputFcn    = 'netprod';
net.layers{23}.transferFcn    = 'tansigd';
net.layers{23}.initFcn        = 'initnw';

%% Parameter fixing - Fixing of parameters according to the equation decomposition

net                           = init(net);

net.LW{1,18}                  = -sum(k2,2);
net.layerWeights{1,18}.learn  = false;
net.LW{1,19}                  = k5;
net.layerWeights{1,19}.learn  = false;
net.LW{2,19}                  = k5;
net.layerWeights{2,19}.learn  = false;
net.LW{2,1}                   = k5;
net.layerWeights{2,1}.learn   = false;
net.IW{3,1}                   = k6;
net.inputWeights{3,1}.learn   = false;
net.LW{3,1}                   = k5;
net.layerWeights{3,1}.learn   = false;
net.LW{4,3}                   = k7;
net.layerWeights{4,3}.learn   = false;
net.IW{5,1}                   = k6;
net.inputWeights{5,1}.learn   = false;
net.LW{5,2}                   = k5;
net.layerWeights{5,2}.learn   = false;
net.LW{6,5}                   = k7;
net.layerWeights{6,5}.learn   = false;
net.LW{7,4}                   = k8;
net.layerWeights{7,4}.learn   = false;
net.LW{8,6}                   = k8;
net.layerWeights{8,6}.learn   = false;
net.LW{8,7}                   = k8;
net.layerWeights{8,7}.learn   = false;
net.LW{9,7}                   = k8;
net.layerWeights{9,7}.learn   = false;
net.LW{10,1}                  = k10;
net.layerWeights{10,1}.learn  = false;
net.LW{10,6}                  = k6;
net.layerWeights{10,6}.learn  = false;
net.LW{11,2}                  = k10;
net.layerWeights{11,2}.learn  = false;
net.LW{11,4}                  = k6;
net.layerWeights{11,4}.learn  = false;
net.LW{12,10}                 = -k5;
net.layerWeights{12,10}.learn = false;
net.LW{12,11}                 = k5;
net.layerWeights{12,11}.learn = false;
net.IW{13,1}                  = k6;
net.inputWeights{13,1}.learn  = false;
net.LW{13,7}                  = k6;
net.layerWeights{13,7}.learn  = false;
net.LW{13,9}                  = k6;
net.layerWeights{13,9}.learn  = false;
net.LW{13,12}                 = k5;
net.layerWeights{13,12}.learn = false;
net.LW{14,8}                  = k8;
net.layerWeights{14,8}.learn  = false;
net.LW{14,13}                 = k7;
net.layerWeights{14,13}.learn = false;
net.IW{15,1}                  = k8;
net.inputWeights{15,1}.learn  = false;
net.IW{15,2}                  = k8;
net.inputWeights{15,2}.learn  = false;
net.LW{15,14}                 = k8;
net.layerWeights{15,14}.learn = false;
net.LW{16,15}                 = k9';
net.layerWeights{16,15}.learn = false;
net.LW{17,15}                 = k8;
net.layerWeights{17,15}.learn = false;
net.LW{17,16}                 = k9;
net.layerWeights{17,16}.learn = false;
net.LW{19,20}                 = k2;
net.layerWeights{19,20}.learn = false;
net.LW{19,22}                 = k4;
net.layerWeights{19,22}.learn = false;
net.LW{22,21}                 = k3;
net.layerWeights{22,21}.learn = false;
net.IW{22,3}                  = k1;
net.inputWeights{22,3}.learn  = false;

% Related to the NRTL model with hyperbolic tangent excess functions

net.LW{13,23}                 = k6;
net.layerWeights{13,23}.learn = false;
net.LW{23,6}                  = k8;
net.layerWeights{23,6}.learn  = false;
net.LW{23,7}                  = k8;
net.layerWeights{23,7}.learn  = false;

%% This section assigns the NRTL non-randomness factor

if exist('alphan','var')
    if numel(alphan) > 1
        error(['This version of the NRTL has a symmetric nonrandomness factor, alphan must be a scalar'])
    else
        net.b{18} = alphan;
        net.biases{18}.learn = false;
    end
else

end
