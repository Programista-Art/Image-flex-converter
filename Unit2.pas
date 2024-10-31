unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Menus;

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
    procedure ButtonOKClick(Sender: TObject);
    procedure Kopiuj1Click(Sender: TObject);
    procedure PMenu(NamePage: TPageControl);
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

procedure TForm2.Kopiuj1Click(Sender: TObject);
begin
  PMenu(PageControl1);
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

end.
