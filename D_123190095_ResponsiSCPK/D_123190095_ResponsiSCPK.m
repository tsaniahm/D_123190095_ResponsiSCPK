function varargout = D_123190095_ResponsiSCPK(varargin)
% D_123190095_RESPONSISCPK MATLAB code for D_123190095_ResponsiSCPK.fig
%      D_123190095_RESPONSISCPK, by itself, creates a new D_123190095_RESPONSISCPK or raises the existing
%      singleton*.
%
%      H = D_123190095_RESPONSISCPK returns the handle to a new D_123190095_RESPONSISCPK or the handle to
%      the existing singleton*.
%
%      D_123190095_RESPONSISCPK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in D_123190095_RESPONSISCPK.M with the given input arguments.
%
%      D_123190095_RESPONSISCPK('Property','Value',...) creates a new D_123190095_RESPONSISCPK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before D_123190095_ResponsiSCPK_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to D_123190095_ResponsiSCPK_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help D_123190095_ResponsiSCPK

% Last Modified by GUIDE v2.5 25-Jun-2021 21:29:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @D_123190095_ResponsiSCPK_OpeningFcn, ...
                   'gui_OutputFcn',  @D_123190095_ResponsiSCPK_OutputFcn, ...
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


% --- Executes just before D_123190095_ResponsiSCPK is made visible.
function D_123190095_ResponsiSCPK_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to D_123190095_ResponsiSCPK (see VARARGIN)

% Choose default command line output for D_123190095_ResponsiSCPK

%dilakukan import dataset untuk nantinya ditampilkan di tabel tampilan awal
opts = detectImportOptions('DataRumah.xlsx');
opts.SelectedVariableNames = [1 3:8];
data = readmatrix('DataRumah.xlsx', opts);
y=data(1:20,:); format longG;

%memasukkan data ke dalam tabel pada GUI untuk ditampilkan
set(handles.uitable1,'Data',y);
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes D_123190095_ResponsiSCPK wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = D_123190095_ResponsiSCPK_OutputFcn(hObject, eventdata, handles) 
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
% handles    structure with handles and user data (see GUIDATA)SS

%Melakukan Import dataset dari file berekstensi .xlsx
opts = detectImportOptions('DataRumah.xlsx');
opts.SelectedVariableNames = [3:8];
data = readmatrix('DataRumah.xlsx', opts);

x=data(1:20,:); format longG; %data set berdasarkan kriteria 
k=[0,1,1,1,1,1];%nilai atribut tiap kriteria,dgn nilai 1 sebagai benefit & 0 sebagai cost
w=[0.3,0.2,0.23,0.10,0.07, 0.10];%nilai bobot masing-masing kriteria

%TAHAP PERTAMA, menormalisasikan matriks
[m n] = size(x);%matriks m x n dengan ukuran sebanyak variabel
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
Y=zeros (m,n); %membuat matriks Y, yang merupakan titik kosong
for j=1:n,
    if k(j)==1, %statement untuk kriteria dengan atribut keuntungan
        R(:,j)=x(:,j)./max(x(:,j));
    else
        R(:,j)=min(x(:,j))./x(:,j);
    end;
end;

%TAHAP KEDUA, proses perangkingan
for i=1:m,
V(i)= sum(w.*R(i,:));
end;

[sd,r]=sort(V,'descend');%proses pengurutan berdasarkan nilai vektor tertinggi
sd; %hasil vektor yang telah diurutkan
r;%index dari per nilai vektor yang telah diurutkan

%TAHAP KETIGA, proses memasukan hasil perankingan ke dalam tabel GUI
result1 = sd(:,1:20); %pengambilan 5 data hasil vektor teratas
result2 = r(:,1:20); %pengambilan 5 index dari data hasil vektor teratas
result3 = [1:20;result2;result1]; %membuat matriks untuk menampung hasil vektor 5 teratas beserta indexnya

%memasukkan data ke dalam tabel GUI untuk ditampilkan
set(handles.uitable2,'Data',(result3).' );
