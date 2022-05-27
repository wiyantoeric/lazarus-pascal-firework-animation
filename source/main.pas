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
    Button_Play: TButton;
    buttonPlay: TButton;
    Button_Pause: TButton;
    Button_BgApply: TButton;
    Button_FireApply: TButton;
    Button_AnimApply: TButton;
    Button_Screenshot: TButton;
    CheckBox_TakeOff: TCheckBox;
    ColorBox_BgColor: TColorBox;
    ColorBox_FrColor: TColorBox;
    ComboBox1: TComboBox;
    Edit4: TEdit;
    Edit5: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl2: TPageControl;
    SavePictureDialog1: TSavePictureDialog;
    ScrollBox1: TScrollBox;
    StaticText1: TStaticText;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Timer1: TTimer;
    TimerExplosion: TTimer;
    TrackBar_Particle: TTrackBar;
    TrackBar_Range: TTrackBar;
    TrackBar_Ex_Delay: TTrackBar;
    TrackBar_Anim_Delay: TTrackBar;
    procedure Button_PauseClick(Sender: TObject);
    procedure Button_ScreenshotClick(Sender: TObject);
    procedure Button_AnimApplyClick(Sender: TObject);
    procedure Button_FireApplyClick(Sender: TObject);
    procedure Button_BgApplyClick(Sender: TObject);
    procedure buttonPlayClick(Sender: TObject);
    procedure CheckBox_TakeOffChange(Sender: TObject);
    procedure ColorBox_FrColorChange(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

    procedure FireworkExplosion();
    procedure ClearCanvas();
    procedure TimerExplosionTimer(Sender: TObject);
    procedure TrackBar_RangeChange(Sender: TObject);
    procedure TrackBar_ParticleChange(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

uses
  Math, Windows;

var
  x, y : integer;
  Ty   : integer;
  ExplosionLoop : Integer = 30;
  BgColor : string = 'clNavy';
  Particle : integer = 50;
  FrColor : string = 'clYellow';
  Range : integer = 50 ;
  Speed : integer = 1;
  Ex_Delay : integer = 500;
  Anim_Delay : integer = 500;
  TakeOff : boolean = True;

procedure TForm1.FormCreate(Sender: TObject);
var
  i, j : integer;

begin
  image1.Canvas.brush.color := clWhite;
  Image1.Canvas.FillRect(0, 0, Image1.Canvas.Width, Image1.Canvas.Height); 
  Image1.Canvas.FillRect(0, 0, Image1.Canvas.Width, Image1.Canvas.Height);
  x  := image1.Width div 2;
  y  := image1.Height;
  Ty := -50;
  image1.Canvas.Pen.Color:=clWhite;
  image1.Canvas.Brush.Color:=clWhite;
  image1.Canvas.Rectangle(0,0,image1.Width,image1.Height);
  Timer1.Enabled := false;

end;

procedure TForm1.Label6Click(Sender: TObject);
begin

end;

procedure TForm1.buttonPlayClick(Sender: TObject);
begin
  Timer1.Enabled := true;
  Timer1Timer(Sender);
end;

procedure TForm1.CheckBox_TakeOffChange(Sender: TObject);
begin
  TakeOff := CheckBox_TakeOff.Checked;
end;

procedure TForm1.ColorBox_FrColorChange(Sender: TObject);
begin

end;

procedure TForm1.Button_BgApplyClick(Sender: TObject);
begin
  Image1.Canvas.Brush.Color := ColorBox_BgColor.Selected;
  Image1.Canvas.FillRect(0, 0, Image1.Canvas.Width, Image1.Canvas.Height);
  Image1.Canvas.FillRect(0, 0, Image1.Canvas.Width, Image1.Canvas.Height);
end;

procedure TForm1.Button_FireApplyClick(Sender: TObject);
begin
  Particle := TrackBar_Particle.Position;
  FrColor := ColorBox_FrColor.Text;
  Range := TrackBar_Range.Position;
end;

procedure TForm1.Button_AnimApplyClick(Sender: TObject);
begin
  Speed := ComboBox1.ItemIndex;
  Ex_Delay := TrackBar_Ex_Delay.Position;
  Anim_Delay := TrackBar_Anim_Delay.Position;
end;

procedure TForm1.Button_ScreenshotClick(Sender: TObject);
begin
  Button_Pause.Enabled := False;
  Button_Play.Enabled := True;
  Button_PauseClick(nil);
  if SavePictureDialog1.Execute then
  begin
    image1.Picture.SaveToFile(SavePictureDialog1.FileName);
  end;
end;

procedure TForm1.Button_PauseClick(Sender: TObject);
begin
   Timer1.Enabled := False;
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Button_BgApplyClick(nil);
  if TakeOff then
    y := y + Ty;
    //gambar grafik
    image1.Canvas.Brush.Color := clBlack;
    image1.Canvas.Pen.Color := clBlack;
    image1.Canvas.Pen.Style := psSolid;
    image1.Canvas.Ellipse(x,y - 25,x + 20,y + 25);

    if y <= 150 then
    begin
      y  := image1.Height;
      Button_BgApplyClick(nil);
    end;



end;

procedure TForm1.FireworkExplosion();
begin
  TimerExplosion.Enabled := True;
end;

procedure TForm1.ClearCanvas();
begin
  Image1.Canvas.Brush.Color := ColorBox_BgColor.Selected;
  Image1.Canvas.FillRect(0, 0, Image1.Canvas.Width, Image1.Canvas.Height);
  Image1.Canvas.FillRect(0, 0, Image1.Canvas.Width, Image1.Canvas.Height);
end;

procedure TForm1.TimerExplosionTimer(Sender: TObject);
type
  Particle = record
    X, Y : Integer;
    Radius, Rotation, Gravity, YVelocity : Single;
    Color : array [0..2] of Integer;
  end;

var
  Particles : array [0..19] of Particle;
  MidX, MidY : Integer;
  i, j : Integer;

begin
  MidX := Image1.Canvas.Width div 2;
  MidY := Image1.Canvas.Height div 2;


                        
//  TODO : Create explosion animation.

//  Testing ...
  for i:=0 to 20 do
  begin
    for j:=0 to 20 do
    begin
      Image1.Canvas.Pixels[ExplosionLoop+i,ExplosionLoop+j] := RGB(0,0,0);
    end;
  end;


  ExplosionLoop += 2;

  if ExplosionLoop = 30 then TimerExplosion.Enabled := False;
//  ... TTimer.
end;

procedure TForm1.TrackBar_RangeChange(Sender: TObject);
begin

end;

procedure TForm1.TrackBar_ParticleChange(Sender: TObject);
begin

end;

end.

