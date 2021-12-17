object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 661
  ClientWidth = 804
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 53
    Width = 600
    Height = 600
  end
  object Label1: TLabel
    Left = 104
    Top = 14
    Width = 402
    Height = 33
    Caption = 'VISOR 3D / AGUA DE PUEBLA'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 614
    Top = 53
    Width = 185
    Height = 450
    Color = clGreen
    ParentBackground = False
    TabOrder = 0
    object Button1: TButton
      Left = 64
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Rotacion X+'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 64
      Top = 72
      Width = 75
      Height = 25
      Caption = 'Rotacion X-'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 64
      Top = 112
      Width = 75
      Height = 25
      Caption = 'Rotacion Y+'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 64
      Top = 153
      Width = 75
      Height = 25
      Caption = 'Rotacion Y-'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 64
      Top = 192
      Width = 75
      Height = 25
      Caption = 'Rotacion Z+'
      TabOrder = 4
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 64
      Top = 232
      Width = 75
      Height = 25
      Caption = 'Rotacion Z-'
      TabOrder = 5
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 64
      Top = 271
      Width = 75
      Height = 25
      Caption = 'Alejar'
      TabOrder = 6
      OnClick = Button7Click
    end
    object Button8: TButton
      Left = 64
      Top = 312
      Width = 75
      Height = 25
      Caption = 'Acercar'
      TabOrder = 7
      OnClick = Button8Click
    end
    object Button9: TButton
      Left = 64
      Top = 352
      Width = 75
      Height = 25
      Caption = 'Abrir'
      TabOrder = 8
      OnClick = Button9Click
    end
    object Button10: TButton
      Left = 64
      Top = 392
      Width = 75
      Height = 25
      Caption = 'Pintar Red'
      TabOrder = 9
      OnClick = Button10Click
    end
  end
  object Panel2: TPanel
    Left = 614
    Top = 509
    Width = 185
    Height = 144
    Color = clLime
    ParentBackground = False
    TabOrder = 1
    object Button11: TButton
      Left = 64
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Autor'
      TabOrder = 0
      OnClick = Button11Click
    end
    object Button12: TButton
      Left = 64
      Top = 80
      Width = 75
      Height = 25
      Caption = 'Salir'
      TabOrder = 1
      OnClick = Button12Click
    end
  end
  object OpenTextFileDialog1: TOpenTextFileDialog
    Left = 616
    Top = 24
  end
end
