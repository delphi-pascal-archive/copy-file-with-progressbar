object Form1: TForm1
  Left = 214
  Top = 126
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Copy file with ProgressBar'
  ClientHeight = 105
  ClientWidth = 466
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 10
    Top = 16
    Width = 46
    Height = 16
    Caption = 'Source:'
  end
  object Label2: TLabel
    Left = 10
    Top = 48
    Width = 70
    Height = 16
    Caption = 'Destination:'
  end
  object Edit1: TEdit
    Left = 72
    Top = 8
    Width = 297
    Height = 24
    Enabled = False
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 88
    Top = 40
    Width = 281
    Height = 24
    Enabled = False
    TabOrder = 1
  end
  object Button1: TButton
    Left = 8
    Top = 72
    Width = 97
    Height = 25
    Caption = 'Copy'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 376
    Top = 8
    Width = 81
    Height = 25
    Caption = 'Open ...'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 376
    Top = 40
    Width = 81
    Height = 25
    Caption = 'Open ...'
    TabOrder = 4
    OnClick = Button3Click
  end
  object ProgressBar1: TProgressBar
    Left = 112
    Top = 72
    Width = 345
    Height = 25
    TabOrder = 5
  end
  object OpenDialog1: TOpenDialog
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 264
    Top = 16
  end
  object SaveDialog1: TSaveDialog
    Left = 296
    Top = 16
  end
end
