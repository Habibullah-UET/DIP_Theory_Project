%   MIT License
% 
% Copyright (c) 2016 Habibullah ( Unixian@outlook.com )
%    University Of Enginering And Technology Peshawar
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

function varargout = Project(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Project_OpeningFcn, ...
                   'gui_OutputFcn',  @Project_OutputFcn, ...
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


% --- Executes just before Project is made visible.
function Project_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for Project
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

function varargout = Project_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


%--------------- FILE MENU -----------------------------------------

function FileMenu_Callback(hObject, eventdata, handles)

function FileMenuOpen_Callback(hObject, eventdata, handles)      

function OpenImage_Callback(hObject, eventdata, handles)
    filename = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
           '*.*','All Files' },'Open Image Dialogue');
     try 
        if ( get(handles.Image1Radio,'Value') == 1)
             I1 = imread(filename);
             % Make this image available to the other callbacks too
             handles.I1 = I1;
             guidata(hObject,handles);
     
             % Display this image in the first axes (Image1Axes)
             axes(handles.Image1Axes)
             imshow(I1);
        else
             I2 = imread(filename);
             % Make this image available to the other callbacks too
             handles.I2 = I2;
             guidata(hObject,handles);
     
             % Display this image in the first axes (Image1Axes)
             axes(handles.Image2Axes)
             imshow(I2);
        end
        
     catch
             msgbox('No image was selected for opening...','Open Error','Error');
     end

function FileMenuSave_Callback(hObject, eventdata, handles)
    
    try
        RES = handles.RES;
        [FileName Path] = uiputfile({'*.jpg'});
        imwrite(RES,FileName);       
    catch
        msgbox('Nothing to Save!','Save Error','Warn');
    end
    
% --------------------------------------------------------------------
function FileMenuExit_Callback(hObject, eventdata, handles)

close all;


% -------------------------About Menu--------------------------------------
function AboutMenu_Callback(hObject, eventdata, handles)
    
function AboutMenuHelp_Callback(hObject, eventdata, handles)
msgbox({'Habib Ullah' 'Unixian@outlook.com'},'About','Help');

function AboutMenuAbout_Callback(hObject, eventdata, handles)
% myicon = imread('icon.png');
msgbox({'Habib Ullah' 'Unixian@outlook.com'},'About','Help');


%  Transforms Operations
% ----------------------------------------------------------------------
function TransformFourier_Callback(hObject, eventdata, handles)
    
    if (get(handles.Image1Radio,'Value') == 1)
        I1 = handles.I1;
        FT = fft2(I1);
        FT = fftshift(FT);
    else
        I2 = handles.I2;
        FT = fft2(I2);
        FT = fftshift(FT);
    end
        
    axes(handles.OutputImageAxes);
    imshow(FT);
    handles.RES = FT; % For the save Function
    handles.FT = FT;  % for the Inverse transform Function
    guidata(hObject,handles);

function TransformInverse_Callback(hObject, eventdata, handles)
    FT = handles.FT;
    IFT = ifftshift(FT);
    IFT = ifft2(IFT);
    IFT = real(IFT);
    axes(handles.OutputImageAxes);
    imshow(uint8(IFT));
    handles.RES = IFT;  % for the Save Function
    guidata(hObject,handles);
% ------------------------END Transforms Operations --------------------


% --- Image Spatial Transformation -------

function Rotation_Callback(hObject, eventdata, handles)
 if ( get(handles.Image1Radio,'Value') == 1)  
   I1 = handles.I1;   
   switch (get(handles.Rotation,'Value'))
      case 1
                R = imrotate(I1,0);
                  
      case 2
                R = imrotate(I1,45);
               
      case 3
                R = imrotate(I1,90);
               
      case 4
                R = imrotate(I1,180);
      case 5
                R = imrotate(I1,360);

      otherwise
                R = imrotate(I1,0);
                     
   end
    
 else
     I2 = handles.I2;   
   switch (get(handles.Rotation,'Value'))
      case 1
                R = imrotate(I2,0);
                  
      case 2
                R = imrotate(I2,45);
               
      case 3
                R = imrotate(I2,90);
               
      case 4
                R = imrotate(I2,180);
      case 5
                R = imrotate(I2,360);

      otherwise
                R = imrotate(I2,0);
                     
   end
 end
    
  axes(handles.OutputImageAxes);
  imshow(R);
  a = get(handles.Rotation,'Value');
  title(a);
  
  handles.RES = R;
  guidata(hObject,handles);

  
  
function Rotation_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FlippingButton_Callback(hObject, eventdata, handles)
    if ( get(handles.Image1Radio,'Value') == 1 )
        I1 = handles.I1;
        Flip = fliplr(I1);
    else
        I2 = handles.I2;
        Flip = fliplr(I2);
        
    end
    axes(handles.OutputImageAxes);
    imshow(Flip);
    handles.RES = Flip;
    guidata(hObject,handles);

 function TranspositionButton_Callback(hObject, eventdata, handles)
    if( get(handles.Image1Radio,'Value') == 1)
        I1 = handles.I1;
        for i=1:size(I1,1)
            for j=1:size(I1,2)
                T(i,j) = I1(j,i);
            end
        end
    else
        I2 = handles.I2;
        for i=1:size(I2,1)
            for j=1:size(I2,2)
                T(i,j) = I2(j,i);
            end
        end        
    end
    
    handles.RES = T;
    guidata(hObject,handles);
    
    axes(handles.OutputImageAxes);
    imshow(uint8(T));
  
function LogButton_Callback(hObject, eventdata, handles)
    c=0.2;
   if( get(handles.Image1Radio,'Value') == 1)
        I1 = handles.I1;
        r = double (I1);
        L = c* log(r+1);
   else
        I2 = handles.I2;
        r = double (I2);
        L = c* log(r+1);
   end
   
    handles.RES = L;
    guidata(hObject,handles);
   
    axes(handles.OutputImageAxes);
    imshow(L);

function RootButton_Callback(hObject, eventdata, handles)
  if( get(handles.Image1Radio,'Value') == 1)
      I1 = handles.I1;
      I1 = double (I1);
      S = sqrt(I1);
  else
      I2 = handles.I2;
      I2 = double (I2);
      S = sqrt(I2);
  end
    
    handles.RES = uint8(S);
    guidata(hObject,handles);
    axes(handles.OutputImageAxes);
    imshow(uint8(S));

function PowerButton_Callback(hObject, eventdata, handles)
    
    c=0.35;
    gamma = 0.2;
  if( get(handles.Image1Radio,'Value') == 1)
        I1 = handles.I1;
        r = double (I1);
        P = c*r.^gamma;
  else
        I2 = handles.I2;
        r = double (I2);
        P = c*r.^gamma;
  end
    handles.RES = P;
    guidata(hObject,handles);
    axes(handles.OutputImageAxes);
    imshow(P)
% -------------- END Image Spatial Transformation ------------------------


% ---------------------- Image Cropping ----------------------------------

function CropButton_Callback(hObject, eventdata, handles)
    
       I1 = handles.I1;
       rect = imrect;               % Create Rectungular ROI object
       Area = rect.getPosition;     % Get the Values of ROI
       rect.delete;                 % Delete the ROI Object, 
       C=imcrop(I1 , Area);         % Crop the ROI from Image
       axes(handles.OutputImageAxes);
       imshow(C,[]);
     
       handles.RES = C;
       guidata(hObject,handles);

% ---------------------- END Image Cropping ------------------------------


% --------------- Multiple Image Manipulation ----------------------------
function AddButton_Callback(hObject, eventdata, handles)
%     set(handles.Image1Radio,'Enable','off');
%     set(handles.Image2Radio,'Enable','off');
    axes(handles.OutputImageAxes);
     try
         I1 = handles.I1;
         I2 = handles.I2;
         
     catch 
        msgbox('No image to perform Operation on!','Load Error','Warn');
     end

     if (size(I1,1) == size(I2,1) && size(I1,2) == size(I2,2))
        Add = imadd(I1,I2);
     else
     msgbox('Image Must Have Same size. ','Size Error','Error')    
     end

    %  Make add available to other callbacks too......
        handles.RES = Add;
        guidata(hObject,handles);
        imshow(Add);
%     set(handles.Image1Radio,'Enable','off');
%     set(handles.Image2Radio,'Enable','off');
 
function SubtractButton_Callback(hObject, eventdata, handles)
         axes(handles.OutputImageAxes);
        try
            I1 = handles.I1;
            I2 = handles.I2;

        catch
            msgbox('No image to perform Operation on!','Load Error','Warn')
        end

        % Error Handling________ whether the image have same size.
         if (size(I1,1) == size(I2,1) && size(I1,2) == size(I2,2))
            Sub = imsubtract(I1,I2);
         else
         msgbox('Both Images Must Have Same size. ','Size Error','Warn')    
         end

         %  Make Sub available to other callbacks too......
            handles.RES = Sub;
            guidata(hObject,handles);

         imshow(Sub);
   

function Slider_Callback(hObject, eventdata, handles)
A = get(handles.Slider,'Value');
axes(handles.OutputImageAxes);
if (A > 2 )
    zoom(A);
else
    
    zoom out; zoom(A);
end

%  [1/(numSteps-1) , 1/(numSteps-1) ]);
function Slider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function ScalingImage_Callback(hObject, eventdata, handles)
     
  if ( get(handles.Image1Radio,'Value') == 1)  
   I1 = handles.I1;   
   switch (get(handles.ScalingImage,'Value'))
      case 1
                R = imresize(I1,1);
               
                
      case 2
                R = imresize(I1,2);
               
      case 3
                R = imresize(I1,3);
               
      case 4
                R = imresize(I1,4);
               
      case 5
                R = imresize(I1,5);
               
      otherwise
                R = imresize(I1,1);
                     
   end
  else
         I2 = handles.I2;   
   switch (get(handles.ScalingImage,'Value'))
      case 1
                R = imresize(I2,1);
               
                
      case 2
                R = imresize(I2,2);
               
      case 3
                R = imresize(I2,3);
               
      case 4
                R = imresize(I2,4);
               
      case 5
                R = imresize(I2,5);
               
      otherwise
                R = imresize(I2,1);
                     
   end
  end

     axes(handles.OutputImageAxes);
     imshow(R);
     [N, M] = size(R);
     T = sprintf('Size: %d X %d', N, M);
     title(T); 
      
     handles.RES = R;
     guidata(hObject,handles);
     
function ScalingImage_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function DataCursor_Callback(hObject, eventdata, handles)
if (get(handles.DataCursor,'Value') == 1)
    datacursormode on;
else
        datacursormode off;

end
