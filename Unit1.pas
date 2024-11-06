unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtDlgs, System.ImageList,
  Vcl.ImgList, Vcl.Buttons, Vcl.ExtCtrls,Jpeg, Vcl.CategoryButtons,
  Vcl.ButtonGroup, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.Menus, System.Skia, Vcl.Skia, System.UITypes, ShellAPI,Winapi.ActiveX, System.Win.ComObj,
  Vcl.FileCtrl;

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
    SPD: TSavePictureDialog;
    EdtWidth: TEdit;
    EdtHeight: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Edycja1: TMenuItem;
    Plik1: TMenuItem;
    Close: TMenuItem;
    Zmniejszrozmiarzdjcia1: TMenuItem;
    OpenImage: TMenuItem;
    EdtPathImgLoad: TEdit;
    SbutLoadImg: TSpeedButton;
    FileListBox: TFileListBox;
    EditNameImg: TEdit;
    Panel3: TPanel;
    StatusBar: TStatusBar;
    SpeedButton1: TSpeedButton;
    SaveimgFolder: TMenuItem;
    EditSaveFolderImg: TEdit;
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Informacja1Click(Sender: TObject);
    procedure Zmniejszrozmiarzdjcia1Click(Sender: TObject);
    procedure OpenImageClick(Sender: TObject);
    procedure SbutLoadImgClick(Sender: TObject);
    procedure FileListBoxClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SaveimgFolderClick(Sender: TObject);



  private
  //Nazwa zdjęcia
  procedure ChangeNameImg;
  //Folder zapisu zdjęcia
  procedure FolderSaveImg;
  //Konwersja Zdjęcia
  procedure ConvertBaseIMG(InputPath, OutputPath, NameImg, NameFormat: string; QualityIMG: Integer);
  //Konwersja BMP w JPG
  procedure ConvertBmpToJPG(Image: TImage; FilePath: string; SavePath: string);
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
  //Zmień rozmiar zdjęcia
  procedure ResizeImg;
  function GetResizedImage(const AImage: ISkImage; const ANewWidth, ANewHeight: Integer): ISkImage;
  procedure OpenImg;
  //metoda rozbudowana konwertacja zdjęcia na podstawie rozszezenia
  procedure ChooseExtension;
  //Dodawanie rozszerzeń do ComboConvert
  procedure ChooseExtensionAddToComboConvert;
  procedure ChooseExtSkia;
  procedure OpenURL(const URL: string);
    { Private declarations }
  public
    { Public declarations }
  procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
  end;

var
  Form1: TForm1;
  NameImage: string;
  PathSaveImg: string;
implementation

uses Unit2;
var
BMPPath: string;
ExtensImage: string;
WidthImg: Integer;
HeightImg: Integer;
ImageWidth, ImageHeight: Integer;

{$R *.dfm}



procedure TForm1.Button1Click(Sender: TObject);
begin
  if ComboConvert.ItemIndex = -1 then
    MessageDlg('Wybierz rozszerzenie pliku', mtInformation, [mbOk],0)
  else
    ChooseExtension;
end;


procedure TForm1.ChangeNameImg;
begin
  NameImage := EditNameImg.Text;
  if NameImage = '' then
  begin
    NameImage := 'skonwertowane';
  end
end;

procedure TForm1.ChooseExtension;
begin
  //Konwertuj JPG w PNG
  if (ExtensImage = '.jpg') and (ComboConvert.Text = 'PNG') then
    ConvertJPGToPNG(Image1,OPD.FileName);

  //Konwertuj PNG w JPG
  if (ExtensImage = '.png') and (ComboConvert.Text = 'JPG') then
    ConvertPNGToJPG(Image1,OPD.FileName);

  //Konwertuj JPG w WEBP
   if (ExtensImage = '.jpg') and (ComboConvert.Text = 'WEBP') then
    ConvertJpgToWebp(Image1,OPD.FileName);

   //Konwertuj WEBP w JPG
   if (ExtensImage = '.webp') and (ComboConvert.Text = 'JPG') then
    ConvertWebpToJpg2(Image1, PathSaveImg);

  //Konwertuj BMP w JPG
  if (ExtensImage = '.bmp') and (ComboConvert.Text = 'JPG') then
    ConvertBmpToJPG(Image1,OPD.FileName, PathSaveImg);

  //Konwertuj ICO w BMP
  if (ExtensImage = '.ico') and (ComboConvert.Text = 'BMP') then
    ConvertIcoToBmp(Icon, OPD.FileName);

  //Konwertuj PNG w WEBP
  if (ExtensImage = '.png') and (ComboConvert.Text = 'WEBP') then
    ConvertPngToWebp(Image1, OPD.FileName);

  //Konwertuj WEBP w PNG
  if (ExtensImage = '.webp') and (ComboConvert.Text = 'PNG') then
    ConvertWebpToPng(Image1, OPD.FileName);

  //Konwertuj JPEG w PNG
  if (ExtensImage = '.jpeg') and (ComboConvert.Text = 'PNG') then
    ConvertJPGToPNG(Image1,OPD.FileName);

end;

//Dodanie rozszerzeń na podstawie załadowanego pliku
procedure TForm1.ChooseExtensionAddToComboConvert;
begin
    ComboConvert.Clear;
   // Konwertuj JPG w PNG / WEBP
   if SameText(ExtensImage, '.jpg') then
   begin
     ComboConvert.Items.Add('PNG');
     ComboConvert.Items.Add('WEBP');
   end
   // Konwertuj PNG w JPG / WEBP
   else if SameText(ExtensImage, '.png') then
   begin
     ComboConvert.Items.Add('JPG');
     ComboConvert.Items.Add('WEBP');
   end
   // Konwertuj WEBP w JPG / PNG
   else if SameText(ExtensImage, '.webp') then
   begin
     ComboConvert.Items.Add('JPG');
     ComboConvert.Items.Add('PNG');
   end
   // Konwertuj BMP w JPG
   else if SameText(ExtensImage, '.bmp') then
   begin
     ComboConvert.Items.Add('JPG');
   end
   // Konwertuj ICO w BMP
   else if SameText(ExtensImage, '.ico') then
   begin
     ComboConvert.Items.Add('BMP');
   end

   // Konwertuj JPEG w PNG
   else if SameText(ExtensImage, '.jpeg') then
   begin
     ComboConvert.Items.Add('PNG');
   end;

end;

procedure TForm1.ChooseExtSkia;
begin

  //Konwertuj JPG w PNG
  if (ExtensImage = '.jpg') and (ComboConvert.Text = 'PNG') then


  //Konwertuj JPG w WEBP
  if (ExtensImage = '.jpg') and (ComboConvert.Text = 'WEBP') then


  {
   //Konwertuj PNG w JPG
  if (ExtensImage = '.png') and (ComboConvert.ItemIndex = 1) then
    ConvertPNGToJPG(Image1,OPD.FileName);
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
  }
end;

procedure TForm1.ConvertBaseIMG(InputPath, OutputPath, NameImg, NameFormat: string;
  QualityIMG: Integer);
var
LImage: ISkImage;
LFormat: TSkEncodedImageFormat;
LFullOutputPath: string;
begin
//  var LImage := TSkImage.MakeFromEncodedFile(OuputPath);
//  LImage.EncodeToFile(NameImg + 'webp', TSkEncodedImageFormat.webp , 100);
try
    // Sprawdzenie parametrów wejściowych
    if not FileExists(InputPath) then
      raise Exception.Create('Plik wejściowy nie istnieje: ' + InputPath);

    if QualityIMG < 0 then QualityIMG := 0;
    if QualityIMG > 100 then QualityIMG := 100;

    // Określenie formatu wyjściowego
    LFormat := TSkEncodedImageFormat.WEBP; // domyślnie WEBP

    // konwersja formatu
    if LowerCase(NameFormat) = 'JPG' then
      LFormat := TSkEncodedImageFormat.JPEG
    else if LowerCase(NameFormat) = 'JPEG' then
      LFormat := TSkEncodedImageFormat.JPEG
    else if LowerCase(NameFormat) = 'PNG' then
      LFormat := TSkEncodedImageFormat.PNG
    else if LowerCase(NameFormat) = 'WEBP' then
      LFormat := TSkEncodedImageFormat.WEBP
    else
      raise Exception.Create('Nieobsługiwany format: ' + NameFormat);

    // Wczytanie obrazu
    LImage := TSkImage.MakeFromEncodedFile(InputPath);
    if not Assigned(LImage) then
      raise Exception.Create('Nie udało się wczytać obrazu: ' + InputPath);

    // Przygotowanie pełnej ścieżki wyjściowej
    if not DirectoryExists(OutputPath) then
      ForceDirectories(OutputPath);
      LFullOutputPath := OutputPath + NameImg + '.' + NameFormat;
    //LFullOutputPath := TPath.Combine(OutputPath,
                                   // NameImg + '.' + LowerCase(NameFormat));

    // Zapisanie przekonwertowanego obrazu
    if not LImage.EncodeToFile(LFullOutputPath, LFormat, QualityIMG) then
      raise Exception.Create('Nie udało się zapisać obrazu: ' + LFullOutputPath);

  except
    on E: Exception do
    begin
      ShowMessage('Błąd podczas konwersji obrazu: ' + E.Message);
    end;
  end;

end;

//BMP w JPG
procedure TForm1.ConvertBmpToJPG(Image: TImage; FilePath: string; SavePath: string);
var
MyJpeg: TJpegImage;
begin
  //Zapis w folderze
  FolderSaveImg;
  //Nazwa zdjęcia
  ChangeNameImg;
  MyJpeg := TJpegImage.Create;
  try
    Image1.Picture.LoadFromFile(FilePath);
    MyJpeg .Assign(Image1.Picture.Bitmap);
    //Zapisz zdjęcie

    MyJpeg .SaveToFile(ChangeFileExt(SavePath + '\',  NameImage + '.jpg'));
    //MessageDlg('Zdjęcie przekonwertowane: ' + #13 + FilePath,TMsgDlgType.mtInformation,[mbOk],0);
    StatusBar.Panels[1].Text := 'Zdjęcie skonwertowane: ';
  finally
    MyJpeg .Free;
  end;
end;

//Icon w BMP
procedure TForm1.ConvertIcoToBmp(Icon: TIcon; FilePath: string);
var
Bitmap: TBitmap;
begin
  ChangeNameImg;
  Bitmap:= TBitmap.Create;
  try
    Icon.LoadFromFile(FilePath);
    Bitmap.Width := Icon.Width;
    Bitmap.Height := Icon.Height;
    Bitmap.Canvas.Draw(0,0,Icon);
    //Zapisz zdjęcie
    Bitmap.SaveToFile(ChangeFileExt(FilePath,'-' + NameImage + '.bmp'));
    //MessageDlg('Zdjęcie przekonwertowane: ' + #13 + FilePath,TMsgDlgType.mtInformation,[mbOk],0);
    StatusBar.Panels[1].Text := 'Zdjęcie skonwertowane: ';
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
  ChangeNameImg;
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
    PngImage.SaveToFile(ChangeFileExt(FilePath,'-' + NameImage + '.png'));
    //MessageDlg('Zdjęcie przekonwertowane: ' + #13 + FilePath,TMsgDlgType.mtInformation,[mbOk],0);
    StatusBar.Panels[1].Text := 'Zdjęcie skonwertowane: ';
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
  ChangeNameImg;
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
    PngImage.SaveToFile(ChangeFileExt(FilePath,'-' + NameImage + '.png'));
    //MessageDlg('Zdjęcie przekonwertowane: ' + #13 + FilePath,TMsgDlgType.mtInformation,[mbOk],0);
      StatusBar.Panels[1].Text := 'Zdjęcie skonwertowane: ';
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
  ChangeNameImg;
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
    SkImage.EncodeToFile(ChangeFileExt(FilePath,'-' + NameImage + '.webp'), TSkEncodedImageFormat.WEBP, 100);
    //MessageDlg('Zdjęcie przekonwertowane: ' + #13 + FilePath,TMsgDlgType.mtInformation,[mbOk],0);
    StatusBar.Panels[1].Text := 'Zdjęcie skonwertowane: ';
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
  ChangeNameImg;
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
    JpegImage.SaveToFile(ChangeFileExt(FilePath,'-' + NameImage + '.jpg'));
    //MessageDlg('Zdjęcie przekonwertowane: ' + #13 + FilePath,TMsgDlgType.mtInformation,[mbOk],0);
    StatusBar.Panels[1].Text := 'Zdjęcie skonwertowane: ';
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
  ChangeNameImg;
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
    SkImage.EncodeToFile(ChangeFileExt(FilePath,'-' + NameImage + '.webp'), TSkEncodedImageFormat.WEBP, 100);
    //MessageDlg('Zdjęcie skonwertowane: ' + #13 + FilePath,TMsgDlgType.mtInformation,[mbOk],0);
    StatusBar.Panels[1].Text := 'Zdjęcie skonwertowane: ';
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
  ChangeNameImg;
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
    JpegImage.SaveToFile(ChangeFileExt(FilePath,'-' + NameImage + '.jpg'));
    //MessageDlg('Zdjęcie przekonwertowane: ' + #13 + FilePath,TMsgDlgType.mtInformation,[mbOk],0);
    StatusBar.Panels[1].Text := 'Zdjęcie skonwertowane: ';
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
  ChangeNameImg;
  PngImage := TPNGImage.Create;
  Image1.Picture.LoadFromFile(FilePath); // No error
  Bitmap := TBitmap.Create;
  try
    Bitmap.Width:=Image1.Picture.Width;
    Bitmap.Height:=Image1.Picture.Height;
    Bitmap.Canvas.Draw(0,0,Image1.Picture.Graphic);
    // Zapisanie obrazu jako PNG
    PngImage.Assign(Bitmap);
    PngImage.SaveToFile(ChangeFileExt(FilePath,'-' + NameImage +  '.png'));
    //MessageDlg('Zdjęcie przekonwertowane: ' + #13 + FilePath,TMsgDlgType.mtInformation,[mbOk],0);
    StatusBar.Panels[1].Text := 'Zdjęcie skonwertowane: ';
  finally
    Bitmap.Free;
    PngImage.Free;
  end;
end;


procedure TForm1.FileListBoxClick(Sender: TObject);
var
  fileName: string;
begin
  // Pobieranie pełnej ścieżki pliku z FileListBox
  fileName := FileListBox.FileName;

  // Sprawdzenie, czy plik istnieje
  if FileExists(fileName) then
  begin
    try
      // Ładowanie obrazu z pliku
      Image1.Picture.LoadFromFile(fileName);

      // Pobieranie rozszerzenia pliku
      ExtensImage := ExtractFileExt(fileName);

      // Pobieranie szerokości i wysokości obrazu
      ImageWidth := Image1.Picture.Width;
      ImageHeight := Image1.Picture.Height;

      // Aktualizacja wartości w EdtWidth i EdtHeight
      EdtWidth.Text := IntToStr(ImageWidth);
      EdtHeight.Text := IntToStr(ImageHeight);

      // Dodawanie odpowiednich rozszerzeń do ComboConvert
      ChooseExtensionAddToComboConvert;

      // Aktualizacja statusu na pasku stanu
      StatusBar.Panels[0].Text := Format('Info: %s | Rozmiar: %d x %d px', [ExtensImage, ImageWidth, ImageHeight]);
    except
      on E: Exception do
        ShowMessage('Błąd przy ładowaniu obrazu: ' + E.Message);
    end;
  end
  else
    ShowMessage('Plik nie istnieje: ' + fileName);
end;

procedure TForm1.FolderSaveImg;
begin
   PathSaveImg := EditSaveFolderImg.Text;
   if PathSaveImg = '' then
   begin
   //ShowMessage('brak ścieżki');
   PathSaveImg := Opd.FileName;
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //Nazwa zdjęcia
  //FolderSaveImg;
  ChangeNameImg;
  FileListBox.Directory := 'C:\Users\';
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

procedure TForm1.OpenImageClick(Sender: TObject);
begin
  OpenImg;
end;

procedure TForm1.OpenImg;
begin
 if OPD.Execute then
  begin

    Image1.Picture.LoadFromFile(OPD.FileName);
    ExtensImage := ExtractFileExt(OPD.FileName);
    //LabeZ.Caption := 'Z '+ ExtensImage;
    // Uzyskiwanie rozmiarów obrazu
    ImageWidth := Image1.Picture.Width;
    ImageHeight := Image1.Picture.Height;

    EdtWidth.Text := IntToStr(ImageWidth);
    EdtHeight.Text := IntToStr(ImageHeight);
    // Wyświetlanie informacji o obrazie w etykiecie
    //LabeInfoImage.Caption := Format('%s | Rozmiar: %d x %d px', [ExtensImage, ImageWidth, ImageHeight]);
    StatusBar.Panels[0].Text := 'Info: ' + Format('%s | Rozmiar: %d x %d px', [ExtensImage, ImageWidth, ImageHeight]);
    //Dodawanie rozszerzeń do ComboConvert
    ChooseExtensionAddToComboConvert;
    //Lista zdjęć
     FileListBox.Directory := OPD.FileName;
  end;
end;

procedure TForm1.OpenURL(const URL: string);
begin
  ShellExecute(0, 'OPEN', PChar(URL), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.ResizeImg;
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

procedure TForm1.SaveimgFolderClick(Sender: TObject);
begin
   if SelectDirectory('Wybierz katalog','',PathSaveImg) then
    begin
      EditSaveFolderImg.Text := PathSaveImg;
    end;
end;

procedure TForm1.SbutLoadImgClick(Sender: TObject);
begin
  FileListBox.Directory := EdtPathImgLoad.Text;
  //Image1.Picture.LoadFromFile(FileListBox.FileName);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  OpenURL(OPD.FileName);
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  OpenImg;
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
  Image1.Picture := nil;
  LabeZ.Caption := 'Z ';
  //LabeInfoImage.Caption := 'Info';
  StatusBar.Panels[0].Text := Format('Info: %s | Rozmiar: %d x %d px', [ExtensImage, ImageWidth, ImageHeight]);
  EdtWidth.Text := '';
  EdtHeight.Text := '';
  ComboConvert.Clear;
end;


procedure TForm1.WMDropFiles(var Msg: TWMDropFiles);
begin
  inherited;
  ShowMessage('Drop file')
end;

procedure TForm1.Zmniejszrozmiarzdjcia1Click(Sender: TObject);
begin
  ResizeImg;
end;

end.
