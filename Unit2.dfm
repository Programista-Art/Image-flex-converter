object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Informacja'
  ClientHeight = 248
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
    Top = 220
    Width = 310
    Height = 28
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 216
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
    Height = 220
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 216
    object TabSheet1: TTabSheet
      Caption = 'Autor'
      object RichEditAutor: TRichEdit
        Left = 0
        Top = 0
        Width = 302
        Height = 161
        Align = alTop
        Alignment = taCenter
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        Lines.Strings = (
          ''
          'Program stworzy'#322' Programista Art'
          '27.10.2024'
          'Sklep'
          'www.programista.art'
          'Portfolio'
          'dimitalart.pl')
        ParentFont = False
        PopupMenu = PopupMenuMemo
        ReadOnly = True
        TabOrder = 0
      end
      object Panel2: TPanel
        Left = 0
        Top = 161
        Width = 302
        Height = 29
        Align = alClient
        TabOrder = 1
        ExplicitTop = 145
        ExplicitHeight = 41
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Informacja'
      ImageIndex = 1
      object RichEditInformacja: TRichEdit
        Left = 0
        Top = 0
        Width = 302
        Height = 190
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
          'ICO w BMP'
          'PNG w WEBP'
          'WEBP w PNG'
          'JPEG w  PNG')
        ParentFont = False
        PopupMenu = PopupMenuMemo
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitHeight = 229
      end
    end
  end
  object PopupMenuMemo: TPopupMenu
    Left = 140
    Top = 186
    object Kopiuj1: TMenuItem
      Caption = 'Kopiuj'
      OnClick = Kopiuj1Click
    end
  end
end
