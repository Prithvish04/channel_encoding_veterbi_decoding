function varargout = gui1(varargin)
% GUI1 MATLAB code for gui1.fig
%      GUI1, by itself, creates a new GUI1 or raises the existing
%      singleton*.
%
%      H = GUI1 returns the handle to a new GUI1 or the handle to
%      the existing singleton*.
%
%      GUI1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI1.M with the given input arguments.
%
%      GUI1('Property','Value',...) creates a new GUI1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui1

% Last Modified by GUIDE v2.5 26-Oct-2015 12:56:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui1_OpeningFcn, ...
                   'gui_OutputFcn',  @gui1_OutputFcn, ...
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


% --- Executes just before gui1 is made visible.
function gui1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui1 (see VARARGIN)

% Choose default command line output for gui1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in encode.
function encode_Callback(hObject, eventdata, handles)
% hObject    handle to encode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global encoded
set(handles.edit_encoded,'string',num2str(encoded));

% --- Executes on button press in decode.
function decode_Callback(hObject, eventdata, handles)
% hObject    handle to decode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global decodedOutput
set(handles.edit_decoded,'string',num2str(decodedOutput));



function edit_info_Callback(hObject, eventdata, handles)
% hObject    handle to edit_info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_info as text
%        str2double(get(hObject,'String')) returns contents of edit_info as a double
%%%% convolutional encoding %%%%
global encoded
msg=str2num(get(hObject,'String'));
r=2;
K=3;
m=K-1; %memory
msg=[zeros(1,m),msg];
encoded=[];
g=[1 1 1;0 1 1];
% g1=[1 1 1];
% g1=fliplr(g1);
% g=[g;g1];
% g2=[1 1 0];
% g2=fliplr(g2);
% g=[g;g2];
% for i=1:r
%     q=input('Enter the generator polynomial of size same as the window size = ');
%     q=fliplr(q);
%     g=[g;q];
% end
for i=1:length(msg)-2
    for j=1:r
        k=msg(i:i+2).*g(j,:);
        for l=1:2
            k(1)=xor(k(1),k(1+l));
            n=k(1);
        end
        encoded=[encoded,n];
    end
end
encoded

% --- Executes during object creation, after setting all properties.
function edit_info_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_encoded_Callback(hObject, eventdata, handles)
% hObject    handle to edit_encoded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_encoded as text
%        str2double(get(hObject,'String')) returns contents of edit_encoded as a double


% --- Executes during object creation, after setting all properties.
function edit_encoded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_encoded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_received_Callback(hObject, eventdata, handles)
% hObject    handle to edit_received (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_received as text
%        str2double(get(hObject,'String')) returns contents of edit_received as a double
global decodedOutput
r_bits=str2num(get(hObject,'String'));
l=length(r_bits);
if(mod(l,2)==0)
y0=r_bits(1:2:l)
y1=r_bits(2:2:l)

%4 states = 00 01 10 11
dist(1,1)=0;
dist(2,1)=Inf;
dist(3,1)=Inf;
dist(4,1)=Inf;

for i=1:(l/2)
        %calculating branch metric
            metric(1,i)=abs(y0(i)-0)+abs(y1(i)-0);  %branch metric for transition from state 00 to 00
            metric(2,i)=abs(y0(i)-1)+abs(y1(i)-1);    %branch metric for transition from state 00 to 10
            metric(3,i)=abs(y0(i)-1)+abs(y1(i)-1);    %branch metric for transition from state 10 to 01    
            metric(4,i)=abs(y0(i)-0)+abs(y1(i)-0);    %branch metric for transition from state 10 to 11
            metric(5,i)=abs(y0(i)-1)+abs(y1(i)-0);    %branch metric for transition from state 01 to 00
            metric(6,i)=abs(y0(i)-0)+abs(y1(i)-1);    %branch metric for transition from state 01 to 10
            metric(7,i)=abs(y0(i)-0)+abs(y1(i)-1);    %branch metric for transition from state 11 to 01
            metric(8,i)=abs(y0(i)-1)+abs(y1(i)-0);    %branch metric for transition from state 11 to 11
  
            %calculating path metric
            dist(1,i+1)=min(dist(1,i)+metric(1,i),dist(3,i)+metric(5,i));%Min dist to reach state 00 at time i
            dist(2,i+1)=min(dist(1,i)+metric(2,i),dist(3,i)+metric(6,i));%Min dist to reach state 10 at time i
            dist(3,i+1)=min(dist(2,i)+metric(3,i),dist(4,i)+metric(7,i));%Min dist to reach state 01 at time i
            dist(4,i+1)=min(dist(2,i)+metric(4,i),dist(4,i)+metric(8,i))%Min dist to reach state 11 at time i     
        end
    
[~,state]=min(dist(:,l/2+1)); %For the last stage choosing the state corresponding to minimum distance
%Starting from the last stage, we decode the previous state and the corresponding input bit
        for j=l/2:-1:1
            [state,decodedBit]=prev_stage(state,dist(:,j));
            decodedOutput(j)=decodedBit(:); %Storing the decoded bits in a vector
        end
        decodedOutput
else
    disp('Bits missing!');
end

% --- Executes during object creation, after setting all properties.
function edit_received_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_received (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_decoded_Callback(hObject, eventdata, handles)
% hObject    handle to edit_decoded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_decoded as text
%        str2double(get(hObject,'String')) returns contents of edit_decoded as a double


% --- Executes during object creation, after setting all properties.
function edit_decoded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_decoded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
