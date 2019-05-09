function varargout = Interfaz1(varargin)
% INTERFAZ1 MATLAB code for Interfaz1.fig
%      INTERFAZ1, by itself, creates a new INTERFAZ1 or raises the existing
%      singleton*.
%
%      H = INTERFAZ1 returns the handle to a new INTERFAZ1 or the handle to
%      the existing singleton*.
%
%      INTERFAZ1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFAZ1.M with the given input arguments.
%
%      INTERFAZ1('Property','Value',...) creates a new INTERFAZ1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Interfaz1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Interfaz1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Interfaz1

% Last Modified by GUIDE v2.5 05-May-2019 21:29:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interfaz1_OpeningFcn, ...
                   'gui_OutputFcn',  @Interfaz1_OutputFcn, ...
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


% --- Executes just before Interfaz1 is made visible.
function Interfaz1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Interfaz1 (see VARARGIN)

% Choose default command line output for Interfaz1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Interfaz1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Interfaz1_OutputFcn(hObject, eventdata, handles) 
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
global BBOX

foto=imread('imagen_in.jpg');
    imagen_gray=rgb2gray(foto);
    facedetector=vision.CascadeObjectDetector();
    BBOX=step(facedetector,foto)
    recorte=imcrop(imagen_gray,BBOX(1,:));
    work_area=imresize(recorte,[64 48]);
    axes(handles.axes2);
    imshow(work_area);
    folder='C:\Users\Joshua37\Documents\QUINTO CICLO\METODOS\PROYECTO FINAL\Aca esta el PROYECTASO FINAL';
    imwrite(work_area,fullfile(folder,'area_trabajo.jpg'));

%aqui se viene lo chido...
input_dir='\Users\Joshua37\Documents\QUINTO CICLO\METODOS\PROYECTO FINAL\Aca esta el PROYECTASO FINAL\SharxBank';
image_dimensiones=[64,48];%se estandarizan medidas
filenames=dir(fullfile(input_dir,'*.jpg'));%lista y lee las imagenes que hay en la carpeta

%ELEMENTOS DE UNA MATRIZ Y DEFINIMOS LA MATRIZ
num_images=numel(filenames)		%retorna el numero de elementos de una matriz
images=[];				%crear matriz
%la matriz de la imagen se pasa a un vector
for n=1:num_images		%imagenes en la carpeta
	filename=fullfile(input_dir,filenames(n).name);%se selecciona la imagen
	img1=imread(filename);	%se lee la imagen
%img2=rgb2gray(img)
	img1=im2double(img1);	%doble precision reescalar los datos
	img=imresize(img1,[64 48]); %retorna una imagen que es scala veces el tamanio de recorte
	img=img(:,:,1);
%///////////////////////
	if n==1
		images=zeros(prod(image_dimensiones),num_images);%se establece el vector que contiene los valores
		end 
	images(:,n)=img(:);  %se guarda en un vector la imagen correspondiente
end

%hallamos el promedio de las imagenes******************************
mean_face=mean(images,2); 	%obtiene media o promedio de los vectores
rep=repmat(mean_face,1,num_images);	%devuelve un vector de n copias

%normalizamos******
normalizar=images-rep;	%sustrae la informacion mas importatne 

%hallamos la matriz de covarianza************
%calculamos los vectores propios de la matriz de covarianza**************
[evectors,~,~]=pca(images');%calcula los eigenvectors, score puntuacion de componentes prin.
num_eigenvectors=2;%se limita a 20 el numero de los eigenvectors
evectors=evectors(:,1:num_eigenvectors);

features=evectors'*normalizar;%se proyectan las imagenes dentro
%de un subespacio para generar (vectores caracteristicos)matriz de media 0

input_work=imread('area_trabajo.jpg');%input_work=imread9'area_trabajo.jpg');
input_work=imresize(input_work,[64 48]) ;%se adapta el area de trabajo con la que se va a trabajar
input_work=im2double(input_work);

%calcular la similaridadde la entrada con cada imagen de la carpeta***********
%en base a ala distancia euclidiana inversa***********************************

feature_vec=evectors'*(input_work(:)-mean_face);%vector caracteristico
similarity_score=arrayfun(@(n)1/(norm(features(:,n)-feature_vec)),1:num_images);
%encuentra la imagen con mayor similitud
[match_score,~]=max(similarity_score);%devuelve los elementos mas grandes de la matriz
%match_score=match_score/100
similarity_score*100
new_match = match_score*100

%condiciones para la imagen***************************************************
if new_match>=50 %mayor a 0.5
    %foto_gan=filenames(match_1x).name;
    %foto_win=imread(foto_gan);
    %foto_win=imresize(foto_win,image_dimensiones);
    %axes(handles.axes1);
    %imshow(foto_win);
    %---------------------------------------------
    Resultado2S

    %texto=sprintf('Rosotro Reconocido con Exito');
    %set(handles.text_score,'String',texto);
    %set(handles.text_score,'Visible','on');
    %de lo contrario
else
    
    Resultado1N
    %texto=sprintf('Rostro desconocido');
	%set(handles.text_score,'String',texto);
	%set(handles.text_score,'Visible','on'); 
    
end 


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Interfaz1);
Interfaz2

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid

set(handles.axes1,'visible','on');
axes(handles.axes1);
vid=videoinput('winvideo',1);
vid.ReturnedColorSpace='rgb';
vidRes = get(vid, 'VideoResolution');
nBands = get(vid, 'NumberOfBands');
hImage = image( zeros(vidRes(2), vidRes(1), nBands) );
preview(vid, hImage);



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid
global BBOX

set(handles.axes2,'Visible','on');%pantalla
    set(handles.pushbutton1,'Visible','on');%boton
    %set(handles.pushbutton5,'Visible','on');%boton
    foto=getsnapshot(vid);
    facedetector=vision.CascadeObjectDetector();%barrido de imagen
    BBOX=step(facedetector,foto);%encuentra la cara
    axes(handles.axes2);
    imshow(foto)
    rectangle('position',BBOX(1,:),'edgecolor','r','linewidth',2);
    folder='\Users\Joshua37\Documents\QUINTO CICLO\METODOS\PROYECTO FINAL\Aca esta el PROYECTASO FINAL';
    imwrite(foto,fullfile(folder,'imagen_in.jpg'));


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes1,'visible','off');
closepreview;
fondo=imread('Sharx.jpg');
axes(handles.axes1);
imshow(fondo);
