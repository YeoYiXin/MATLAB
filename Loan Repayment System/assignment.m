function varargout = assignment(varargin)
% ASSIGNMENT MATLAB code for assignment.fig
%      ASSIGNMENT, by itself, creates a new ASSIGNMENT or raises the existing
%      singleton*.
%
%      H = ASSIGNMENT returns the handle to a new ASSIGNMENT or the handle to
%      the existing singleton*.
%
%      ASSIGNMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ASSIGNMENT.M with the given input arguments.
%
%      ASSIGNMENT('Property','Value',...) creates a new ASSIGNMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before assignment_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to assignment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help assignment

% Last Modified by GUIDE v2.5 27-Mar-2022 19:47:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @assignment_OpeningFcn, ...
                   'gui_OutputFcn',  @assignment_OutputFcn, ...
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


% --- Executes just before assignment is made visible.
function assignment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to assignment (see VARARGIN)


% Choose default command line output for assignment
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes assignment wait for user response (see UIRESUME)
% uiwait(handles.result_table);


% --- Outputs from this function are returned to the command line.
function varargout = assignment_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function loan_amount_Callback(hObject, eventdata, handles)
% hObject    handle to loan_amount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loan_amount as text
%        str2double(get(hObject,'String')) returns contents of loan_amount as a double
loan_amount=get(hObject, 'string');
loan_amount_num=str2double(loan_amount);
handles.loan_amount_num=loan_amount_num;
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function loan_amount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loan_amount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yearly_interest_Callback(hObject, eventdata, handles)
% hObject    handle to yearly_interest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yearly_interest as text
%        str2double(get(hObject,'String')) returns contents of yearly_interest as a double
yearly_interest=get(hObject, 'string');
yearly_interest_num=str2double(yearly_interest);
handles.yearly_interest_num=yearly_interest_num;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function yearly_interest_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yearly_interest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function monthly_payment_Callback(hObject, eventdata, handles)
% hObject    handle to monthly_payment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of monthly_payment as text
%        str2double(get(hObject,'String')) returns contents of monthly_payment as a double
monthly_payment=get(hObject, 'string');
monthly_payment_num=str2double(monthly_payment);
handles.monthly_payment_num=monthly_payment_num;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function monthly_payment_CreateFcn(hObject, eventdata, handles)
% hObject    handle to monthly_payment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PB_calculate.
function PB_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to PB_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
loan_amount_num=handles.loan_amount_num;
yearly_interest_num=handles.yearly_interest_num;
monthly_payment_num=handles.monthly_payment_num;

% break if stuck in infinite loop
a=0;
% break if condition is met
breaker=0;
% initialize the output. 
output_string = '';

% fixed monthly interest rate
monthly_interest_num=(yearly_interest_num/100)/12; 
% (2/100) / 12 = 0.00167

%calculate the interest_num for the first month
interest_num=loan_amount_num*monthly_interest_num;

%if user enter negative value 
if (loan_amount_num<0) || (yearly_interest_num <0) || (monthly_payment_num< 0) 
   errordlg('You have entered invalid input. Please enter value again! ','Error');
   set(handles.loan_amount,'string',''); 
   set(handles.yearly_interest,'string','');
   set(handles.monthly_payment,'string','');      
   breaker=1;

% if monthly interest greater than loan amount
elseif loan_amount_num < monthly_payment_num
   errordlg('You have entered invalid input. Please enter value again! ','Error');
   set(handles.loan_amount,'string',''); 
   set(handles.monthly_payment,'string','');
   breaker=1;
%loan cannot be lesser than 5000 and 
%yearly interest cannot be lesser than 0.015
elseif (loan_amount_num < 5000) && (yearly_interest_num < 1.5)
    breaker=1;
    choice=questdlg({'Both loan amount and yearly interest are insufficient! Do you wish to enter value again? '; ...
        'Choose "Yes" to continue '; ...
        'Choose "No" if you want to stop the program.'}, ...
        'Invalid input','Yes','No','Yes');      
    switch choice
        case 'No' 
            closereq;             
        otherwise
            set(handles.loan_amount,'string','');
            set(handles.yearly_interest,'string','');
            set(handles.monthly_payment,'string','');       
    end       
elseif (loan_amount_num < 5000)
   breaker=1;
   choice=questdlg({'Loan amount too small! (Minimum: RM 5000)'; 'Do you wish to enter value again? '; ...
        'Choose "Yes" to continue '; ...
        'Choose "No" if you want to stop the program.'}, ...
        'Invalid input','Yes','No','Yes');       
    switch choice
        case 'No'                 
            closereq;                
        otherwise
             set(handles.loan_amount,'string','');                
    end       
elseif (yearly_interest_num< 1.5)
    breaker=1;
    choice=questdlg({'Yearly interest too less! (Minimum: 1.5%)'; 'Do you wish to enter value again? '; ...
    'Choose "Yes" to continue '; ...
    'Choose "No" if you want to stop the program.'}, ...
    'Invalid input','Yes','No','Yes');
   switch choice
        case 'No'                
            closereq;               
        otherwise
            set(handles.yearly_interest,'string','');                
    end       
       
%re-enter if yearly interest is larger than 100
elseif yearly_interest_num >100
    breaker=1;
    choice=questdlg({'Yearly interest too high! (Maximum: 100%)'; 'Do you wish to enter value again? '; ...
       'Choose "Yes" to continue '; ...
       'Choose "No" if you want to stop the program.'}, ...
        'Invalid input','Yes','No','Yes');   
    switch choice
        case 'No' 
            closereq;             
        otherwise
            set(handles.yearly_interest,'string','');                                         
    end    

%monthly payment cannot be smaller or equal to the value of interest.
%If not the person that pays the loan will not be able to finish paying
%his/her loan
elseif monthly_payment_num <= interest_num
    breaker=1;
    choice=questdlg({'Monthly Payment must be greater than interest! Do you wish to enter value again? '; ...
    'Choose "Yes" to continue '; ...
    'Choose "No" if you want to stop the program.'}, ...
    'Invalid input','Yes','No','Yes');
    switch choice
        case 'No' 
            closereq;           
        otherwise
            set(handles.monthly_payment,'string','');
            set(handles.loan_repayment_num,'string','');          
    end
end

if breaker ==1
    return
end

% initialize output header
loan_repayment=strcat({['|      Beginning Balance   '   ...
    '  |       Interest   ' '     |    Monthly Payment        ' ...
    ' |      Principal     '  '  |     Ending Balance  |']}, ...
    {' -----------------------------------------------------------------------------------------------------------------------------------------------'});
set(handles.loan_repayment, 'string', loan_repayment);

%calculate input value till 0
while loan_amount_num > 0 
    a = a + 1;
    %calculate
    interest_num=loan_amount_num*monthly_interest_num;
    principal_num=monthly_payment_num - interest_num;
    result_num=loan_amount_num-principal_num;
    
    new_line_string=strcat({'               '},...
    num2str(loan_amount_num,'%.2f'),...
    {'                         '}, ...
    num2str(interest_num,'%.2f'),...
    {'                 '}, ...
    num2str(monthly_payment_num,'%.2f'),...
    {'                          '}, ...
    num2str(principal_num,'%.2f'),...
    {'                        '}, ...
    num2str(result_num,'%.2f'), ...
    {'                    '});
    output_string = [output_string; new_line_string]; 
    loan_amount_num = result_num;
    
    %when loan amount is lesser than monthly payment, the ending balance
    %will be calculated to 0
    if loan_amount_num <= monthly_payment_num
        monthly_payment_num=loan_amount_num;
        interest_num=0;
        principal_num=monthly_payment_num;
        result_num=loan_amount_num-principal_num;
        last_line_string=strcat({'                '},...
        num2str(loan_amount_num,'%.2f'),...
        {'                           '}, ...
        num2str(interest_num,'%.2f'),...
        {'                    '}, ...
        num2str(monthly_payment_num,'%.2f'),...
        {'                       '}, ...
        num2str(principal_num,'%.2f'),...
        {'                     '}, ...
        num2str(result_num,'%.2f'), ...
        {'                 '});
        output_string = [output_string;new_line_string;last_line_string];        
        break;
    end
    if a> 1000
        break;
    end
end

%output
set(handles.loan_repayment_num,'string',output_string);

% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
notes={'To produce an output, you should: ';
         'a) Enter Valid Input - NO NEGATIVE INPUT,'; ...
         'b) Yearly interest rate should be AT LEAST 1.5 %,'; ...
         'c) Loan amount should be AT LEAST 5000, '; ...
         'd) Monthly payment must be greater than interest.'};
helpdlg(notes,'About');


% --------------------------------------------------------------------
function font_size_Callback(hObject, eventdata, handles)
% hObject    handle to font_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function font_color_Callback(hObject, eventdata, handles)
% hObject    handle to font_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function bkgrd_col_Callback(hObject, eventdata, handles)
% hObject    handle to bkgrd_col (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uigetfile

% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiputfile

% --------------------------------------------------------------------
function print_Callback(hObject, eventdata, handles)
% hObject    handle to print (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg

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
function restore_1_Callback(hObject, eventdata, handles)
% hObject    handle to restore_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice=questdlg('Do you want to restore the program back to default?',...
                'Reset program',...
                'Yes','No','No');
switch choice
    case 'Yes' 
        set(handles.loan_amount,'string','');
        set(handles.yearly_interest,'string','');
        set(handles.monthly_payment,'string','');
        set(gcf,'Color',[0.97 0.93 0.84]);
        try 
           set(handles.loan_repayment_num,'String','');
        end
        set(handles.text2,'backgroundcolor',[0.97 0.93 0.84]);
        set(handles.text3,'backgroundcolor',[0.97 0.93 0.84]);
        set(handles.text4,'backgroundcolor',[0.97 0.93 0.84]);
        set(handles.text5,'backgroundcolor',[0.97 0.93 0.84]);
        set(handles.text2,'String','Loan Repayment Table:');
        set(handles.text2,'ForegroundColor',[0 0 0]);
        drawnow();
        set(handles.text3,'String','Loan Amount:');
        set(handles.text3,'ForegroundColor',[0 0 0]);
        drawnow();
        set(handles.text4,'String','Yearly Interest Rate:');
        set(handles.text4,'ForegroundColor',[0 0 0]);
        drawnow();
        set(handles.text5,'String','Monthly Payment:');
        set(handles.text5,'ForegroundColor',[0 0 0]);
        drawnow();
        set(handles.text2,'String','Loan Repayment Table:');
        set(handles.text2,'FontSize',25);
        drawnow();
        set(handles.text3,'String','Loan Amount:');
        set(handles.text3,'FontSize',15);
        drawnow();
        set(handles.text4,'String','Yearly Interest Rate:');
        set(handles.text4,'FontSize',15);
        drawnow();
        set(handles.text5,'String','Monthly Payment:');
        set(handles.text5,'FontSize',15);
        drawnow();
    otherwise
        return;
end   

% --------------------------------------------------------------------
function grey_Callback(hObject, eventdata, handles)
% hObject    handle to grey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(gcf,'Color',[0.941 0.941 0.941]);
set(handles.text2,'backgroundcolor',[0.941 0.941 0.941]);
set(handles.text3,'backgroundcolor',[0.941 0.941 0.941]);
set(handles.text4,'backgroundcolor',[0.941 0.941 0.941]);
set(handles.text5,'backgroundcolor',[0.941 0.941 0.941]);

% --------------------------------------------------------------------
function purple_Callback(hObject, eventdata, handles)
% hObject    handle to purple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [0.4940, 0.1840, 0.5560] )
set(handles.text2,'backgroundcolor',[0.4940, 0.1840, 0.5560]);
set(handles.text3,'backgroundcolor',[0.4940, 0.1840, 0.5560]);
set(handles.text4,'backgroundcolor',[0.4940, 0.1840, 0.5560]);
set(handles.text5,'backgroundcolor',[0.4940, 0.1840, 0.5560]);
set(handles.text2,'String','Loan Repayment Table:');
        set(handles.text2,'ForegroundColor','w');
        drawnow();
        set(handles.text3,'String','Loan Amount:');
        set(handles.text3,'ForegroundColor','w');
        drawnow();
        set(handles.text4,'String','Yearly Interest Rate:');
        set(handles.text4,'ForegroundColor','w');
        drawnow();
        set(handles.text5,'String','Monthly Payment:');
        set(handles.text5,'ForegroundColor','w');
        drawnow();

% --------------------------------------------------------------------
function blue_Callback(hObject, eventdata, handles)
% hObject    handle to blue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [0 0.4470 0.7410] )
set(handles.text2,'backgroundcolor',[0 0.4470 0.7410]);
set(handles.text3,'backgroundcolor',[0 0.4470 0.7410]);
set(handles.text4,'backgroundcolor',[0 0.4470 0.7410]);
set(handles.text5,'backgroundcolor',[0 0.4470 0.7410]);





% --------------------------------------------------------------------
function yellow_Callback(hObject, eventdata, handles)
% hObject    handle to yellow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [0.9290, 0.6940, 0.1250] )
set(handles.text2,'backgroundcolor',[0.9290, 0.6940, 0.1250]);
set(handles.text3,'backgroundcolor',[0.9290, 0.6940, 0.1250]);
set(handles.text4,'backgroundcolor',[0.9290, 0.6940, 0.1250]);
set(handles.text5,'backgroundcolor',[0.9290, 0.6940, 0.1250]);

% --------------------------------------------------------------------
function green_Callback(hObject, eventdata, handles)
% hObject    handle to green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [0.4660, 0.6740, 0.1880] )
set(handles.text2,'backgroundcolor',[0.4660, 0.6740, 0.1880]);
set(handles.text3,'backgroundcolor',[0.4660, 0.6740, 0.1880]);
set(handles.text4,'backgroundcolor',[0.4660, 0.6740, 0.1880]);
set(handles.text5,'backgroundcolor',[0.4660, 0.6740, 0.1880]);

% --------------------------------------------------------------------
function black_f_Callback(hObject, eventdata, handles)
% hObject    handle to black_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text2,'String','Loan Repayment Table:');
set(handles.text2,'ForegroundColor',[0 0 0]);
drawnow();
set(handles.text3,'String','Loan Amount:');
set(handles.text3,'ForegroundColor',[0 0 0]);
drawnow();
set(handles.text4,'String','Yearly Interest Rate:');
set(handles.text4,'ForegroundColor',[0 0 0]);
drawnow();
set(handles.text5,'String','Monthly Payment:');
set(handles.text5,'ForegroundColor',[0 0 0]);
drawnow();

% --------------------------------------------------------------------
function green_f_Callback(hObject, eventdata, handles)
% hObject    handle to green_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text2,'String','Loan Repayment Table:');
set(handles.text2,'ForegroundColor',[0.4660, 0.6740, 0.1880]);
drawnow();
set(handles.text3,'String','Loan Amount:');
set(handles.text3,'ForegroundColor',[0.4660, 0.6740, 0.1880]);
drawnow();
set(handles.text4,'String','Yearly Interest Rate:');
set(handles.text4,'ForegroundColor',[0.4660, 0.6740, 0.1880]);
drawnow();
set(handles.text5,'String','Monthly Payment:');
set(handles.text5,'ForegroundColor',[0.4660, 0.6740, 0.1880]);
drawnow();

% --------------------------------------------------------------------
function red_f_Callback(hObject, eventdata, handles)
% hObject    handle to red_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text2,'String','Loan Repayment Table:');
set(handles.text2,'ForegroundColor',[1 0 0]);
drawnow();
set(handles.text3,'String','Loan Amount:');
set(handles.text3,'ForegroundColor',[1 0 0]);
drawnow();
set(handles.text4,'String','Yearly Interest Rate:');
set(handles.text4,'ForegroundColor',[1 0 0]);
drawnow();
set(handles.text5,'String','Monthly Payment:');
set(handles.text5,'ForegroundColor',[1 0 0]);
drawnow();

% --------------------------------------------------------------------
function blue_f_Callback(hObject, eventdata, handles)
% hObject    handle to blue_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text2,'String','Loan Repayment Table:');
set(handles.text2,'ForegroundColor',[0 0.4470 0.7410]);
drawnow();
set(handles.text3,'String','Loan Amount:');
set(handles.text3,'ForegroundColor',[0 0.4470 0.7410]);
drawnow();
set(handles.text4,'String','Yearly Interest Rate:');
set(handles.text4,'ForegroundColor',[0 0.4470 0.7410]);
drawnow();
set(handles.text5,'String','Monthly Payment:');
set(handles.text5,'ForegroundColor',[0 0.4470 0.7410]);
drawnow();

% --------------------------------------------------------------------
function white_f_Callback(hObject, eventdata, handles)
% hObject    handle to white_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text2,'String','Loan Repayment Table:');
set(handles.text2,'ForegroundColor','w');
drawnow();
set(handles.text3,'String','Loan Amount:');
set(handles.text3,'ForegroundColor','w');
drawnow();
set(handles.text4,'String','Yearly Interest Rate:');
set(handles.text4,'ForegroundColor','w');
drawnow();
set(handles.text5,'String','Monthly Payment:');
set(handles.text5,'ForegroundColor','w');
drawnow();

% --------------------------------------------------------------------
function style_1_Callback(hObject, eventdata, handles)
% hObject    handle to style_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text2,'String','Loan Repayment Table:');
set(handles.text2,'FontSize',20);
drawnow();
set(handles.text3,'String','Loan Amount:');
set(handles.text3,'FontSize',12);
drawnow();
set(handles.text4,'String','Yearly Interest Rate:');
set(handles.text4,'FontSize',12);
drawnow();
set(handles.text5,'String','Monthly Payment:');
set(handles.text5,'FontSize',12);
drawnow();

% --------------------------------------------------------------------
function style_2_Callback(hObject, eventdata, handles)
% hObject    handle to style_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text2,'String','Loan Repayment Table:');
set(handles.text2,'FontSize',22);
drawnow();
set(handles.text3,'String','Loan Amount:');
set(handles.text3,'FontSize',14);
drawnow();
set(handles.text4,'String','Yearly Interest Rate:');
set(handles.text4,'FontSize',14);
drawnow();
set(handles.text5,'String','Monthly Payment:');
set(handles.text5,'FontSize',14);
drawnow();


% --------------------------------------------------------------------
function style_3_Callback(hObject, eventdata, handles)
% hObject    handle to style_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text2,'String','Loan Repayment Table:');
set(handles.text2,'FontSize',25);
drawnow();
set(handles.text3,'String','Loan Amount:');
set(handles.text3,'FontSize',16);
drawnow();
set(handles.text4,'String','Yearly Interest Rate:');
set(handles.text4,'FontSize',16);
drawnow();
set(handles.text5,'String','Monthly Payment:');
set(handles.text5,'FontSize',16);
drawnow();


% --------------------------------------------------------------------
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function font_Callback(hObject, eventdata, handles)
% hObject    handle to font (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function restore_Callback(hObject, eventdata, handles)
% hObject    handle to restore_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
        

% --------------------------------------------------------------------
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
        
        set(gcf,'Color',[0.97 0.93 0.84]);


        set(handles.text2,'backgroundcolor',[0.97 0.93 0.84]);
        set(handles.text3,'backgroundcolor',[0.97 0.93 0.84]);
        set(handles.text4,'backgroundcolor',[0.97 0.93 0.84]);
        set(handles.text5,'backgroundcolor',[0.97 0.93 0.84]);
        set(handles.text2,'String','Loan Repayment Table:');
        set(handles.text2,'ForegroundColor',[0 0 0]);
        drawnow();
        set(handles.text3,'String','Loan Amount:');
        set(handles.text3,'ForegroundColor',[0 0 0]);
        drawnow();
        set(handles.text4,'String','Yearly Interest Rate:');
        set(handles.text4,'ForegroundColor',[0 0 0]);
        drawnow();
        set(handles.text5,'String','Monthly Payment:');
        set(handles.text5,'ForegroundColor',[0 0 0]);
        drawnow();
        set(handles.text2,'String','Loan Repayment Table:');
        set(handles.text2,'FontSize',25);
        drawnow();
        set(handles.text3,'String','Loan Amount:');
        set(handles.text3,'FontSize',15);
        drawnow();
        set(handles.text4,'String','Yearly Interest Rate:');
        set(handles.text4,'FontSize',15);
        drawnow();
        set(handles.text5,'String','Monthly Payment:');
        set(handles.text5,'FontSize',15);
        drawnow();

% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function clear_table_Callback(hObject, eventdata, handles)
% hObject    handle to clear_table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try 
       set(handles.loan_repayment_num,'string','');
end


% --------------------------------------------------------------------
function Clear_Callback(hObject, eventdata, handles)
% hObject    handle to Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function export_Callback(hObject, eventdata, handles)
% hObject    handle to export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file path] = uiputfile('*.pdf');
print([path file], '-dpdf');


%----------------------------------------------------------------------
% --- Executes on selection change in loan_repayment_num.
function loan_repayment_num_Callback(hObject, eventdata, handles)
% hObject    handle to loan_repayment_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns loan_repayment_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from loan_repayment_num


% --- Executes during object creation, after setting all properties.
function loan_repayment_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loan_repayment_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function beige_Callback(hObject, eventdata, handles)
% hObject    handle to beige (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [0.97 0.93 0.84] )
set(handles.text2,'backgroundcolor',[0.97 0.93 0.84]);
set(handles.text3,'backgroundcolor',[0.97 0.93 0.84]);
set(handles.text4,'backgroundcolor',[0.97 0.93 0.84]);
set(handles.text5,'backgroundcolor',[0.97 0.93 0.84]);
