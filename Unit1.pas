unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtDlgs, System.ImageList,
  Vcl.ImgList, Vcl.Buttons, Vcl.ExtCtrls,Jpeg, Vcl.CategoryButtons,
  Vcl.ButtonGroup, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.Menus, System.Skia, Vcl.Skia, System.UITypes;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    ImageList1: TImageList;
    OPD: TOpenPictureDialog;
    Image1: TImage;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    Panel2: TPanel;
    ComboConvert: TComboBox;
    Label1: TLabel;
    Button1: TButton;
    LabeZ: TLabel;
    MainMenu: TMainMenu;
    Informacja1: TMenuItem;
    Button2: TButton;
    SPD: TSavePictureDialog;
    EdtWidth: TEdit;
    EdtHeight: TEdit;
    LabeInfoImage: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button3: TButton;
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Informacja1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
  //Konwersja BMP w JPG
  procedure ConvertBmpToJPG(Image: TImage; FilePath: string);
  //Konwersja ICO w BMP
  procedure ConvertIcoToBmp(Icon: TIcon; FilePath: string);
  //Konwersja JPG w PNG
  procedure ConvertJPGToPNG(Image: TImage; FilePath: string);
  //Konwersja PNG w JPG
  procedure ConvertPNGToJPG(Image: TImage; FilePath: string);
  //Konwersja WEBP w JPG
  procedure ConvertWebpToJpg2(Image: TImage; FilePath: string);
  //Konwersja JPG w WEBP
  procedure ConvertJpgToWebp(Image: TImage; FilePath: string);
  //Konwersja PNG w WEBP
  procedure ConvertPngToWebp(Image: TImage; FilePath: string);
  //Konwersja WEBP w PNG
  procedure ConvertWebpToPng(Image: TImage; FilePath: string);
  //Konwersja Jpeg w PNG
  procedure ConvertJpegToPNG(Image: TImage; FilePath: string);
  //Testowa
  procedure ConvertJpgToWebpTets;
  function GetResizedImage(const AImage: ISkImage; const ANewWidth, ANewHeight: Integer): ISkImage;

  procedure ChooseExtension;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2;
var
BMPPath: string;
ExtensImage: string;
WidthImg: Integer;
HeightImg: Integer;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
if ComboConvert.ItemIndex = -1 then
  MessageDlg('Wybierz rozszerzenie pliku', mtInformation, [mbOk],0)
  //ConvertBmpToJPG(Image1, OPD.FileName);
  else
    ChooseExtension;
//if Image1.Picture = nil then
//    MessageDlg('Brak zdjęcia', mtInformation, [mbOk],0)
//else
//    ChooseExtension;
end;


procedure TForm1.Button2Click(Sender: TObject);
var
  LImage: ISkImage;
  NewFileName: string;
begin
    WidthImg := StrToInt(EdtWidth.Text);
    HeightImg := StrToInt(EdtHeight.Text);

    LImage := TSkImage.MakeFromEncodedFile(OPD.FileName);
    // Skalowanie obrazu do rozmiaru WidthImg x HeightImg
    LImage := GetResizedImage(LImage, WidthImg, HeightImg);
    // LImage.EncodeToFile(OPD.FileName + 'zmn'+'.jpg');
    // Konstruowanie nowej nazwy pliku z rozmiarem
    NewFileName := ChangeFileExt(OPD.FileName,Format('_%dx%d.jpg', [WidthImg, HeightImg]));
    // Zapisywanie przeskalowanego obrazu do nowego pliku z rozmiarem w nazwie
    LImage.EncodeToFile(NewFileName);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ConvertJpgToWebpTets;
end;

procedure TForm1.ChooseExtension;
begin
  //Konwertuj JPG w PNG
  if (ExtensImage = '.jpg') and (ComboConvert.ItemIndex = 0) then
    ConvertJPGToPNG(Image1,OPD.FileName);

  //Konwertuj PNG w JPG
  if (ExtensImage = '.png') and (ComboConvert.ItemIndex = 1) then
    ConvertPNGToJPG(Image1,OPD.FileName);

  //Konwertuj JPG w WEBP
   if (ExtensImage = '.jpg') and (ComboConvert.ItemIndex = 2) then
    ConvertJpgToWebp(Image1,OPD.FileName);

   //Konwertuj WEBP w JPG
   if (ExtensImage = '.webp') and (ComboConvert.ItemIndex = 3) then
    ConvertWebpToJpg2(Image1, OPD.FileName);

  //Konwertuj BMP w JPG
  if (ExtensImage = '.bmp') and (ComboConvert.ItemIndex = 4) then
    ConvertBmpToJPG(Image1, OPD.FileName);

  //Konwertuj ICO w BMP
  if (ExtensImage = '.ico') and (ComboConvert.ItemIndex = 5) then
    ConvertIcoToBmp(Icon, OPD.FileName);

  //Konwertuj PNG w WEBP
  if (ExtensImage = '.png') and (ComboConvert.ItemIndex = 6) then
    ConvertPngToWebp(Image1, OPD.FileName);

  //Konwertuj WEBP w PNG
  if (ExtensImage = '.webp') and (ComboConvert.ItemIndex = 7) then
    ConvertWebpToPng(Image1, OPD.FileName);

  //Konwertuj JPEG w PNG
  if (ExtensImage = '.jpeg') and (ComboConvert.ItemIndex = 8) then
    ConvertJPGToPNG(Image1,OPD.FileName);

end;

//BMP w JPG
procedure TForm1.ConvertBmpToJPG(Image: TImage; FilePath: string);
var
MyJpeg: TJpegImage;
begin
  MyJpeg := TJpegImage.Create;
  try
    Image1.Picture.LoadFromFile(FilePath);
    MyJpeg .Assign(Image1.Picture.Bitmap);
    //Zapisz zdjęcie
    MyJpeg .SaveToFile(ChangeFileExt(FilePath,'-przekonwertowane' + '.jpg'));
    MessageDlg('Zdjęcie przekonwertowane: ' + #13 + FilePath,TMsgDlgType.mtInformation,[mbOk],0);
  finally
    MyJpeg .Free;
  end;
end;

//Icon w BMP
procedure TForm1.ConvertIcoToBmp(Icon: TIcon; FilePath: string);
var
Bitmap: TBitmap;
begin
  Bitmap:= TBitmap.Create;
  try
    Icon.LoadFromFile(FilePath);
    Bitmap.Width := Icon.Width;
    Bitmap.Height := Icon.Height;
    Bitmap.Canvas.Draw(0,0,Icon);
    //Zapisz zdjęcie
    Bitmap.SaveToFile(ChangeFileExt(FilePath,'-przekonwertowane' + '.bmp'));
    MessageDlg('Zdjęcie przekonwertowane: ' + #13 + FilePath,TMsgDlgType.mtInformation,[mbOk],0);
  finally
    Bitmap.Free;
  end;
end;


procedure TForm1.ConvertJpegToPNG(Image: TImage; FilePath: string);
var
  JpegImage: TJPEGImage;
  PngImage: TPngImage;
  Bitmap: TBitmap;
begin
  JpegImage := TJPEGImage.Create;
  PngImage := TPngImage.Create;
  Bitmap := TBitmap.Create;
  try
    // Wczytanie pliku JPG
    JpegImage.LoadFromFile(FilePath);
    // Przekształcenie JPEG do Bitmapy
    Bitmap.Assign(JpegImage);
    // Przekształcenie Bitmapy do PNG
    PngImage.Assign(Bitmap);
    // Zapisanie obrazu jako PNG
    PngImage.SaveToFile(ChangeFileExt(FilePath, '-przekonwertowane' + '.png'));
    MessageDlg('Zdjęcie przekonwertowane: ' + #13 + FilePath,TMsgDlgType.mtInformation,[mbOk],0);
  finally
    JpegImage.Free;
    PngImage.Free;
    Bitmap.Free;
  end;
end;

//JPG w PNG
procedure TForm1.ConvertJPGToPNG(Image: TImage; FilePath: string);
var
  JpegImage: TJPEGImage;
  PngImage: TPngImage;
  Bitmap: TBitmap;
begin
  JpegImage := TJPEGImage.Create;
  PngImage := TPngImage.Create;
  Bitmap := TBitmap.Create;
  try
    // Wczytanie pliku JPG
    JpegImage.LoadFromFile(FilePath);
    // Przekształcenie JPEG do Bitmapy
    Bitmap.Assign(JpegImage);
    // Przekształcenie Bitmapy do PNG
    PngImage.Assign(Bitmap);
    // Zapisanie obrazu jako PNG
    PngImage.SaveToFile(ChangeFileExt(FilePath, '-przekonwertowane' + '.png'));
    MessageDlg('Zdjęcie przekonwertowane: ' + #13 + FilePath,TMsgDlgType.mtInformation,[mbOk],0);
  finally
    JpegImage.Free;
    PngImage.Free;
    Bitmap.Free;
  end;
end;

procedure TForm1.ConvertJpgToWebp(Image: TImage; FilePath: string);
var
Bitmap: TBitmap;
JpegImage: TJPEGImage;
SkImage: ISkImage;
begin
  JpegImage := TJPEGImage.Create;
  Bitmap := TBitmap.Create;
  try
    // Wczytanie pliku JPG
    JpegImage.LoadFromFile(FilePath);

    // Przekształcenie JPEG do Bitmapy
    Bitmap.Assign(JpegImage);

    // Przekształcenie Bitmapy na SkImage
    SkImage := Bitmap.ToSkImage;

    // Zapisanie obrazu jako WebP
    SkImage.EncodeToFile(ChangeFileExt(FilePath,'-przekonwertowane' + '.webp'), TSkEncodedImageFormat.WEBP, 100);
    MessageDlg('Zdjęcie przekonwertowane: ' + #13 + FilePath,TMsgDlgType.mtInformation,[mbOk],0);
  finally
    JpegImage.Free;
    Bitmap.Free;
  end;
end;

procedure TForm1.ConvertJpgToWebpTets;
begin
  var LImage := TSkImage.MakeFromEncodedFile(OPD.FileName);
  //LImage.EncodeToFile('output.webp', TSkEncodedImageFormat.WEBP, 100);
  //LImage.EncodeToFile('output.jpg', TSkEncodedImageFormat.JPEG, 100);

  LImage.EncodeToFile('output.bmp', TSkEncodedImageFormat.BMP, 100);
  {
  LImage.EncodeToFile('output.gif', TSkEncodedImageFormat.GIF, 100);
  LImage.EncodeToFile('output.ico', TSkEncodedImageFormat.ICO, 100);
  LImage.EncodeToFile('output.png', TSkEncodedImageFormat.PNG, 100);

  LImage.EncodeToFile('output.dng', TSkEncodedImageFormat.DNG, 100);
  LImage.EncodeToFile('output.cr2', TSkEncodedImageFormat.ASTC, 100);
  LImage.EncodeToFile('output.wbmp', TSkEncodedImageFormat.WBMP, 100);
  LImage.EncodeToFile('output.pkm', TSkEncodedImageFormat.PKM, 100);
  LImage.EncodeToFile('output.ktx', TSkEncodedImageFormat.KTX, 100);
  LImage.EncodeToFile('output.heif', TSkEncodedImageFormat.HEIF, 100);

  LImage.EncodeToFile('output.avif', TSkEncodedImageFormat.AVIF, 100);
 }
end;

//Png w JPG
procedure TForm1.ConvertPNGToJPG(Image: TImage; FilePath: string);
var
  JpegImage: TJPEGImage;
  PngImage: TPngImage;
  Bitmap: TBitmap;
begin
  JpegImage := TJPEGImage.Create;
  PngImage := TPngImage.Create;
  Bitmap := TBitmap.Create;
  try
    // Wczytanie pliku PNG
    PngImage.LoadFromFile(FilePath);
    // Przekształcenie PNG do Bitmapy
    Bitmap.Assign(PngImage);
    // Przekształcenie Bitmapy do JPG
    JpegImage.Assign(Bitmap);
    // Zapisanie obrazu jako PNG
    JpegImage.SaveToFile(ChangeFileExt(FilePath, '-przekonwertowane' + '.jpg'));
    MessageDlg('Zdjęcie przekonwertowane: ' + #13 + FilePath,TMsgDlgType.mtInformation,[mbOk],0);
  finally
    JpegImage.Free;
    PngImage.Free;
    Bitmap.Free;
  end;
end;


procedure TForm1.ConvertPngToWebp(Image: TImage; FilePath: string);
var
Bitmap: TBitmap;
PngImage: TPNGImage;
SkImage: ISkImage;
begin
  PngImage := TPNGImage.Create;
  Bitmap := TBitmap.Create;
  try
    // Wczytanie pliku JPG
    PngImage.LoadFromFile(FilePath);

    // Przekształcenie JPEG do Bitmapy
    Bitmap.Assign(PngImage);

    // Przekształcenie Bitmapy na SkImage
    SkImage := Bitmap.ToSkImage;

    // Zapisanie obrazu jako WebP
    SkImage.EncodeToFile(ChangeFileExt(FilePath,'-przekonwertowane' + '.webp'), TSkEncodedImageFormat.WEBP, 100);
    MessageDlg('Zdjęcie przekonwertowane: ' + #13 + FilePath,TMsgDlgType.mtInformation,[mbOk],0);
  finally
    PngImage.Free;
    Bitmap.Free;
  end;
end;

procedure TForm1.ConvertWebpToJpg2(Image: TImage; FilePath: string);
var
  Bitmap: TBitmap;
  JpegImage: TJPEGImage;
begin
  JpegImage := TJPEGImage.Create;
  Image1.Picture.LoadFromFile(FilePath); // No error
  Bitmap := TBitmap.Create;
  try
    //Bitmap.Assign(Image1.Picture.Graphic); // Error for webp files
    Bitmap.Width:=Image1.Picture.Width;
    Bitmap.Height:=Image1.Picture.Height;
    Bitmap.Canvas.Draw(0,0,Image1.Picture.Graphic);
    // Zapisanie obrazu jako JPG
    JpegImage.Assign(Bitmap);
    JpegImage.SaveToFile(ChangeFileExt(FilePath,'-przekonwertowane' +  '.jpg'));
    MessageDlg('Zdjęcie przekonwertowane: ' + #13 + FilePath,TMsgDlgType.mtInformation,[mbOk],0);
  finally
    Bitmap.Free;
    JpegImage.Free;
  end;
end;

procedure TForm1.ConvertWebpToPng(Image: TImage; FilePath: string);
var
  Bitmap: TBitmap;
  PngImage: TPNGImage;
begin
  PngImage := TPNGImage.Create;
  Image1.Picture.LoadFromFile(FilePath); // No error
  Bitmap := TBitmap.Create;
  try
    Bitmap.Width:=Image1.Picture.Width;
    Bitmap.Height:=Image1.Picture.Height;
    Bitmap.Canvas.Draw(0,0,Image1.Picture.Graphic);
    // Zapisanie obrazu jako PNG
    PngImage.Assign(Bitmap);
    PngImage.SaveToFile(ChangeFileExt(FilePath,'-przekonwertowane' +  '.png'));
    MessageDlg('Zdjęcie przekonwertowane: ' + #13 + FilePath,TMsgDlgType.mtInformation,[mbOk],0);
  finally
    Bitmap.Free;
    PngImage.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);

begin

end;

//Zmienia rozmiar zdjęcia
function TForm1.GetResizedImage(const AImage: ISkImage; const ANewWidth,
  ANewHeight: Integer): ISkImage;
var
LSurface: ISkSurface;
begin
  LSurface := TSkSurface.MakeRaster(ANewWidth, ANewHeight);
  LSurface.Canvas.Clear(TAlphaColors.Null);
  LSurface.Canvas.Scale(ANewWidth / AImage.Width, ANewHeight / AImage.Height);
  LSurface.Canvas.DrawImage(AImage, 0, 0, TSkSamplingOptions.High);
  Result := LSurface.MakeImageSnapshot;
end;

procedure TForm1.Informacja1Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
var
ImageWidth, ImageHeight: Integer;
begin
  if OPD.Execute then
  begin
    Image1.Picture.LoadFromFile(OPD.FileName);
    ExtensImage := ExtractFileExt(OPD.FileName);
    LabeZ.Caption := 'Z '+ ExtensImage;
    // Uzyskiwanie rozmiarów obrazu
    ImageWidth := Image1.Picture.Width;
    ImageHeight := Image1.Picture.Height;

    EdtWidth.Text := IntToStr(ImageWidth);
    EdtHeight.Text := IntToStr(ImageHeight);
    // Wyświetlanie informacji o obrazie w etykiecie
    LabeInfoImage.Caption := Format('%s | Rozmiar: %d x %d px', [ExtensImage, ImageWidth, ImageHeight]);
  end;
end;


procedure TForm1.ToolButton3Click(Sender: TObject);
begin
  Image1.Picture := nil;
  LabeZ.Caption := 'Z ';
  LabeInfoImage.Caption := 'Info';
  EdtWidth.Text := '';
  EdtHeight.Text := '';
end;

end.
