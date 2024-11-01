unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Menus, System.Skia, Vcl.Skia, ShellApi;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    ButtonOK: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    RichEditAutor: TRichEdit;
    RichEditInformacja: TRichEdit;
    Panel2: TPanel;
    PopupMenuMemo: TPopupMenu;
    Kopiuj1: TMenuItem;
    SkSvg1: TSkSvg;
    procedure ButtonOKClick(Sender: TObject);
    procedure Kopiuj1Click(Sender: TObject);
    procedure PMenu(NamePage: TPageControl);
    procedure LoadImg;
    procedure FormCreate(Sender: TObject);
    procedure SkSvg1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses Unit1;

procedure TForm2.ButtonOKClick(Sender: TObject);
begin
  Close;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  LoadImg;
end;

procedure TForm2.Kopiuj1Click(Sender: TObject);
begin
  PMenu(PageControl1);
end;

procedure TForm2.LoadImg;
var
  SvgFilePath: string;
  FileStream: TFileStream;
  StringList: TStringList;
begin
try
    SvgFilePath := ExtractFilePath(Application.ExeName) + 'fb.svg';

    if not FileExists(SvgFilePath) then
    begin
      ShowMessage('Nie znaleziono pliku ikony: ikonka.svg');
      Exit;
    end;

    StringList := TStringList.Create;
    try
      StringList.LoadFromFile(SvgFilePath);
      SkSvg1.SVG.Source := StringList.Text;
      SkSvg1.Parent := Self;
    finally
      StringList.Free;
    end;

  except
    on E: Exception do
      ShowMessage('B³¹d podczas ³adowania ikony: ' + E.Message);
  end;
end;

procedure TForm2.PMenu(NamePage: TPageControl);
begin
  if NamePage.TabIndex = 0 then
  begin
    RichEditAutor.CopyToClipboard;
  end;
    if NamePage.TabIndex = 1 then
  begin
    RichEditInformacja.CopyToClipboard;
  end;
end;

procedure TForm2.SkSvg1Click(Sender: TObject);
var
URL: string;
begin
  URL := 'https://www.facebook.com/profile.php?id=61563368962907';
  ShellExecute(0, 'OPEN', PChar(URL), nil, nil, SW_SHOWNORMAL);
end;

end.
