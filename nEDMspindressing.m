function varargout = nEDMspindressing(varargin)
% NEDMSPINDRESSING M-file for nEDMspindressing.fig
%      NEDMSPINDRESSING, by itself, creates a new NEDMSPINDRESSING or raises the existing
%      singleton*.
%
%      H = NEDMSPINDRESSING returns the handle to a new NEDMSPINDRESSING or the handle to
%      the existing singleton*.
%
%      NEDMSPINDRESSING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEDMSPINDRESSING.M with the given input arguments.
%
%      NEDMSPINDRESSING('Property','Value',...) creates a new NEDMSPINDRESSING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nEDMspindressing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nEDMspindressing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nEDMspindressing

% Last Modified by GUIDE v2.5 12-Nov-2009 10:06:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nEDMspindressing_OpeningFcn, ...
                   'gui_OutputFcn',  @nEDMspindressing_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before nEDMspindressing is made visible.
function nEDMspindressing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nEDMspindressing (see VARARGIN)

% Choose default command line output for nEDMspindressing
handles.output = hObject;

% Set up the gyromagnetic ratios:
handles.gammao2pi_3He = 3243.6; % Units of Hz/G
handles.gammao2pi_n = 2916.4;

% Set up the grid parameters:
handles.evolution.T = 500;            % Time of simulation...
handles.evolution.num_of_pts = 5*10^5;  % number of simulation pts ...
% Number of simulation pts ...
handles.evolution.spacing = handles.evolution.T/handles.evolution.num_of_pts;

% Make the time axes (both singly spaced, where we will compute the 
%  wavefunction, and doubly spaced, where we will compute the Hamiltonian -
%  required for the Runga-Kutta method):
handles.evolution.time_axis.t = 0:handles.evolution.spacing:handles.evolution.T;
handles.evolution.time_axis.tdbld = 0:handles.evolution.spacing/2:handles.evolution.T;

setappdata(0,'nEDMpref_evolution',handles.evolution);

% Let's pick some reasonable fields/dressing frequencies:
handles.fieldpref.static_field = 0.001;

% Set up the RF-field parameters:
handles.fieldpref.brfparams.dressing_freq = 50;
handles.fieldpref.brfparams.static_value  = 0.02034;  % Let's get as close as possible to critical dressing
handles.fieldpref.brfparams.modulation_freq = 0.1;
handles.fieldpref.brfparams.modulation_amp = 0.1;
handles.fieldpref.brfparams.modulation_type = 'sine';
handles.fieldpref.brfparams.angle_fix = 'yes';
setappdata(0,'nEDMpref_fields',handles.fieldpref);

% Measurement/fill parameters:
handles.fillmeasparams.MeasureTime = 500;
handles.fillmeasparams.FillTime = 700;
handles.fillmeasparams.eps_b = 0.5;
handles.fillmeasparams.eps_3 = 1;
handles.fillmeasparams.tau_b = 885;
handles.fillmeasparams.tau_3 = 1000;
handles.fillmeasparams.tau_cell = 1150;

setappdata(0,'nEDMpref_measfill',handles.fillmeasparams);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nEDMspindressing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nEDMspindressing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in button_calc_sns3.
function button_calc_sns3_Callback(hObject, eventdata, handles)
% hObject    handle to button_calc_sns3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.txt_status,'String','Calculating <SnS3> ...');
drawnow;

handles.evolution = getappdata(0,'nEDMpref_evolution');
handles.fieldpref = getappdata(0,'nEDMpref_fields');

% set(hObject,'String','Running ....');
% set(hObject,'Enable','inactive');
% drawnow;

% First, make the BRF field:
brf  = makebrf(handles.evolution.time_axis.tdbld,handles.fieldpref.brfparams);

plot(handles.axes_brf,handles.evolution.time_axis.tdbld,brf);
xlim(handles.axes_brf,[0 3/handles.fieldpref.brfparams.modulation_freq])
xlabel(handles.axes_brf,'Time (s)');
ylabel(handles.axes_brf,'Dressing Field Amplitude (G)');
grid(handles.axes_brf);

drawnow;

% Actually evolve the states and make it happen:
psi_3He = evolve_state(handles.gammao2pi_3He, handles.evolution, ...
    handles.fieldpref.brfparams.dressing_freq, ...
    handles.fieldpref.static_field, brf);
psi_n = evolve_state(handles.gammao2pi_n, handles.evolution, ...
    handles.fieldpref.brfparams.dressing_freq, ...
    handles.fieldpref.static_field, brf);

% Now compute the spin components at all times:
[sx_3He sy_3He sz_3He] = compute_spin_expectation(psi_3He);
[sx_n sy_n sz_n] = compute_spin_expectation(psi_n);

plot(handles.axes_sx,handles.evolution.time_axis.t,[sx_3He; sx_n]);
xlim(handles.axes_sx,[0 3/handles.fieldpref.brfparams.modulation_freq])
grid(handles.axes_sx)
xlabel(handles.axes_sx,'Time (s)')
ylabel(handles.axes_sx,'<S_x>');

% Now take the dot product
handles.s_3He_dot_s_n = sx_3He.*sx_n + sy_3He.*sy_n + sz_3He.*sz_n;

plot(handles.axes_sprod,handles.evolution.time_axis.t,1 - handles.s_3He_dot_s_n);
grid(handles.axes_sprod)
xlim(handles.axes_sprod,[0 3/handles.fieldpref.brfparams.modulation_freq]);
xlabel(handles.axes_sprod,'Time (s)')
ylabel(handles.axes_sprod,'<S_n\cdotS_3>');

guidata(hObject,handles);

% set(hObject,'String','Run Simulation');
% set(hObject,'Enable','on');

set(handles.txt_status,'String','Waiting...');
drawnow;

function [psi] = evolve_state(gammao2pi, evolution, fd, bs, brf)

gamma = gammao2pi*2*pi; % Gyromagnetic ration in units of (rad/s)/G

%%% Runge-Kutta Method (4th order):

% Curiously, the Runge-Kutta method requires a half point computation of
% the Hamiltonian, so we need a different spacing to compute the
% Hamiltonian on, hence the tdbld variable.
t = evolution.time_axis.t;
tdbld = evolution.time_axis.tdbld;
spacing = evolution.spacing;

% Build the variable to store the wavefunction:
psi(1:2,1:length(t))=0.0;

% Start with out state poited along x
psi(1,1)=1/sqrt(2);
psi(2,1)=1/sqrt(2);

% Now, evolve the state.
for j=1:length(t)-1;
    % Set up the k's of the Runge-Kutta method for the point we are at:
    k1 = -spacing*1i*buildHmatrix(gamma,bs,brf(2*j-1),...
        0,fd,tdbld(2*j-1))*psi(:,j);
	k2 = -spacing*1i*buildHmatrix(gamma,bs,brf(2*j),...
        0,fd,tdbld(2*j))*( psi(:,j) + 0.5*k1 );
	k3 = -spacing*1i*buildHmatrix(gamma,bs,brf(2*j),...
        0,fd,tdbld(2*j))*( psi(:,j) + 0.5*k2 );
	k4 = -spacing*1i*buildHmatrix(gamma,bs,brf(2*j+1),...
        0,fd,tdbld(2*j+1))*( psi(:,j) + k3);

	% Calculate the wave function at the next point:
	psi(:,j+1)=psi(:,j) + 1/6*(k1+2*k2+2*k3+k4);

	% Now, enforce normalization:
    norm = psi(:,j+1)'*psi(:,j+1);
	psi(:,j+1)=psi(:,j+1)/sqrt(norm);
end



function [ sx sy sz ] = compute_spin_expectation(psi)

%%% Now, let's use our wavefunction to compute some values:
sx(1:size(psi,2))=0.0;
sy(1:size(psi,2))=0.0;
sz(1:size(psi,2))=0.0;

[SX SY SZ] = buildspinmatrix();
% Now, compute sigmax and sigmay at all points:
for j=1:size(psi,2);
    sx(j)=psi(:,j)'*SX*psi(:,j);
    sy(j)=psi(:,j)'*SY*psi(:,j);
    sz(j)=psi(:,j)'*SZ*psi(:,j);
end


function [ H ] = buildHmatrix(gamma,Bs,Bdx,Bdz,fd,t)

% Self expanatory, this is the Hamiltonian for the system interacting with
%  classical, coherent photon field....
H = [ -gamma*Bs/2-gamma*Bdz/2*cos(2*pi*fd*t) gamma*Bdx/2*cos(2*pi*fd*t); ...
    gamma*Bdx/2*cos(2*pi*fd*t) gamma*Bs/2+gamma*Bdz/2*cos(2*pi*fd*t)];


function [ b fh sh ] = makebrf(t,params)

if strcmp(params.modulation_type,'sine')
    if strcmp(params.angle_fix,'no')
        b = params.static_value + params.modulation_amp*params.static_value*sin(2*pi*...
            params.modulation_freq * t);

    else
        b = params.static_value ...
            + params.modulation_amp*params.static_value*sin(4*pi*...
                params.modulation_freq * t).*(t<=1/(4*params.modulation_freq)) ...
            - params.modulation_amp*params.static_value*sin(2*pi*...
                params.modulation_freq * (t - 1/(4*params.modulation_freq)) ) ...
                .*(t>1/(4*params.modulation_freq));
    end
    fh = sin(2*pi*params.modulation_freq * t);
    sh = sin(2*2*pi*params.modulation_freq * t);
else
    error('Not yet implemented!');
end



function [SX SY SZ] = buildspinmatrix()
% BUILDSPINMATRIX - build the spin matrices to compute expectation
% values....

SX = [0 1; 1 0];
SY = [0 -1i; 1i 0];
SZ = [1 0; 0 -1];


function plotresult(time, brf, sx_n, sx_3He, sy_n, sy_3He, s_3He_dot_s_n, brfparams)

h1 = clf;
set(h1,'PaperSize',[16 9]);
% set(h1,'PaperOrientation','landscape');

currpos = get(h1,'Position');
set(h1,'Position',[currpos(1:2) 960 640]);

subplot('Position',[ 1/16 2/3+0.05 11/32 1/3-0.1]);
plot(time.tdbld*10^3,brf)
ylim([0 1.1*max(brf)])
ylabel('{\it B_{RF}} (G)')
title('Dressing field vs. time');
grid;

subplot('Position',[ 1/16 1/3+0.0625 11/32 1/3-0.1]);
plot(time.t*10^3,[sx_n; sx_3He])
ylabel('<{\it S_x}>')
ylim([-1.05 1.05])
legend('neutrons','{^3}He');
title('<S_x> expectation value vs. time');
grid;

subplot('Position',[ 1/16 0.075 11/32 1/3-0.1]);
plot(time.t*10^3,ones(1,length(time.t))-s_3He_dot_s_n)
ylabel('Signal (1-<\sigma_3\cdot\sigma_n>)')
xlabel('Time (ms)');
grid;
title('Signal (1-<\sigma_3\cdot\sigma_n>) vs. time');


xrg = [0.4*time.t(length(time.t))*10^3 0.6*time.t(length(time.t))*10^3];
subplot('Position',[ 1/2 1/2+0.075 7/16 1/2-0.125]);
plot(time.tdbld*10^3,brf);
%plot(time.t,[ones(1,length(time.t))-s_3He_dot_s_n; ...
%    abs(scinfft(ind))*cos(2*pi*brfparams.modulation_freq*time.t + ...
%    angle(scinfft(ind))) ; ...
%    abs(scinfft(2*ind))*cos(2*pi*2*brfparams.modulation_freq*time.t + ...
%    angle(scinfft(2*ind))) ] );
xlim(xrg);
ylabel('{\it B_{RF}} (G)')
grid;
xlabel('Time (ms)');
title('Dressing field vs. time (zoomed)');

subplot('Position',[ 1/2 0.075 7/16 1/2-0.125]);
plot(time.t*10^3,ones(1,length(time.t))-s_3He_dot_s_n);
%plot(time.t,[ones(1,length(time.t))-s_3He_dot_s_n; ...
%    abs(scinfft(ind))*cos(2*pi*brfparams.modulation_freq*time.t + ...
%    angle(scinfft(ind))) ; ...
%    abs(scinfft(2*ind))*cos(2*pi*2*brfparams.modulation_freq*time.t + ...
%    angle(scinfft(2*ind))) ] );
xlim(xrg);
ylabel('Signal (1-<\sigma_3\cdot\sigma_n>)')
grid;
xlabel('Time (ms)');
title('Signal (1-<\sigma_3\cdot\sigma_n>) vs. time (zoomed)');


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
checkLabels = {'Save <SnS3> to variable:' ...
               'Save signal to variable:'}; 
varNames = {'sndots3','signal'};
sndots3.time = handles.evolution.time_axis.t;
sndots3.product = handles.s_3He_dot_s_n;
items = {sndots3, handles.signal};
export2wsdlg(checkLabels,varNames,items,'Save data to Workspace');

% --------------------------------------------------------------------
function FileClose_Callback(hObject, eventdata, handles)
% hObject    handle to FileClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)

% --- Executes on button press in button_.
function button__Callback(hObject, eventdata, handles)
% hObject    handle to button_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.txt_status,'String','Calculating Signal ...');
drawnow;

handles.fillmeasparams = getappdata(0,'nEDMpref_measfill');

% Measurement/fill time parameters:
tmeas = handles.fillmeasparams.MeasureTime;
tfill = handles.fillmeasparams.FillTime;
eps_b = handles.fillmeasparams.eps_b;
eps_3 = handles.fillmeasparams.eps_3;
tau_b = handles.fillmeasparams.tau_b;
tau_3 = handles.fillmeasparams.tau_3;
tau_cell = handles.fillmeasparams.tau_cell;

% Full decay rate:
gamt = 1/tau_b + 1/tau_3 + 1/tau_cell;
gamtmeas = 1/tau_b + 1/tau_3*(1-mean(handles.s_3He_dot_s_n)) + 1/tau_cell;

% UCN production parameters:
P_prod = .15;  % production in UCN/cc/sec
V_cell = 3750; % cell volume in cc
P_ucn = .9;    % UCN polarization
% Number of UCN:
N_ucn = P_prod*V_cell*(1 - exp(-gamt*tfill + tfill/tau_3))/(gamt - 1/tau_3);

% Non-beta background (rates in Hz)
% redfac = reduction factor
redfac = 0.;
R_mg = 38*redfac*(tfill/(tfill + tmeas + tau_3));
R_al = 76*redfac;
R_al_ave = R_al*(1-exp(-tmeas/195))*195/tmeas;
R_cosmic = 50*redfac;
bkg_rat = 10/N_ucn/(eps_b/tau_b + eps_3/tau_3);
bkg_ratf = 0;

% Other variables:
a = 1;
f = 0.3;
phi = 0;

% Here's my interpretation of what happens next:
%  1) We say that there are a maximum of one million events (events being
%  collisions between helium-3 and neutrons.)
%  2) We estabilish a vector, tbin, which will makes the time bins that we
%  use in the analysis.
%  3) dndt_max is the maximum size of the signal (when the cosine function
%  is equal to -1)
%  4) We establish a random set of times for the million or so events in
%  the vector variable "ti"
%  5) We know that there is a certain probability that each collision event
%  will produce a scintilation signal that we can detect, this is just what
%  is contained in the variable dndt.
%  6) For each event, we give also assign it a random number between 0 and 
%  dndt_max and store than number in the variable "ti_test".  If the random
%  number assigned is less than dndt (which is merely the probability that 
%  the event occured), we say that the event resulted in a scintillation 
%  photon that we have detected.  We then copy that to a new variable, 
%  "ti_ok" which contains the times of the events that we detected.  We
%  then bin those events and fit them (although in this version, we just
%  plot them up).

events = 2e6;
tbin = 0:0.03:tmeas;
% dndt(1:length(tbin)) = 0.0; %MATLAB doesn't require this...
dndt_max = bkg_rat*(eps_b/tau_b + eps_3/tau_3) + eps_b/tau_b + 2*eps_3/tau_3;
ti = tmeas*rand(1,events);
ti_test = dndt_max*rand(1,events);
dndt = bkg_rat*(eps_b/tau_b + eps_3/tau_3) + ...
    exp(-gamtmeas*ti).*(eps_b/tau_b + eps_3*(1 - ...
    interp1(handles.evolution.time_axis.t,handles.s_3He_dot_s_n,ti))/tau_3);

% Replacement for the COPY function, since MATLAB doesn't have such a
% function (to my knowledge):
kk = 1;
ti_ok(1:sum(ti_test<dndt)) = 0.0;
for jj = 1:events
    if ti_test(jj)<dndt(jj)
        ti_ok(kk) = ti(jj);
        kk = kk+1;
    end
end

% MATLAB's binning function:
counts = histc(ti_ok,tbin);

% Shift the time index to the center of the bin and then eliminate the last
% entry (which should always be zero):
tbin2 = tbin+0.015;
tbin2(length(tbin2)) = [];
counts2 = counts(1:length(counts)-1);

% Rewrite the variables with the new ones:
tbin = tbin2;
counts = counts2;

% Plot it up (we will eventually fit):
plot(handles.axes_sim_sig,tbin,counts);
grid(handles.axes_sim_sig);

tdbld = handles.evolution.time_axis.tdbld;
[brf FirstHarmonic SecondHarmonic]  = makebrf(tdbld,handles.fieldpref.brfparams);

FirstHarmonicLockIn = counts.*interp1(tdbld,FirstHarmonic,tbin);
SecondHarmonicLockIn = counts.*interp1(tdbld,SecondHarmonic,tbin);

plot(handles.axes_proc_sig,tbin,[FirstHarmonicLockIn; SecondHarmonicLockIn]);
grid(handles.axes_proc_sig);

handles.signal.time = tbin;
handles.signal.RawSignal = counts;
handles.signal.FirstHarmonicLockIn = FirstHarmonicLockIn;
handles.signal.SecondHarmonicLockIn = SecondHarmonicLockIn;

guidata(hObject,handles);

set(handles.txt_status,'String','Waiting...');
drawnow;

% --------------------------------------------------------------------
function EditMenu_Callback(hObject, eventdata, handles)
% hObject    handle to EditMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function EditSpin_Callback(hObject, eventdata, handles)
% hObject    handle to EditSpin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nEDMpref_sim;

% --------------------------------------------------------------------
function EditFields_Callback(hObject, eventdata, handles)
% hObject    handle to EditFields (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nEDMpref_fields;

% --------------------------------------------------------------------
function EditMeasFill_Callback(hObject, eventdata, handles)
% hObject    handle to EditMeasFill (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nEDMpref_measfill;