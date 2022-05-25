unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  ExtDlgs, StdCtrls, Buttons, ComCtrls, ColorBox, ActnList;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    CheckBox1: TCheckBox;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MainMenu1: TMainMenu;
    MenuItemFile: TMenuItem;
    MenuItemScreenshot: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    PageControl2: TPageControl;
    SavePictureDialog1: TSavePictureDialog;
    ScrollBox1: TScrollBox;
    StaticText1: TStaticText;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Timer1: TTimer;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    procedure FormCreate(Sender: TObject);
    procedure MenuItemScreenshotClick(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i, j : integer;
begin
  image1.Canvas.brush.color := clWhite;
  image2.Canvas.brush.color := clWhite;
  image3.Canvas.brush.color := clWhite;
  Image1.Canvas.FillRect(0, 0, Image1.Canvas.Width, Image1.Canvas.Height); 
  Image1.Canvas.FillRect(0, 0, Image1.Canvas.Width, Image1.Canvas.Height);
  Image2.Canvas.FillRect(0, 0, Image2.Canvas.Width, Image2.Canvas.Height);
  Image2.Canvas.FillRect(0, 0, Image2.Canvas.Width, Image2.Canvas.Height);
  Image3.Canvas.FillRect(0, 0, Image3.Canvas.Width, Image3.Canvas.Height);  
  Image3.Canvas.FillRect(0, 0, Image3.Canvas.Width, Image3.Canvas.Height);

end;

procedure TForm1.MenuItemScreenshotClick(Sender: TObject);
begin

end;

end.

