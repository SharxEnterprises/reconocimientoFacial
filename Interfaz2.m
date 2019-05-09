function varargout = Interfaz2(varargin)
% INTERFAZ2 MATLAB code for Interfaz2.fig
%      INTERFAZ2, by itself, creates a new INTERFAZ2 or raises the existing
%      singleton*.
%
%      H = INTERFAZ2 returns the handle to a new INTERFAZ2 or the handle to
%      the existing singleton*.
%
%      INTERFAZ2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFAZ2.M with the given input arguments.
%
%      INTERFAZ2('Property','Value',...) creates a new INTERFAZ2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Interfaz2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Interfaz2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Interfaz2

% Last Modified by GUIDE v2.5 05-May-2019 02:32:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interfaz2_OpeningFcn, ...
                   'gui_OutputFcn',  @Interfaz2_OutputFcn, ...
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


% --- Executes just before Interfaz2 is made visible.
function Interfaz2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Interfaz2 (see VARARGIN)

% Choose default command line output for Interfaz2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Interfaz2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Interfaz2_OutputFcn(hObject, eventdata, handles) 
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
global work_area
global BBOX

	folder='\Users\Joshua37\Documents\QUINTO CICLO\METODOS\PROYECTO FINAL\Aca esta el PROYECTASO FINAL\SharxBank';
	nombre=get(handles.edit1,'String');
    if isempty(nombre)
    msj=questdlg('Ingrese Nombre de Usuario','Mensaje','OK','OK');%mensaje 
        if strcmp(msj,'OK')%%compara cadenas ok ok
        return;
        end
    end 
    nombre=char(nombre);
    name=strcat(nombre,'.jpg')
    imwrite(work_area,fullfile(folder,name));
    msj=questdlg('Se guardo Exitosamente...','Mensaje','Ok','Ok');
close(Interfaz2);
Interfaz1;



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid

set(handles.axes8,'visible','on');
axes(handles.axes8);
vid=videoinput('winvideo',1);
vid.ReturnedColorSpace='rgb';
vidRes = get(vid, 'VideoResolution');
nBands = get(vid, 'NumberOfBands');
hImage = image( zeros(vidRes(2), vidRes(1), nBands) );
preview(vid, hImage);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid
global work_area

set(handles.axes3,'Visible','on');%pantalla
    set(handles.pushbutton1,'Visible','on');%boton
    set(handles.edit1,'Visible','on');%box
    set(handles.text5,'Visible','on');%string
    foto=getsnapshot(vid);
    imagen_gray=rgb2gray(foto);
    facedetector=vision.CascadeObjectDetector();%barrido de imagen
    BOX=step(facedetector,foto);%encuentra la cara
    recorte=imcrop(imagen_gray,BOX(1,:));
        work_area=imresize(recorte,[64 48]);
    axes(handles.axes3);
    imshow(foto)
    rectangle('position',BOX(1,:),'edgecolor','g','linewidth',2);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes8,'visible','off');
closepreview;
fondo=imread('Sharx.jpg');
axes(handles.axes8);
imshow(fondo);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Interfaz2);
Interfaz1
