%% Figure - Coupled Expression Dynamics
% Clear
close all
clear
clc

%% Import
% t is in us
load('time.mat');
load('ode_1a.mat');
load('ode_1r.mat');
load('det3d_1a.mat');
load('det3d_1r.mat');
load('gillespie_1a.mat');
load('gillespie_1r.mat');
load('mcell_1a.mat');
load('mcell_1r.mat');
load('smoldyn_1a.mat');
load('smoldyn_1r.mat');

load('ode_2a.mat');
load('ode_2r.mat');
load('det3d_2a.mat');
load('det3d_2r.mat');
load('gillespie_2a.mat');
load('gillespie_2r.mat');
%load('mcell_1a.mat');
%load('mcell_1r.mat');
load('smoldyn_2a.mat');
load('smoldyn_2r.mat');

%% Process data
%   Data files containing one or more trials are averaged
%   Data points corresponding to the time vector are extrapolated
%   Time is converted to us

% Average Gillespie trials
% temp1 = 0;
% temp2 = 0;
% for n = 1:2:14
%     temp1 = temp1(:,1) + interp1(gillespie_1a(:,n),gillespie_1a(:,n+1), time, 'pchip',0);
%     temp2 = temp2(:,1) + interp1(gillespie_1r(:,n),gillespie_1r(:,n+1), time, 'pchip',0);
% end
% gillespie_1a = temp1(:,1)/7;
% gillespie_1r = temp2(:,1)/7;
% clear temp1
% clear temp2

% Average PDE data
%   2 trials
det3D_2a(:,2) = (det3D_2a(:,2) + det3D_2a(:,4))/2;

det3D_2r(:,2) = (det3D_2r(:,2) + det3D_2r(:,4))/2;

% Average Gillespie trials
% temp1 = 0;
% temp2 = 0;
% for n = 1:2:14
%     temp1 = temp1(:,1) + interp1(gillespie_2a(:,n),gillespie_2a(:,n+1), time, 'pchip',0);
%     temp2 = temp2(:,1) + interp1(gillespie_2r(:,n),gillespie_2r(:,n+1), time, 'pchip',0);
% end
% gillespie_2a = temp1(:,1)/7;
% gillespie_2r = temp2(:,1)/7;
% clear temp1
% clear temp2
%% Plot
% Dual Oscillations
figure(1)
subplot(2,1,1);
hold on;
oa = plot(time, ode_1a, 'Color',[0 0 1]);
pa = plot(det3D_1a(:,1), det3D_1a(:,2),'Color',[0 .75 1]);
ga = plot(gillespie_1a(:,1), gillespie_1a(:,2),'Color',[0 .8 0]);
sa = plot(time, smoldyn_1a, 'Color',[1 .5 0]);
ma = plot(time, mcell_1a, 'Color',[.5 0 .8]);

title('Number of A Molecules');
xlabel('time(s)');
ylabel('N_{A}(t)');

subplot(2,1,2);
hold on;
or = plot(time, ode_1r, 'Color',[0 0 1]);
pr = plot(det3D_1r(:,1), det3D_1r(:,2),'Color',[0 .75 1]);
gr = plot(gillespie_1r(:,1), gillespie_1r(:,2),'Color',[0 .8 0]);
sr = plot(time, smoldyn_1r, 'Color',[1 .5 0]);
mr = plot(time, mcell_1r, 'Color',[.5 0 .8]);
title('Number of R Molecules');
xlabel('time(s)');
ylabel('N_{R}(t)');

lgnd = legend([or pr gr sr mr],'ODE','PDE','Gillespie','Smoldyn', 'MCell');
lgnd.FontSize = 11.5;
lgnd.Position = [.02 .475 1 1];
lgnd.Orientation = 'horizontal';

figure(2);
subplot(2,1,1);
hold on;
oa = plot(ode_2a(:,1), ode_2a(:,2), 'Color',[0 0 1]);
pa = plot(det3D_2a(:,1), det3D_2a(:,2),'Color',[0 .75 1]);
ga = plot(gillespie_2a(:,1), gillespie_2a(:,2),'Color',[0 .8 0]);
sa = plot(smoldyn_2a(:,1), smoldyn_2a(:,2), 'Color',[1 .5 0]);

title('Number of A Molecules');
xlabel('time(s)');
ylabel('N_{A}(t)');

subplot(2,1,2);
hold on;
or = plot(ode_2r(:,1), ode_2r(:,2), 'Color',[0 0 1]);
pr = plot(det3D_2r(:,1), det3D_2r(:,2),'Color',[0 .75 1]);
gr = plot(gillespie_2r(:,1), gillespie_2r(:,2),'Color',[0 .8 0]);
sr = plot(smoldyn_2r(:,1), smoldyn_2r(:,2), 'Color',[1 .5 0]);
title('Number of R Molecules');
xlabel('time(s)');
ylabel('N_{R}(t)');

lgnd = legend([or pr gr sr],'ODE','PDE','Gillespie','Smoldyn');
lgnd.FontSize = 11.5;
lgnd.Position = [.02 .475 1 1];
lgnd.Orientation = 'horizontal';


% Legend 
%   Theory                  Black           [0 0 0]
%   ODE Deterministic       Dark Blue       [0 0 1]
%   PDE Deterministic       Light Blue      [0 .75 1]
%   Gillespie               Green           [0 .8 0]
%   FPR                     Yellow          [1 .85 0]
%   Smoldyn                 Orange          [1 .5 0]
%   MCell                   Purple          [.5 0 .8]
%% Clear
%clear
%clc