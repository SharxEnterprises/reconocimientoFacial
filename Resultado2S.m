function varargout = Resultado2S(varargin)
% RESULTADO2S MATLAB code for Resultado2S.fig
%      RESULTADO2S, by itself, creates a new RESULTADO2S or raises the existing
%      singleton*.
%
%      H = RESULTADO2S returns the handle to a new RESULTADO2S or the handle to
%      the existing singleton*.
%
%      RESULTADO2S('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESULTADO2S.M with the given input arguments.
%
%      RESULTADO2S('Property','Value',...) creates a new RESULTADO2S or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Resultado2S_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Resultado2S_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Resultado2S

% Last Modified by GUIDE v2.5 08-May-2019 15:48:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Resultado2S_OpeningFcn, ...
                   'gui_OutputFcn',  @Resultado2S_OutputFcn, ...
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


% --- Executes just before Resultado2S is made visible.
function Resultado2S_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Resultado2S (see VARARGIN)

% Choose default command line output for Resultado2S
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Resultado2S wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Resultado2S_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Resultado2S);
%Interfaz1
