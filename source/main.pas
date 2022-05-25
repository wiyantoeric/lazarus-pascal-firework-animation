unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  ExtDlgs, StdCtrls, Buttons, ComCtrls, ColorBox, ActnList,
  FileUtil;

type

  { TForm1 }

  TForm1 = class(TForm)
    buttonPlay: TButton;
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
    procedure buttonPlayClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItemScreenshotClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);


  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
var
  x, y : integer;
  Ty   : integer;

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
  x  := image1.Width div 2;
  y  := image1.Height;
  Ty := -50;
  image1.Canvas.Pen.Color:=clWhite;
  image1.Canvas.Brush.Color:=clWhite;
  image1.Canvas.Rectangle(0,0,image1.Width,image1.Height);
  Timer1.Enabled := false;
end;

procedure TForm1.buttonPlayClick(Sender: TObject);
begin
  Timer1.Enabled := true;
  Timer1Timer(Sender);
end;

procedure TForm1.MenuItemScreenshotClick(Sender: TObject);
begin

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  y := y + Ty;
  //hapus
  Image1.Canvas.Brush.Color := clWhite;
  Image1.Canvas.Pen.Color := clWhite;
  image1.Canvas.Pen.Style := psSolid;
  image1.Canvas.Ellipse(x,y - 25 + 50,x + 20,y + 25 + 50);
  //gambar grafik
  image1.Canvas.Brush.Color := clBlack;
  image1.Canvas.Pen.Color := clBlack;
  image1.Canvas.Pen.Style := psSolid;
  image1.Canvas.Ellipse(x,y - 25,x + 20,y + 25);

  if y <= 150 then
  begin
    y  := image1.Height;
    Image1.Canvas.Pen.Color:=clWhite;
    Image1.Canvas.Brush.Color:=clWhite;
    Image1.Canvas.Rectangle(0,0,image1.Width,image1.Height);
  end;
end;

end.

