function varargout = nEDMpref_fields(varargin)
% NEDMPREF_FIELDS M-file for nEDMpref_fields.fig
%      NEDMPREF_FIELDS, by itself, creates a new NEDMPREF_FIELDS or raises the existing
%      singleton*.
%
%      H = NEDMPREF_FIELDS returns the handle to a new NEDMPREF_FIELDS or the handle to
%      the existing singleton*.
%
%      NEDMPREF_FIELDS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEDMPREF_FIELDS.M with the given input arguments.
%
%      NEDMPREF_FIELDS('Property','Value',...) creates a new NEDMPREF_FIELDS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nEDMpref_fields_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nEDMpref_fields_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nEDMpref_fields

% Last Modified by GUIDE v2.5 01-Nov-2009 20:58:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nEDMpref_fields_OpeningFcn, ...
                   'gui_OutputFcn',  @nEDMpref_fields_OutputFcn, ...
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


% --- Executes just before nEDMpref_fields is made visible.
function nEDMpref_fields_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nEDMpref_fields (see VARARGIN)

% Choose default command line output for nEDMpref_fields
handles.output = hObject;

handles.fieldpref = getappdata(0,'nEDMpref_fields');

set(handles.edit_static_field,'String',num2str(handles.fieldpref.static_field));
set(handles.edit_fdress,'String',num2str(handles.fieldpref.brfparams.dressing_freq));
set(handles.edit_bdress,'String',num2str(handles.fieldpref.brfparams.static_value));
set(handles.edit_modfreq,'String',num2str(handles.fieldpref.brfparams.modulation_freq));
set(handles.edit_modamp,'String',num2str(handles.fieldpref.brfparams.modulation_amp));
if strcmp(handles.fieldpref.brfparams.modulation_type,'sine')
	set(handles.pm_modulation,'Value',1);
else
	set(handles.pm_modulation,'Value',2);
end

if strcmp(handles.fieldpref.brfparams.angle_fix,'yes');
	set(handles.pm_modulation,'Value',1);
else
	set(handles.pm_modulation,'Value',0);
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nEDMpref_fields wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nEDMpref_fields_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_bdress_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bdress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bdress as text
%        str2double(get(hObject,'String')) returns contents of edit_bdress as a double
handles.fieldpref.brfparams.static_value = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_bdress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bdress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fdress_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fdress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fdress as text
%        str2double(get(hObject,'String')) returns contents of edit_fdress as a double
handles.fieldpref.brfparams.dressing_freq = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_fdress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fdress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_modamp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_modamp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_modamp as text
%        str2double(get(hObject,'String')) returns contents of edit_modamp as a double
handles.fieldpref.brfparams.modulation_amp = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_modamp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_modamp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_modfreq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_modfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_modfreq as text
%        str2double(get(hObject,'String')) returns contents of edit_modfreq as a double
handles.fieldpref.brfparams.modulation_freq = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_modfreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_modfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_modulation.
function pm_modulation_Callback(hObject, eventdata, handles)
% hObject    handle to pm_modulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pm_modulation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_modulation


% --- Executes during object creation, after setting all properties.
function pm_modulation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_modulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cb_angle_fix.
function cb_angle_fix_Callback(hObject, eventdata, handles)
% hObject    handle to cb_angle_fix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_angle_fix
switch get(hObject,'Value')
    case 1
        handles.fieldpref.brfparams.angle_fix = 'yes';
    case 0
        handles.fieldpref.brfparams.angle_fix = 'no';
end
guidata(hObject,handles);


function edit_static_field_Callback(hObject, eventdata, handles)
% hObject    handle to edit_static_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_static_field as text
%        str2double(get(hObject,'String')) returns contents of edit_static_field as a double
handles.fieldpref.static_field = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_static_field_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_static_field (see GCBO)
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
setappdata(0,'nEDMpref_fields',handles.fieldpref);

% --- Executes on button press in button_ok.
function button_ok_Callback(hObject, eventdata, handles)
% hObject    handle to button_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'nEDMpref_fields',handles.fieldpref);
close;