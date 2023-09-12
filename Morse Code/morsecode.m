function varargout = morsecode(varargin)
% MORSECODE MATLAB code for morsecode.fig
%      MORSECODE, by itself, creates a new MORSECODE or raises the existing
%      singleton*.
%
%      H = MORSECODE returns the handle to a new MORSECODE or the handle to
%      the existing singleton*.
%
%      MORSECODE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MORSECODE.M with the given input arguments.
%
%      MORSECODE('Property','Value',...) creates a new MORSECODE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before morsecode_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to morsecode_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help morsecode

% Last Modified by GUIDE v2.5 12-Apr-2022 03:12:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @morsecode_OpeningFcn, ...
                   'gui_OutputFcn',  @morsecode_OutputFcn, ...
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


% --- Executes just before morsecode is made visible.
function morsecode_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to morsecode (see VARARGIN)

% Choose default command line output for morsecode
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes morsecode wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = morsecode_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

set(handles.playsound, 'visible', 'off');
global morse_code;

% --- Executes on button press in encode.
function encode_Callback(hObject, eventdata, handles)
% hObject    handle to encode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global morse_code;
set(handles.playsound, 'visible', 'on');
input_msg=get(handles.input_msg, 'string');
load translator.mat
input1=lower(input_msg);
len=length(input1);
set(handles.word_count, 'string', len);
breaker=0;

%regexp to check the input only contains dots, dashes, slash, spaces
expression = '^[\.\- \/]+$';
match=regexp(input1 , expression, 'match');

%if user enter stop, give option to close the program
switch input1
    case 'stop'
         breaker=1;
         choice=questdlg({'Do you wish to close the program?'; ...
            'Choose "Yes" to close the program '; ...
            'Choose "No" to continue.'}, ...
            'Close Program','Yes','No','Yes');       
         switch choice
             case 'No'               
                set(handles.input_msg, 'string', '');
                set(handles.word_count, 'string', '0');
                set(handles.output_msg,'string','');
             otherwise
                closereq;                
         end  
end

%if letter count >600
if len > 600
   breaker=1;
   choice=questdlg({'Letters exceed the limit! (Must be less than 600)'; 'Do you wish to type again? '; ...
        'Choose "Yes" to continue '; ...
        'Choose "No" if you want to stop the program.'}, ...
        'Limit Exceeded','Yes','No','Yes');       
    switch choice
        case 'No'                 
            closereq;                
        otherwise               
            set(handles.input_msg,'string','');
            set(handles.word_count, 'string', '0');
    end  
%if user did not type in any value
elseif isempty(input1)
    errordlg('Please enter something!', 'No Input!');
%if input contains only morse code characters
elseif ~isempty(match)
    choice=questdlg({'WARNING: No English characters detected. Do you want to try again?'; ...
            'Choose "Yes" to try again'; ...
            'Choose "No" to close the program.'}, ...
            'Invalid input','Yes','No','Yes');       
    switch choice
        case 'No'  
            breaker=1;
            closereq;  
        otherwise
            breaker=1;
            set(handles.output_msg,'string','');  
            set(handles.input_msg,'string','');
            set(handles.word_count, 'string', '0');                                 
    end  
end

%return when breaker is 1
if breaker == 1
    return
end

%create empty array
mor=[];
for i=1:len
    if input1(i)== ' '
        mor=[mor '/'];
    elseif isvarname(input1(i)) 
        mor=[mor getfield(morse, input1(i))];
        mor=[mor ' '];
    elseif ~isempty(str2num(input1(i)))
        mor=[mor getfield(morse, ['n' input1(i)])];
        mor=[mor ' '];
    elseif findstr(input1(i), morse.sc)
        mor=[mor char(morse.scv(findstr(input1(i), morse.sc)))];
        mor=[mor ' '];  
     end   
end
if breaker
    return 
end
set(handles.output_msg,'string', mor);
morse_code=mor;

% --- Executes on button press in playsound.
function playsound_Callback(hObject, eventdata, handles)
% hObject    handle to playsound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global morse_code;
global msou;
t=0:5000;
Dot=sin(t(1:700));
Dash=sin(t(1:2000));
ssp=zeros(1,2000);
lsp=zeros(1,4000);
msou=[];
clear sound;
text=morse_code;
for i=1:length(text)
    if strcmp(text(i), '.')
        msou=[msou Dot ssp];
    elseif strcmp(text(i), '-')
        msou=[msou Dash ssp];
    elseif strcmp(text(i), ' ')
        msou=[msou lsp];
    elseif strcmp(text(i), '/')
        msou=[msou lsp ssp];
    end
end
pp=audioplayer(msou, 11000);
play(pp);
pause(length(morse_code))

function input_msg_Callback(hObject, eventdata, handles)
% hObject    handle to input_msg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of input_msg as text
%        str2double(get(hObject,'String')) returns contents of input_msg as a double


% --- Executes during object creation, after setting all properties.
function input_msg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_msg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function output_msg_Callback(hObject, eventdata, handles)
% hObject    handle to output_msg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of output_msg as text
%        str2double(get(hObject,'String')) returns contents of output_msg as a double


% --- Executes during object creation, after setting all properties.
function output_msg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_msg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in decode.
function decode_Callback(hObject, eventdata, handles)
% hObject    handle to decode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global morse_code;
load translator.mat
m_code=get(handles.input_msg, 'string');
morse_code=m_code;
deco=[];
m_code=[m_code ' '];
lcode=[];
a=length(m_code);
set(handles.word_count, 'String', a);
breaker=0;

%if user enter .-.-.-, give option to close the program
switch morse_code
    case '.-.-.-'
        breaker=1;
        choice=questdlg({'Do you wish to close the program?'; ...
            'Choose "Yes" to close the program '; ...
            'Choose "No" to continue.'}, ...
            'Close Program','Yes','No','Yes');       
        switch choice
            case 'No'                 
                set(handles.input_msg,'string','');
                set(handles.word_count, 'string', '0');
                set(handles.output_msg,'string','');
            otherwise
                closereq;                
        end  
end

if a > 600
   breaker=1;
   choice=questdlg({'Letters exceed the limit! (Must be less than 600)'; 'Do you wish to type again? '; ...
        'Choose "Yes" to continue '; ...
        'Choose "No" if you want to stop the program.'}, ...
        'Invalid input','Yes','No','Yes');       
    switch choice
        case 'No'                 
            closereq;                
        otherwise
             set(handles.input_msg,'string','');
             set(handles.word_count, 'string', '0');
    end  
%if user did not type in any value
elseif isempty(morse_code)
    errordlg('Please enter something!', 'No Input!');
end

if breaker==1
    return
end

for j=1:length(m_code)
    if strcmp(m_code(j),' ') || strcmp(m_code(j),'/')
        for i=double('a'):double('z')
            letter=getfield(morse, char(i));
            if strcmp(lcode, letter)
                deco=[deco char(i)];
            end
        end
        for i=0:9
            numb=getfield(morse, ['n', num2str(i)]);
            if strcmp(lcode, numb)
                deco=[deco num2str(i)];
            end
        end
        for i=1:4
            scv=char(morse.scv(i));
            if strcmp(lcode, scv)
                deco=[deco morse.sc(i)];
            end
        end 
        lcode=[];
    elseif ~strcmp(m_code(j), '.') && ~strcmp(m_code(j), '-')
        breaker=1;
        choice=questdlg({'This is not a valid Morse Code '; ...
            'Choose "Yes" to continue '; ...
            'Choose "No" to close the program.'}, ...
            'Invalid input','Yes','No','Yes');       
        switch choice
            case 'No'                 
                closereq;  
            otherwise
                set(handles.input_msg,'string','');
                set(handles.word_count, 'string', '0');
                set(handles.output_msg,'string','');                           
        end  
        break
     else
        lcode=[lcode m_code(j)];
    end
    if strcmp(m_code(j), '/')
        deco=[deco ' '];
    end
end
if breaker
    return
end
set(handles.output_msg,'string', deco);


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uigetfile

% --------------------------------------------------------------------
function edit_Callback(hObject, eventdata, handles)
% hObject    handle to edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
notes={'To produce an output: ';
         'a) Input should not exceed 200 letters,'; ...
         'b) You can include letters [A to Z], numbers[0 to 9],';...
         'c) To translate from English to Morse code, press encode pushbutton,'; ...
         'd) To translate from Morse code to English, press decode pushbutton. '};
helpdlg(notes,'About');

% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uigetfile

% -------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uigetfile

% --------------------------------------------------------------------
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function close_prog_Callback(hObject, eventdata, handles)
% hObject    handle to close_prog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice=questdlg('Do you wish to close this program? Current data will not be saved.',...
                'Close program',...
                'Yes','No','No');
switch choice
    case 'No' 
       return;
    otherwise
        close;
end 

% --------------------------------------------------------------------
function font_Callback(hObject, eventdata, handles)
% hObject    handle to font (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function font_color_Callback(hObject, eventdata, handles)
% hObject    handle to font_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function font_size_Callback(hObject, eventdata, handles)
% hObject    handle to font_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function bkgrd_col_Callback(hObject, eventdata, handles)
% hObject    handle to bkgrd_col (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function print_Callback(hObject, eventdata, handles)
% hObject    handle to print (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg

% --------------------------------------------------------------------
function export_Callback(hObject, eventdata, handles)
% hObject    handle to export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file path] = uiputfile('*.pdf');
print([path file], '-dpdf');

% --------------------------------------------------------------------
function restore_1_Callback(hObject, eventdata, handles)
% hObject    handle to restore_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice=questdlg('Do you want to restore the program back to default?',...
                'Reset program',...
                'Yes','No','No');
switch choice
    case 'Yes' 
        set(gcf,'Color',[0.97 0.93 0.84]);
        set(handles.input_msg,'string','');          
        set(handles.output_msg,'String','');
        set(handles.word_count,'string','');
        set(handles.text6,'backgroundcolor',[0.97 0.93 0.84]);
        set(handles.text3,'backgroundcolor',[0.97 0.93 0.84]);
        set(handles.text4,'backgroundcolor',[0.97 0.93 0.84]);
        set(handles.text5,'backgroundcolor',[0.97 0.93 0.84]);
        set(handles.word_count,'backgroundcolor',[0.97 0.93 0.84]);
        set(handles.text3,'String','Morse Code Translator');
        set(handles.text3,'ForegroundColor',[0 0 0]);
        drawnow();
        set(handles.text4,'String','Input (English/Morse Code):');
        set(handles.text4,'ForegroundColor',[0 0 0]);
        drawnow();
        set(handles.text6,'String','Word Count: ');
        set(handles.text6,'ForegroundColor',[0 0 0]);
        drawnow();
        set(handles.word_count,'String','0');
        set(handles.word_count,'ForegroundColor',[0 0 0]);
        drawnow();
        set(handles.text5,'String','Output:');
        set(handles.text5,'ForegroundColor',[0 0 0]);
        drawnow();
        set(handles.text3,'String','Morse Code Translator');
        set(handles.text3,'FontSize',15);
        drawnow();
        set(handles.text4,'String','Input (English/Morse Code):');
        set(handles.text4,'FontSize',10);
        drawnow();
        set(handles.text6,'String','Word Count:');
        set(handles.text6,'FontSize',10);
        drawnow();
        set(handles.word_count,'String','0');
        set(handles.word_count,'FontSize',10);
        drawnow();
        set(handles.text5,'String','Output:');
        set(handles.text5,'FontSize',10);
        drawnow();
    otherwise
        return;
end   

% --------------------------------------------------------------------
function beige_Callback(hObject, eventdata, handles)
% hObject    handle to beige (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [0.97 0.93 0.84] )
set(handles.text3,'backgroundcolor',[0.97 0.93 0.84]);
set(handles.text4,'backgroundcolor',[0.97 0.93 0.84]);
set(handles.text5,'backgroundcolor',[0.97 0.93 0.84]);
set(handles.text6,'backgroundcolor',[0.97 0.93 0.84]);
set(handles.word_count,'backgroundcolor',[0.97 0.93 0.84]);

% --------------------------------------------------------------------
function grey_Callback(hObject, eventdata, handles)
% hObject    handle to grey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(gcf,'Color',[0.941 0.941 0.941]);
set(handles.text3,'backgroundcolor',[0.941 0.941 0.941]);
set(handles.text4,'backgroundcolor',[0.941 0.941 0.941]);
set(handles.text5,'backgroundcolor',[0.941 0.941 0.941]);
set(handles.text6,'backgroundcolor',[0.941 0.941 0.941]);
set(handles.word_count,'backgroundcolor',[0.941 0.941 0.941]);

% --------------------------------------------------------------------
function purple_Callback(hObject, eventdata, handles)
% hObject    handle to purple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [0.4940, 0.1840, 0.5560] )
set(handles.text3,'backgroundcolor',[0.4940, 0.1840, 0.5560] );
set(handles.text4,'backgroundcolor',[0.4940, 0.1840, 0.5560] );
set(handles.text5,'backgroundcolor',[0.4940, 0.1840, 0.5560] );
set(handles.text6,'backgroundcolor',[0.4940, 0.1840, 0.5560] );
set(handles.word_count,'backgroundcolor',[0.4940, 0.1840, 0.5560] );
set(handles.text3,'String','Morse Code Translator');
set(handles.text3,'ForegroundColor','w');
drawnow();
set(handles.text4,'String','Input (English/Morse Code):');
set(handles.text4,'ForegroundColor','w');
drawnow();
set(handles.text6,'String','Word Count:');
set(handles.text6,'ForegroundColor','w');
drawnow();
set(handles.word_count, 'String','0');
set(handles.word_count,'ForegroundColor','w');
drawnow();
set(handles.text5,'String','Output:');
set(handles.word_count,'ForegroundColor','w');
drawnow();
% --------------------------------------------------------------------
function blue_Callback(hObject, eventdata, handles)
% hObject    handle to blue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [0 0.4470 0.7410] )
set(handles.text3,'backgroundcolor',[0 0.4470 0.7410]);
set(handles.text4,'backgroundcolor',[0 0.4470 0.7410]);
set(handles.text5,'backgroundcolor',[0 0.4470 0.7410]);
set(handles.text6,'backgroundcolor',[0 0.4470 0.7410]);
set(handles.word_count,'backgroundcolor',[0 0.4470 0.7410]);

% --------------------------------------------------------------------
function yellow_Callback(hObject, eventdata, handles)
% hObject    handle to yellow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [0.9290, 0.6940, 0.1250] )
set(handles.text3,'backgroundcolor',[0.9290, 0.6940, 0.1250]);
set(handles.text4,'backgroundcolor',[0.9290, 0.6940, 0.1250]);
set(handles.text5,'backgroundcolor',[0.9290, 0.6940, 0.1250]);
set(handles.text6,'backgroundcolor',[0.9290, 0.6940, 0.1250]);
set(handles.word_count,'backgroundcolor',[0.9290, 0.6940, 0.1250]);

% --------------------------------------------------------------------
function green_Callback(hObject, eventdata, handles)
% hObject    handle to green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [0.4660, 0.6740, 0.1880] )
set(handles.text3,'backgroundcolor',[0.4660, 0.6740, 0.1880]);
set(handles.text4,'backgroundcolor',[0.4660, 0.6740, 0.1880]);
set(handles.text5,'backgroundcolor',[0.4660, 0.6740, 0.1880]);
set(handles.text6,'backgroundcolor',[0.4660, 0.6740, 0.1880]);
set(handles.word_count,'backgroundcolor',[0.4660, 0.6740, 0.1880]);

% --------------------------------------------------------------------
function black_f_Callback(hObject, eventdata, handles)
% hObject    handle to black_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text3,'String','Morse Code Translator');
set(handles.text3,'ForegroundColor',[0 0 0]);
drawnow();
set(handles.text4,'String','Input (English/Morse Code):');
set(handles.text4,'ForegroundColor',[0 0 0]);
drawnow();
set(handles.text6,'String','Word Count: ');
set(handles.text6,'ForegroundColor',[0 0 0]);
drawnow();
set(handles.word_count,'String','0');
set(handles.word_count,'ForegroundColor',[0 0 0]);
drawnow();
set(handles.text5,'String','Output:');
set(handles.text5,'ForegroundColor',[0 0 0]);
drawnow();

% --------------------------------------------------------------------
function green_f_Callback(hObject, eventdata, handles)
% hObject    handle to green_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text3,'String','Morse Code Translator');
set(handles.text3,'ForegroundColor',[0.4660, 0.6740, 0.1880]);
drawnow();
set(handles.text4,'String','Input (English/Morse Code):');
set(handles.text4,'ForegroundColor',[0.4660, 0.6740, 0.1880]);
drawnow();
set(handles.text6,'String','Word Count: ');
set(handles.text6,'ForegroundColor',[0.4660, 0.6740, 0.1880]);
drawnow();
set(handles.word_count,'String','0');
set(handles.word_count,'ForegroundColor',[0.4660, 0.6740, 0.1880]);
drawnow();
set(handles.text5,'String','Output:');
set(handles.text5,'ForegroundColor',[0.4660, 0.6740, 0.1880]);
drawnow();

% --------------------------------------------------------------------
function red_f_Callback(hObject, eventdata, handles)
% hObject    handle to red_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text3,'String','Morse Code Translator');
set(handles.text3,'ForegroundColor',[1 0 0]);
drawnow();
set(handles.text4,'String','Input (English/Morse Code):');
set(handles.text4,'ForegroundColor',[1 0 0]);
drawnow();
set(handles.text6,'String','Word Count: ');
set(handles.text6,'ForegroundColor',[1 0 0]);
drawnow();
set(handles.word_count,'String','0');
set(handles.word_count,'ForegroundColor',[1 0 0]);
drawnow();
set(handles.text5,'String','Output:');
set(handles.text5,'ForegroundColor',[1 0 0]);
drawnow();

% --------------------------------------------------------------------
function blue_f_Callback(hObject, eventdata, handles)
% hObject    handle to blue_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text3,'String','Morse Code Translator');
set(handles.text3,'ForegroundColor',[0 0.4470 0.7410]);
drawnow();
set(handles.text4,'String','Input (English/Morse Code):');
set(handles.text4,'ForegroundColor',[0 0.4470 0.7410]);
drawnow();
set(handles.text6,'String','Word Count: ');
set(handles.text6,'ForegroundColor',[0 0.4470 0.7410]);
drawnow();
set(handles.word_count,'String','0');
set(handles.word_count,'ForegroundColor',[0 0.4470 0.7410]);
drawnow();
set(handles.text5,'String','Output:');
set(handles.text5,'ForegroundColor',[0 0.4470 0.7410]);
drawnow();

% --------------------------------------------------------------------
function white_f_Callback(hObject, eventdata, handles)
% hObject    handle to white_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text3,'String','Morse Code Translator');
set(handles.text3,'ForegroundColor','w');
drawnow();
set(handles.text4,'String','Input (English/Morse Code):');
set(handles.text4,'ForegroundColor','w');
drawnow();
set(handles.text6,'String','Word Count: ');
set(handles.text6,'ForegroundColor','w');
drawnow();
set(handles.word_count,'String','0');
set(handles.word_count,'ForegroundColor','w');
drawnow();
set(handles.text5,'String','Output:');
set(handles.text5,'ForegroundColor','w');
drawnow();

% --------------------------------------------------------------------
function style_1_Callback(hObject, eventdata, handles)
% hObject    handle to style_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text3,'String','Morse Code Translator');
set(handles.text3,'FontSize',20);
drawnow();
set(handles.text4,'String','Input (English/Morse Code):');
set(handles.text4,'FontSize',15);
drawnow();
set(handles.text6,'String','Word Count:');
set(handles.text6,'FontSize',15);
drawnow();
set(handles.word_count,'String','0');
set(handles.word_count,'FontSize',15);
drawnow();
set(handles.text5,'String','Output:');
set(handles.text5,'FontSize',15);
drawnow();

% --------------------------------------------------------------------
function style_2_Callback(hObject, eventdata, handles)
% hObject    handle to style_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text3,'String','Morse Code Translator');
set(handles.text3,'FontSize',22);
drawnow();
set(handles.text4,'String','Input (English/Morse Code):');
set(handles.text4,'FontSize',17);
drawnow();
set(handles.text6,'String','Word Count:');
set(handles.text6,'FontSize',17);
drawnow();
set(handles.word_count,'String','0');
set(handles.word_count,'FontSize',17);
drawnow();
set(handles.text5,'String','Output:');
set(handles.text5,'FontSize',17);
drawnow();


% --------------------------------------------------------------------
function style_3_Callback(hObject, eventdata, handles)
% hObject    handle to style_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text3,'String','Morse Code Translator');
set(handles.text3,'FontSize',25);
drawnow();
set(handles.text4,'String','Input (English/Morse Code):');
set(handles.text4,'FontSize',20);
drawnow();
set(handles.text6,'String','Word Count:');
set(handles.text6,'FontSize',20);
drawnow();
set(handles.word_count,'String','0');
set(handles.word_count,'FontSize',20);
drawnow();
set(handles.text5,'String','Output:');
set(handles.text5,'FontSize',20);
drawnow();


% --------------------------------------------------------------------
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(gcf,'Color',[0.97 0.93 0.84]);
set(handles.text3,'backgroundcolor',[0.97 0.93 0.84]);
set(handles.text4,'backgroundcolor',[0.97 0.93 0.84]);
set(handles.text5,'backgroundcolor',[0.97 0.93 0.84]);
set(handles.text6,'backgroundcolor',[0.97 0.93 0.84]);
set(handles.word_count,'backgroundcolor',[0.97 0.93 0.84]);
set(handles.text3,'String','Morse Code Translator');
set(handles.text3,'ForegroundColor',[0 0 0]);
drawnow();
set(handles.text4,'String','Input (English/Morse Code):');
set(handles.text4,'ForegroundColor',[0 0 0]);
drawnow();
set(handles.text6,'String','Word Count: ');
set(handles.text6,'ForegroundColor',[0 0 0]);
drawnow();
set(handles.word_count,'String','0');
set(handles.word_count,'ForegroundColor',[0 0 0]);
drawnow();
set(handles.text5,'String','Output:');
set(handles.text5,'ForegroundColor',[0 0 0]);
drawnow();
set(handles.text3,'String','Morse Code Translator');
set(handles.text3,'FontSize',15);
drawnow();
set(handles.text4,'String','Input (English/Morse Code):');
set(handles.text4,'FontSize',10);
drawnow();
set(handles.text6,'String','Word Count:');
set(handles.text6,'FontSize',10);
drawnow();
set(handles.word_count,'String','0');
set(handles.word_count,'FontSize',10);
drawnow();
set(handles.text5,'String','Output:');
set(handles.text5,'FontSize',10);
drawnow();
% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Clear_PB.
function Clear_PB_Callback(hObject, eventdata, handles)
% hObject    handle to Clear_PB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.input_msg, 'string', '');
set(handles.output_msg, 'string', '');
set(handles.word_count, 'string', '0');
