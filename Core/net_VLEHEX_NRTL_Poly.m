%% ANN Architecture

net                           = network;
net.numInputs                 = 4;
net.numLayers                 = 31;
net.biasConnect               = [0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	1	1	0	0]';
net.inputConnect(3,1)         = 1; 
net.inputConnect(5,1)         = 1; 
net.inputConnect(13,1)        = 1; 
net.inputConnect(15,1)        = 1;
net.inputConnect(23,1)        = 1; 
net.inputConnect(15,2)        = 1; 
net.inputConnect(30,3)        = 1; 
net.inputConnect(31,4)        = 1; 

net.layerConnect              = [
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0
1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0
1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
1	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	1	0	1	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	1	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	1	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0
0	0	0	0	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	1	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	1	1	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	1	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0
];
                         
net.outputConnect             = [0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	0	0	0	0	0	0	1	0	0	0	0	0	0	0];
net.inputs{1}.size            = n;
net.inputs{2}.size            = n;
net.inputs{3}.size            = p;
net.inputs{4}.size            = p;

%% Layer Features

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
net.layers{8}.transferFcn     = 'purelin';
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

net.layers{18}.size           = n^2;
net.layers{18}.netInputFcn    = 'netprod';
net.layers{18}.initFcn        = 'initnw';

net.layers{19}.size           = n^2;
net.layers{19}.netInputFcn    = 'netprod';
net.layers{19}.initFcn        = 'initnw';
 
net.layers{20}.size           = n^2;
net.layers{20}.netInputFcn    = 'netprod';
net.layers{20}.initFcn        = 'initnw';

net.layers{21}.size           = n;
net.layers{21}.netInputFcn    = 'netprod';
net.layers{21}.initFcn        = 'initnw';

net.layers{22}.size           = n;
net.layers{22}.transferFcn    = 'purelin';
net.layers{22}.initFcn        = 'initnw';

net.layers{23}.size           = n;
net.layers{23}.netInputFcn    = 'netprod';
net.layers{23}.transferFcn    = 'purelin';
net.layers{23}.initFcn        = 'initnw';

net.layers{24}.size           = 1;
net.layers{24}.transferFcn    = 'purelin';
net.layers{24}.initFcn        = 'initnw';

net.layers{25}.size           = 1;
net.layers{25}.transferFcn    = 'absf';
net.layers{25}.initFcn        = 'initnw';

net.layers{26}.size           = n^2;
net.layers{26}.transferFcn    = 'purelin';
net.layers{26}.initFcn        = 'initnw';

net.layers{27}.size           = n^2;
net.layers{27}.transferFcn    = 'purelin';
net.layers{27}.initFcn        = 'initnw';

net.layers{28}.size           = n*(n-1);
net.layers{28}.transferFcn    = 'purelin';
net.layers{28}.initFcn        = 'initnw';

net.layers{29}.size           = n*(n-1)*p;
net.layers{29}.transferFcn    = 'purelin';
net.layers{29}.initFcn        = 'initnw';

net.layers{30}.size           = n^2*p;
net.layers{30}.netInputFcn    = 'netprod';
net.layers{30}.initFcn        = 'initnw';

net.layers{31}.size           = n^2*p;
net.layers{31}.netInputFcn    = 'netprod';
net.layers{31}.initFcn        = 'initnw';

%% Fix fitting parameters

net                           = init(net);

net.layerWeights{1,25}.learn  = false;
net.LW{1,26}                  = k5;
net.layerWeights{1,26}.learn  = false;
net.LW{2,26}                  = k5;
net.layerWeights{2,26}.learn  = false;
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
net.LW{18,3}                  = k5;
net.layerWeights{18,3}.learn  = false;
net.LW{18,7}                  = k7';
net.layerWeights{18,7}.learn  = false;
net.LW{18,27}                 = k5;
net.layerWeights{18,27}.learn = false;
net.LW{19,5}                  = k5;
net.layerWeights{19,5}.learn  = false;
net.LW{19,7}                  = k7';
net.layerWeights{19,7}.learn  = false;

net.LW{20,19}                 = k5;
net.layerWeights{20,19}.learn = false;
net.LW{20,27}                 = k5;
net.layerWeights{20,27}.learn = false;
net.LW{21,18}                 = k7;
net.layerWeights{21,18}.learn = false;
net.LW{21,19}                 = k7;
net.layerWeights{21,19}.learn = false;
net.LW{22,18}                 = k7;
net.layerWeights{22,18}.learn = false;
net.LW{22,20}                 = -k7;
net.layerWeights{22,20}.learn = false;
net.LW{22,21}                 = k8;
net.layerWeights{22,21}.learn = false;
net.IW{23,1}                  = k8;
net.inputWeights{23,1}.learn  = false;
net.LW{23,22}                 = k8;
net.layerWeights{23,22}.learn = false;
net.LW{24,23}                 = k9';
net.layerWeights{24,23}.learn = false;

% A & B
net.LW{26,28}                 = k2;
net.layerWeights{26,28}.learn = false;
net.LW{26,30}                 = k4;
net.layerWeights{26,30}.learn = false;
net.LW{27,31}                 = k4;
net.layerWeights{27,31}.learn = false;
net.LW{30,29}                 = k3;
net.layerWeights{30,29}.learn = false;
net.LW{31,29}                 = k3;
net.layerWeights{31,29}.learn = false;
net.IW{30,3}                  = k1;
net.inputWeights{30,3}.learn  = false;
net.IW{31,4}                  = k1;
net.inputWeights{31,4}.learn  = false;

%% Symmetric or unsymmetric alpha decision tree
net.b{28} = zeros(n*(n-1),1);

switch Model
    case 'NRTL_Polys'
        net.layers{25}.size           = 1;
        net.layers{25}.transferFcn    = 'absf';
        net.layers{25}.initFcn        = 'initnw';
        net.LW{1,25}                  = -sum(k2,2);
        net.layerWeights{1,25}.learn  = false;
        net.LW{19,25}                 = sum(k2,2);
        net.layerWeights{19,25}.learn = false;
        net.b{25}                     = 0.3;
        if exist('alphan','var')
            if numel(alphan) > 1
                error(['This version of the NRTL has a symmetric nonrandomness factor, switch to NRTL_Polyu instead'])
            else
                net.b{25}                     = alphan;
                net.biases{25}.learn          = false;
            end
        end
    case 'NRTL_Polyu'
        net.layers{25}.size           = n*(n-1);
        net.layers{25}.transferFcn    = 'absf';
        net.layers{25}.initFcn        = 'initnw';
        net.LW{1,25}                  = -k2;
        net.layerWeights{1,25}.learn = false;
        net.LW{19,25}                 = k2;
        net.layerWeights{19,25}.learn = false; 
        if exist('alphan','var')
            if numel(alphan) == 1
                error(['This version of the NRTL has an unsymmetric nonrandomness factor, switch to NRTL_Polys instead'])
            else
                net.b{25}                     = alphan;
                net.biases{25}.learn          = false;
            end
        end
end