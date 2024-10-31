object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Informacja'
  ClientHeight = 244
  ClientWidth = 310
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 216
    Width = 310
    Height = 28
    Align = alBottom
    TabOrder = 0
    object ButtonOK: TButton
      Left = 234
      Top = 1
      Width = 75
      Height = 26
      Align = alRight
      Caption = 'Ok'
      TabOrder = 0
      OnClick = ButtonOKClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 310
    Height = 216
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Autor'
      object RichEdit1: TRichEdit
        Left = 0
        Top = 0
        Width = 302
        Height = 186
        Align = alClient
        Alignment = taCenter
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        Lines.Strings = (
          'Program stworzy'#322' Programista Art'
          '27.10.2024'
          'https://dimitalart.pl/')
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Informacja'
      ImageIndex = 1
      object RichEdit2: TRichEdit
        Left = 0
        Top = 0
        Width = 302
        Height = 186
        Align = alClient
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        Lines.Strings = (
          'Konwertuj'
          'JPG w  PNG'
          'PNG w JPG'
          'JPG w WEBP'
          'WEBP w JPG'
          'BMP w JPG'
          'ICO w BMP')
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
    end
  end
end
