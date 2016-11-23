function varargout = nEDMpref_sim(varargin)
% NEDMPREF_SIM M-file for nEDMpref_sim.fig
%      NEDMPREF_SIM, by itself, creates a new NEDMPREF_SIM or raises the existing
%      singleton*.
%
%      H = NEDMPREF_SIM returns the handle to a new NEDMPREF_SIM or the handle to
%      the existing singleton*.
%
%      NEDMPREF_SIM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEDMPREF_SIM.M with the given input arguments.
%
%      NEDMPREF_SIM('Property','Value',...) creates a new NEDMPREF_SIM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nEDMpref_sim_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nEDMpref_sim_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nEDMpref_sim

% Last Modified by GUIDE v2.5 01-Nov-2009 20:43:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nEDMpref_sim_OpeningFcn, ...
                   'gui_OutputFcn',  @nEDMpref_sim_OutputFcn, ...
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


% --- Executes just before nEDMpref_sim is made visible.
function nEDMpref_sim_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nEDMpref_sim (see VARARGIN)

% Choose default command line output for nEDMpref_sim
handles.output = hObject;

handles.evolution = getappdata(0,'nEDMpref_evolution');

set(handles.edit_sim_time,'String',num2str(handles.evolution.T));
set(handles.edit_time_int,'String',num2str(handles.evolution.spacing));
set(handles.edit_num_of_pts,'String',num2str(handles.evolution.num_of_pts));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nEDMpref_sim wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nEDMpref_sim_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in button_cancel.
function button_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to button_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;

% --- Executes on button press in button_apply.
function button_apply_Callback(hObject, eventdata, handles)
% hObject    handle to button_apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.evolution.time_axis.t = 0:handles.evolution.spacing:handles.evolution.T;
handles.evolution.time_axis.tdbld = 0:handles.evolution.spacing/2:handles.evolution.T;
setappdata(0,'nEDMpref_evolution',handles.evolution);

% --- Executes on button press in button_ok.
function button_ok_Callback(hObject, eventdata, handles)
% hObject    handle to button_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.evolution.time_axis.t = 0:handles.evolution.spacing:handles.evolution.T;
handles.evolution.time_axis.tdbld = 0:handles.evolution.spacing/2:handles.evolution.T;
setappdata(0,'nEDMpref_evolution',handles.evolution);
close;


function edit_sim_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sim_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sim_time as text
%        str2double(get(hObject,'String')) returns contents of edit_sim_time as a double
handles.evolution.T = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_sim_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sim_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_num_of_pts_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num_of_pts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num_of_pts as text
%        str2double(get(hObject,'String')) returns contents of edit_num_of_pts as a double


% --- Executes during object creation, after setting all properties.
function edit_num_of_pts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num_of_pts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_time_int_Callback(hObject, eventdata, handles)
% hObject    handle to edit_time_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_time_int as text
%        str2double(get(hObject,'String')) returns contents of edit_time_int as a double
handles.evolution.spacing = str2double(get(hObject,'String'));
handles.evolution.num_of_pts = handles.evolution.T/handles.evolution.spacing;
set(handles.edit_num_of_pts,'String',num2str(handles.evolution.num_of_pts));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_time_int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_time_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
