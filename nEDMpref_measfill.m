function varargout = nEDMpref_measfill(varargin)
% NEDMPREF_MEASFILL M-file for nEDMpref_measfill.fig
%      NEDMPREF_MEASFILL, by itself, creates a new NEDMPREF_MEASFILL or raises the existing
%      singleton*.
%
%      H = NEDMPREF_MEASFILL returns the handle to a new NEDMPREF_MEASFILL or the handle to
%      the existing singleton*.
%
%      NEDMPREF_MEASFILL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEDMPREF_MEASFILL.M with the given input arguments.
%
%      NEDMPREF_MEASFILL('Property','Value',...) creates a new NEDMPREF_MEASFILL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nEDMpref_measfill_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nEDMpref_measfill_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nEDMpref_measfill

% Last Modified by GUIDE v2.5 28-Jan-2010 12:28:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nEDMpref_measfill_OpeningFcn, ...
                   'gui_OutputFcn',  @nEDMpref_measfill_OutputFcn, ...
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


% --- Executes just before nEDMpref_measfill is made visible.
function nEDMpref_measfill_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nEDMpref_measfill (see VARARGIN)

% Choose default command line output for nEDMpref_measfill
handles.output = hObject;

handles.fillmeasparams = getappdata(0,'nEDMpref_measfill');

% Update the display:
set(handles.edit_meastime,'String',num2str(handles.fillmeasparams.MeasureTime));
set(handles.edit_filltime,'String',num2str(handles.fillmeasparams.FillTime));
set(handles.edit_epsilonb,'String',num2str(handles.fillmeasparams.eps_b));
set(handles.edit_epsilonhe3,'String',num2str(handles.fillmeasparams.eps_3));
set(handles.edit_taubeta,'String',num2str(handles.fillmeasparams.tau_b));
set(handles.edit_tau3,'String',num2str(handles.fillmeasparams.tau_3));
set(handles.edit_taucell,'String',num2str(handles.fillmeasparams.tau_cell));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nEDMpref_measfill wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nEDMpref_measfill_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_filltime_Callback(hObject, eventdata, handles)
% hObject    handle to edit_filltime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_filltime as text
%        str2double(get(hObject,'String')) returns contents of edit_filltime as a double
handles.fillmeasparams.FillTime = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_filltime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_filltime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_meastime_Callback(hObject, eventdata, handles)
% hObject    handle to edit_meastime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_meastime as text
%        str2double(get(hObject,'String')) returns contents of edit_meastime as a double
handles.fillmeasparams.MeasureTime = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_meastime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_meastime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_epsilonb_Callback(hObject, eventdata, handles)
% hObject    handle to edit_epsilonb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_epsilonb as text
%        str2double(get(hObject,'String')) returns contents of edit_epsilonb as a double
handles.fillmeasparams.eps_b = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_epsilonb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_epsilonb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_epsilonhe3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_epsilonhe3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_epsilonhe3 as text
%        str2double(get(hObject,'String')) returns contents of edit_epsilonhe3 as a double
handles.fillmeasparams.eps_3 = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_epsilonhe3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_epsilonhe3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_taubeta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_taubeta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_taubeta as text
%        str2double(get(hObject,'String')) returns contents of edit_taubeta as a double
handles.fillmeasparams.tau_b = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_taubeta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_taubeta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tau3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tau3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tau3 as text
%        str2double(get(hObject,'String')) returns contents of edit_tau3 as a double
handles.fillmeasparams.tau_3 = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_tau3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tau3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_taucell_Callback(hObject, eventdata, handles)
% hObject    handle to edit_taucell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_taucell as text
%        str2double(get(hObject,'String')) returns contents of edit_taucell as a double
handles.fillmeasparams.tau_cell = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_taucell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_taucell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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
setappdata(0,'nEDMpref_measfill',handles.fillmeasparams);

% --- Executes on button press in button_ok.
function button_ok_Callback(hObject, eventdata, handles)
% hObject    handle to button_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'nEDMpref_measfill',handles.fillmeasparams);
close;