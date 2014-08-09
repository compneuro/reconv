% ReConv algorithm for reconstructing evoked LFP in cerebellar granular layer
% Jitter delay function 
%  Last updated 11-June-2011
%  Model developer: Shyam Diwakar M.
%  Developed at Amrita School of Biotechnology (India) and at Prof. Egidio D'Angelo's Lab at Univ of Pavia (Italy)
%  Amrita School of Biotechnology, Amritapuri
%  Clappana P.O., Kollam, 690 525, Kerala, India.
%  http://research.amrita.edu/compneuro
%  Email:shyam@amrita.edu
%  Model published as [Diwakar et al., 2011, manuscript accepted, PLoS ONE]
% Shyam Diwakar, Paola Lombardo, Sergio Solinas, Giovanni Naldi, Egidio D'Angelo. "Local field potential modeling predicts dense activation in cerebellar granule cells clusters under LTP and LTD control", PLoS ONE, 2011.

function y_o = deljitter(x_i,k,noise1)
% Function to introduce delays for studying averaging 
% in measuring extracellular potentials 
% 'Jittering' a signal with a delay using convolution considering the delay
% with a filter kernel h1
% Include a delay of "k" (ms) in the test case (position of k depends of
% size of measuring vector in data)
% Usage: y_o = deljitter(x_i,k) where
% y_o is the necessary output signal
% x_i is the input signal
% k is the position of where signal needs to be shifted and
% summed(convolved) default k=1
% noise is the amount of intrasignal noise to be included default noise=80e-14
% This function introduces gaussian intra-signal noise through 'y3'
% Shyam Diwakar M.
% 22-May-2006

if nargin < 1
    error('deljitter: notEnoughInputs', 'This function requires at least one input.');
end
% user input: position 'k' missing
if (nargin == 1)
    k = 1;
end
% user input: noise missing
if (nargin == 2)
    noise1 =80e-14;
end   
h1=zeros(1,5000);
h1(k)=1;

%h2=zeros(1,60);

%h2 = [ 0 .1 1 -.12 0]; % this is only to convolve the signal with a kernel to get a signal of the
% of the following form: y(n) = h(n) * x(n) <==>
% y(n) = (.1 * x(n+1) ) + x(n) + (-.12 * x(n-1))
%             one advance               one step delayed
% As of now, this is a test case for introducing interference in signal
% However some intereference as gaussian randomness is added through 'y3'

% Do the stuff
y1 = conv(x_i, h1);% delay by 'k' instants of frequency
%y2 = conv(x_i, h2); 
y3 = y1 + noise1*randn(length(y1),1); %delayed with interference
y_o = y3;
