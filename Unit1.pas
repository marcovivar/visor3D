unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ExtDlgs;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Image1: TImage;
    Label1: TLabel;
    Panel2: TPanel;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    OpenTextFileDialog1: TOpenTextFileDialog;
    procedure Button8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


// Definición de TPoint3D
type
  TPoint3D = packed record
    x: Real;
    y: Real;
    z: Real;
end;

type tImagen = packed record
  x1 : Integer;
  y1 : Integer;
  angulo : Integer;
end;
//es lo mismo que una struct en C
type tLinea = packed record
  x1 : Integer;
  y1 : Integer;
  x2 : Integer;
  y2 : Integer;
end;

// Definición de constantes
const
TamFig = 40;

type
  TPrisma=  Array[1..10] of TPoint3D;  //definicion del cubo
  TArista=  Array[1..2] of TPoint3D;  //definicion del cubo
var
  Form1: TForm1;
  Cubo : Array[1..50] of TPrisma; //arreglo de los diferentes cubos
  Cubo2 : Array[1..50] of TPrisma; //arreglo de los diferentes cubos
  Cubo3 : Array[1..50] of TPrisma; //arreglo de los diferentes cubos
  Cubo4 : Array[1..50] of TPrisma; //arreglo de los diferentes cubos
  Cubo5 : Array[1..50] of TPrisma; //arreglo de los diferentes cubos
  tubo3D : Array[1..50] of TArista;
  manguera3D : Array[1..50] of TArista;
  P, Q : TPoint;  //variables para pintar en pantalla
  xAux, yAux, zAux : Real;  //variables auxiliares para la rotacion
  ojoAObjeto, D : Real;//varaibles que usamos en la proyeccion perpectiva

  //arreglos de estructuras
  tubo : array[1..50] of tLinea;
  manguera : array[1..50] of tLinea;
  casa : array[1..50] of tImagen;
  edificio : array[1..50] of tImagen;
  distribuidorA : array[1..50] of tImagen;
  bombaA : array[1..50] of tImagen;
  llaveA : array[1..50] of tImagen;
  medidorA : array[1..50] of tImagen;
  //contadores de mis objetos
  nTubo : Integer;
  nManguera : Integer;
  nCasa : Integer;
  nEdificio : Integer;
  nDistribuidor : Integer;
  nBomba : Integer;
  nMedidor : Integer;
  nLlave : Integer;

  centroRedX,centroRedY : Integer;
  minX,minY,maxX,maxY : Integer;

implementation

{$R *.dfm}

procedure TForm1.Button10Click(Sender: TObject);

  // (x, y, z) en 3D y (xP, yP) en 2D
//
procedure Perspectiva( x, y, z: Real; var xP, yP : Integer);
var
xAux, yAux, zAux : Real;
begin
zAux := z + OjoAObjeto;
xAux := (x * D) / zAux;
xP := Round(xAux) +200;
yAux := (y * D) / zAux;
yP := Round(yAux) +200;
end;

procedure PintarPrisma(h:Integer);
var
  i:Integer;
begin
  // Pinta el Piso del Cubo
  for i := 1 to 4 do
    begin
      Perspectiva( Cubo[h][i].x, Cubo[h][i].y, Cubo[h][i].z, P.x, P.y);
      Perspectiva( Cubo[h][i+1].x, Cubo[h][i+1].y, Cubo[h][i+1].z, Q.x, Q.y);
      Image1.Canvas.MoveTo(P.x, P.y);
      Image1.Canvas.LineTo(Q.x, Q.y);
    end;
  // Pinta el techo del Cubo
  for i := 6 to 9 do
    begin
      Perspectiva( Cubo[h][i].x, Cubo[h][i].y, Cubo[h][i].z, P.x, P.y);
      Perspectiva( Cubo[h][i+1].x, Cubo[h][i+1].y, Cubo[h][i+1].z, Q.x, Q.y);
      Image1.Canvas.MoveTo(P.x, P.y);
      Image1.Canvas.LineTo(Q.x, Q.y);
    end;

  // Pinta aristas de las paredes
  for i := 1 to 4 do
    begin
      Perspectiva( Cubo[h][i].x, Cubo[h][i].y, Cubo[h][i].z, P.x, P.y);
      Perspectiva( Cubo[h][i+5].x, Cubo[h][i+5].y, Cubo[h][i+5].z, Q.x, Q.y);
      Image1.Canvas.MoveTo(P.x, P.y);
      Image1.Canvas.LineTo(Q.x, Q.y);
    end;

end;
procedure PintarPrisma2(h:Integer);
var
  i:Integer;
begin
  // Pinta el Piso del Cubo
  for i := 1 to 4 do
    begin
      Perspectiva( cubo2[h][i].x, cubo2[h][i].y, cubo2[h][i].z, P.x, P.y);
      Perspectiva( cubo2[h][i+1].x, cubo2[h][i+1].y, cubo2[h][i+1].z, Q.x, Q.y);
      Image1.Canvas.MoveTo(P.x, P.y);
      Image1.Canvas.LineTo(Q.x, Q.y);
    end;
  // Pinta el techo del Cubo
  for i := 6 to 9 do
    begin
      Perspectiva( cubo2[h][i].x, cubo2[h][i].y, cubo2[h][i].z, P.x, P.y);
      Perspectiva( cubo2[h][i+1].x, cubo2[h][i+1].y, cubo2[h][i+1].z, Q.x, Q.y);
      Image1.Canvas.MoveTo(P.x, P.y);
      Image1.Canvas.LineTo(Q.x, Q.y);
    end;

  // Pinta aristas de las paredes
  for i := 1 to 4 do
    begin
      Perspectiva( cubo2[h][i].x, cubo2[h][i].y, cubo2[h][i].z, P.x, P.y);
      Perspectiva( cubo2[h][i+5].x, cubo2[h][i+5].y, cubo2[h][i+5].z, Q.x, Q.y);
      Image1.Canvas.MoveTo(P.x, P.y);
      Image1.Canvas.LineTo(Q.x, Q.y);
    end;

end;
procedure PintarPrisma3(h:Integer);
var
  i:Integer;
begin
  // Pinta el Piso del Cubo
  for i := 1 to 4 do
    begin
      Perspectiva( cubo3[h][i].x, cubo3[h][i].y, cubo3[h][i].z, P.x, P.y);
      Perspectiva( cubo3[h][i+1].x, cubo3[h][i+1].y, cubo3[h][i+1].z, Q.x, Q.y);
      Image1.Canvas.MoveTo(P.x, P.y);
      Image1.Canvas.LineTo(Q.x, Q.y);
    end;
  // Pinta el techo del Cubo
  for i := 6 to 9 do
    begin
      Perspectiva( cubo3[h][i].x, cubo3[h][i].y, cubo3[h][i].z, P.x, P.y);
      Perspectiva( cubo3[h][i+1].x, cubo3[h][i+1].y, cubo3[h][i+1].z, Q.x, Q.y);
      Image1.Canvas.MoveTo(P.x, P.y);
      Image1.Canvas.LineTo(Q.x, Q.y);
    end;

  // Pinta aristas de las paredes
  for i := 1 to 4 do
    begin
      Perspectiva( cubo3[h][i].x, cubo3[h][i].y, cubo3[h][i].z, P.x, P.y);
      Perspectiva( cubo3[h][i+5].x, cubo3[h][i+5].y, cubo3[h][i+5].z, Q.x, Q.y);
      Image1.Canvas.MoveTo(P.x, P.y);
      Image1.Canvas.LineTo(Q.x, Q.y);
    end;

end;
procedure PintarPrisma4(h:Integer);
var
  i:Integer;
begin
  // Pinta el Piso del Cubo
  for i := 1 to 4 do
    begin
      Perspectiva( cubo4[h][i].x, cubo4[h][i].y, cubo4[h][i].z, P.x, P.y);
      Perspectiva( cubo4[h][i+1].x, cubo4[h][i+1].y, cubo4[h][i+1].z, Q.x, Q.y);
      Image1.Canvas.MoveTo(P.x, P.y);
      Image1.Canvas.LineTo(Q.x, Q.y);
    end;
  // Pinta el techo del Cubo
  for i := 6 to 9 do
    begin
      Perspectiva( cubo4[h][i].x, cubo4[h][i].y, cubo4[h][i].z, P.x, P.y);
      Perspectiva( cubo4[h][i+1].x, cubo4[h][i+1].y, cubo4[h][i+1].z, Q.x, Q.y);
      Image1.Canvas.MoveTo(P.x, P.y);
      Image1.Canvas.LineTo(Q.x, Q.y);
    end;

  // Pinta aristas de las paredes
  for i := 1 to 4 do
    begin
      Perspectiva( cubo4[h][i].x, cubo4[h][i].y, cubo4[h][i].z, P.x, P.y);
      Perspectiva( cubo4[h][i+5].x, cubo4[h][i+5].y, cubo4[h][i+5].z, Q.x, Q.y);
      Image1.Canvas.MoveTo(P.x, P.y);
      Image1.Canvas.LineTo(Q.x, Q.y);
    end;

end;
procedure PintarPrisma5(h:Integer);
var
  i:Integer;
begin
  // Pinta el Piso del Cubo
  for i := 1 to 4 do
    begin
      Perspectiva( cubo5[h][i].x, cubo5[h][i].y, cubo5[h][i].z, P.x, P.y);
      Perspectiva( cubo5[h][i+1].x, cubo5[h][i+1].y, cubo5[h][i+1].z, Q.x, Q.y);
      Image1.Canvas.MoveTo(P.x, P.y);
      Image1.Canvas.LineTo(Q.x, Q.y);
    end;
  // Pinta el techo del Cubo
  for i := 6 to 9 do
    begin
      Perspectiva( cubo5[h][i].x, cubo5[h][i].y, cubo5[h][i].z, P.x, P.y);
      Perspectiva( cubo5[h][i+1].x, cubo5[h][i+1].y, cubo5[h][i+1].z, Q.x, Q.y);
      Image1.Canvas.MoveTo(P.x, P.y);
      Image1.Canvas.LineTo(Q.x, Q.y);
    end;

  // Pinta aristas de las paredes
  for i := 1 to 4 do
    begin
      Perspectiva( cubo5[h][i].x, cubo5[h][i].y, cubo5[h][i].z, P.x, P.y);
      Perspectiva( cubo5[h][i+5].x, cubo5[h][i+5].y, cubo5[h][i+5].z, Q.x, Q.y);
      Image1.Canvas.MoveTo(P.x, P.y);
      Image1.Canvas.LineTo(Q.x, Q.y);
    end;

end;

procedure PintarTubos(h:Integer);
begin
      Perspectiva( tubo3D[h][1].x, tubo3D[h][1].y, tubo3D[h][1].z, P.x, P.y);
      Perspectiva( tubo3D[h][2].x, tubo3D[h][2].y, tubo3D[h][2].z, Q.x, Q.y);
      Image1.Canvas.MoveTo(P.x, P.y);
      Image1.Canvas.LineTo(Q.x, Q.y);
end;
procedure PintarMangueras(h:Integer);
begin
      Perspectiva( manguera3D[h][1].x, manguera3D[h][1].y, manguera3D[h][1].z, P.x, P.y);
      Perspectiva( manguera3D[h][2].x, manguera3D[h][2].y, manguera3D[h][2].z, Q.x, Q.y);
      Image1.Canvas.MoveTo(P.x, P.y);
      Image1.Canvas.LineTo(Q.x, Q.y);
end;

var
  i : Integer;
  j: Integer;
begin
  image1.Canvas.Rectangle(0,0,600,600);
  //se muestran los objetos guardados en los arreglos
  for i := 1 to nTubo do
    begin
      Image1.Canvas.Pen.Color := RGB(255, 87, 51);
      Image1.Canvas.Pen.Width:=6;
      pintarTubos(i);
      Image1.Canvas.Pen.Width:=1;
    end;
  for i := 1 to nManguera do
    begin
      Image1.Canvas.Pen.Color := clBlack;
      Image1.Canvas.Pen.Width:=4;
      pintarMangueras(i);
      Image1.Canvas.Pen.Width:=1;
    end;
  
  for i := 1 to nCasa do
    begin
      Image1.Canvas.Pen.Color := clGreen;
      pintarPrisma(i);
    end;
  for i := 1 to nEdificio do
    begin
      Image1.Canvas.Pen.Color := clRed;
      pintarPrisma2(i);
    end;
  for i := 1 to nBomba do
    begin
      Image1.Canvas.Pen.Color := clBlue;
      pintarPrisma3(i);
    end;
  for i := 1 to nDistribuidor do
    begin
      Image1.Canvas.Pen.Color := RGB(120,40,31);
      pintarPrisma4(i);
    end;
  for i := 1 to nLlave do
    begin
      Image1.Canvas.Pen.Color := clGray;
      pintarPrisma5(i);
    end;

  Image1.Canvas.Pen.Color := clBlack;

end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  //salto de linea con sLineBreak
  showmessage('Marco Antonio Vivar Olvera'+sLineBreak+'marco.vivaro@alumno.buap.mx'
              +sLineBreak+'FCC'+sLineBreak+'BUAP');
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
  close();
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  alfa: Real;
  i: Integer;
  h: Integer;

begin
  // Aplica la Rotación Rx a todos los puntos del Cubo.
  // El ángulo esta determinado por alfa
  alfa := (15*Pi) / 180.0; // Grados a radianes
  for h := 1 to nCasa do
  begin
    for i := 1 to 10 do
      begin
        yAux := (cubo[h][i].y * COS( -alfa )) + (cubo[h][i].z * SIN( -alfa ));
        zAux := -(cubo[h][i].y * SIN( -alfa )) + (cubo[h][i].z * COS( -alfa ));
        cubo[h][i].y := yAux;
        cubo[h][i].z := zAux;
      end;
  end;
  for h := 1 to nEdificio do
  begin
    for i := 1 to 10 do
      begin
        yAux := (cubo2[h][i].y * COS( -alfa )) + (cubo2[h][i].z * SIN( -alfa ));
        zAux := -(cubo2[h][i].y * SIN( -alfa )) + (cubo2[h][i].z * COS( -alfa ));
        cubo2[h][i].y := yAux;
        cubo2[h][i].z := zAux;
      end;
  end;
  for h := 1 to nBomba do
  begin
    for i := 1 to 10 do
      begin
        yAux := (cubo3[h][i].y * COS( -alfa )) + (cubo3[h][i].z * SIN( -alfa ));
        zAux := -(cubo3[h][i].y * SIN( -alfa )) + (cubo3[h][i].z * COS( -alfa ));
        cubo3[h][i].y := yAux;
        cubo3[h][i].z := zAux;
      end;
  end;
  for h := 1 to nDistribuidor do
  begin
    for i := 1 to 10 do
      begin
        yAux := (cubo4[h][i].y * COS( -alfa )) + (cubo4[h][i].z * SIN( -alfa ));
        zAux := -(cubo4[h][i].y * SIN( -alfa )) + (cubo4[h][i].z * COS( -alfa ));
        cubo4[h][i].y := yAux;
        cubo4[h][i].z := zAux;
      end;
  end;
  for h := 1 to nLlave do
  begin
    for i := 1 to 10 do
      begin
        yAux := (cubo5[h][i].y * COS( -alfa )) + (cubo5[h][i].z * SIN( -alfa ));
        zAux := -(cubo5[h][i].y * SIN( -alfa )) + (cubo5[h][i].z * COS( -alfa ));
        cubo5[h][i].y := yAux;
        cubo5[h][i].z := zAux;
      end;
  end;
  for h := 1 to nTubo do
  begin
    for i := 1 to 2 do
      begin
        yAux := (tubo3D[h][i].y * COS( -alfa )) + (tubo3D[h][i].z * SIN( -alfa ));
        zAux := -(tubo3D[h][i].y * SIN( -alfa )) + (tubo3D[h][i].z * COS( -alfa ));
        tubo3D[h][i].y := yAux;
        tubo3D[h][i].z := zAux;
      end;
  end;
  for h := 1 to nManguera do
  begin
    for i := 1 to 2 do
      begin
        yAux := (manguera3D[h][i].y * COS( -alfa )) + (manguera3D[h][i].z * SIN( -alfa ));
        zAux := -(manguera3D[h][i].y * SIN( -alfa )) + (manguera3D[h][i].z * COS( -alfa ));
        manguera3D[h][i].y := yAux;
        manguera3D[h][i].z := zAux;
      end;
  end;
  Button10Click(Sender);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  alfa: Real;
  i: Integer;
  h: Integer;
begin
  // Aplica la Rotación Rx a todos los puntos del Cubo.
  // El ángulo esta determinado por alfa
  alfa := (15*Pi) / 180.0; // Grados a radianes
  for h := 1 to nCasa do
    begin
      for i := 1 to 10 do
        begin
          yAux := (Cubo[h][i].y * COS( alfa )) + (Cubo[h][i].z * SIN( alfa ));
          zAux := -(Cubo[h][i].y * SIN( alfa )) + (Cubo[h][i].z * COS( alfa ));
          Cubo[h][i].y := yAux;
          Cubo[h][i].z := zAux;
        end;
    end;
  for h := 1 to nEdificio do
    begin
      for i := 1 to 10 do
        begin
          yAux := (Cubo2[h][i].y * COS( alfa )) + (Cubo2[h][i].z * SIN( alfa ));
          zAux := -(Cubo2[h][i].y * SIN( alfa )) + (Cubo2[h][i].z * COS( alfa ));
          Cubo2[h][i].y := yAux;
          Cubo2[h][i].z := zAux;
        end;
    end;
  for h := 1 to nBomba do
    begin
      for i := 1 to 10 do
        begin
          yAux := (Cubo3[h][i].y * COS( alfa )) + (Cubo3[h][i].z * SIN( alfa ));
          zAux := -(Cubo3[h][i].y * SIN( alfa )) + (Cubo3[h][i].z * COS( alfa ));
          Cubo3[h][i].y := yAux;
          Cubo3[h][i].z := zAux;
        end;
    end;
  for h := 1 to nDistribuidor do
    begin
      for i := 1 to 10 do
        begin
          yAux := (Cubo4[h][i].y * COS( alfa )) + (Cubo4[h][i].z * SIN( alfa ));
          zAux := -(Cubo4[h][i].y * SIN( alfa )) + (Cubo4[h][i].z * COS( alfa ));
          Cubo4[h][i].y := yAux;
          Cubo4[h][i].z := zAux;
        end;
    end;
  for h := 1 to nLlave do
    begin
      for i := 1 to 10 do
        begin
          yAux := (Cubo5[h][i].y * COS( alfa )) + (Cubo5[h][i].z * SIN( alfa ));
          zAux := -(Cubo5[h][i].y * SIN( alfa )) + (Cubo5[h][i].z * COS( alfa ));
          Cubo5[h][i].y := yAux;
          Cubo5[h][i].z := zAux;
        end;
    end;
  for h := 1 to nTubo do
    begin
      for i := 1 to 2 do
        begin
          yAux := (tubo3D[h][i].y * COS( alfa )) + (tubo3D[h][i].z * SIN( alfa ));
          zAux := -(tubo3D[h][i].y * SIN( alfa )) + (tubo3D[h][i].z * COS( alfa ));
          tubo3D[h][i].y := yAux;
          tubo3D[h][i].z := zAux;
        end;
    end;
  for h := 1 to nManguera do
    begin
      for i := 1 to 2 do
        begin
          yAux := (manguera3D[h][i].y * COS( alfa )) + (manguera3D[h][i].z * SIN( alfa ));
          zAux := -(manguera3D[h][i].y * SIN( alfa )) + (manguera3D[h][i].z * COS( alfa ));
          manguera3D[h][i].y := yAux;
          manguera3D[h][i].z := zAux;
        end;
    end;

  Button10Click(Sender);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  alfa: Real;
  i: Integer;
  h: Integer;
begin
  // Aplica la Rotación Ry a todos los puntos del Cubo.
  // El ángulo esta determinado por alfa
  alfa := (15*Pi) / 180.0; // Grados a radianes
  for h := 1 to nCasa do
    begin
      for i := 1 to 10 do
        begin
          zAux := (Cubo[h][i].z * COS( -alfa )) + (Cubo[h][i].x * SIN( -alfa ));
          xAux := -(Cubo[h][i].z * SIN( -alfa )) + (Cubo[h][i].x * COS( -alfa ));
          Cubo[h][i].z := zAux;
          Cubo[h][i].x := xAux;
        end;
    end;
  for h := 1 to nEdificio do
    begin
      for i := 1 to 10 do
        begin
          zAux := (Cubo2[h][i].z * COS( -alfa )) + (Cubo2[h][i].x * SIN( -alfa ));
          xAux := -(Cubo2[h][i].z * SIN( -alfa )) + (Cubo2[h][i].x * COS( -alfa ));
          Cubo2[h][i].z := zAux;
          Cubo2[h][i].x := xAux;
        end;
    end;
  for h := 1 to nBomba do
    begin
      for i := 1 to 10 do
        begin
          zAux := (Cubo3[h][i].z * COS( -alfa )) + (Cubo3[h][i].x * SIN( -alfa ));
          xAux := -(Cubo3[h][i].z * SIN( -alfa )) + (Cubo3[h][i].x * COS( -alfa ));
          Cubo3[h][i].z := zAux;
          Cubo3[h][i].x := xAux;
        end;
    end;
  for h := 1 to nDistribuidor do
    begin
      for i := 1 to 10 do
        begin
          zAux := (Cubo4[h][i].z * COS( -alfa )) + (Cubo4[h][i].x * SIN( -alfa ));
          xAux := -(Cubo4[h][i].z * SIN( -alfa )) + (Cubo4[h][i].x * COS( -alfa ));
          Cubo4[h][i].z := zAux;
          Cubo4[h][i].x := xAux;
        end;
    end;
  for h := 1 to nLlave do
    begin
      for i := 1 to 10 do
        begin
          zAux := (Cubo5[h][i].z * COS( -alfa )) + (Cubo5[h][i].x * SIN( -alfa ));
          xAux := -(Cubo5[h][i].z * SIN( -alfa )) + (Cubo5[h][i].x * COS( -alfa ));
          Cubo5[h][i].z := zAux;
          Cubo5[h][i].x := xAux;
        end;
    end;
  for h := 1 to nTubo do
    begin
      for i := 1 to 2 do
        begin
          zAux := (tubo3D[h][i].z * COS( -alfa )) + (tubo3D[h][i].x * SIN( -alfa ));
          xAux := -(tubo3D[h][i].z * SIN( -alfa )) + (tubo3D[h][i].x * COS( -alfa ));
          tubo3D[h][i].z := zAux;
          tubo3D[h][i].x := xAux;
        end;
    end;
  for h := 1 to nManguera do
    begin
      for i := 1 to 2 do
        begin
          zAux := (manguera3D[h][i].z * COS( -alfa )) + (manguera3D[h][i].x * SIN( -alfa ));
          xAux := -(manguera3D[h][i].z * SIN( -alfa )) + (manguera3D[h][i].x * COS( -alfa ));
          manguera3D[h][i].z := zAux;
          manguera3D[h][i].x := xAux;
        end;
    end;
  Button10Click(Sender);

end;

procedure TForm1.Button4Click(Sender: TObject);
var
  alfa: Real;
  i: Integer;
  h: Integer;
begin
  // Aplica la Rotación Ry a todos los puntos del Cubo.
  // El ángulo esta determinado por alfa
  alfa := (15*Pi) / 180.0; // Grados a radianes
  for h := 1 to nCasa do
    begin
      for i := 1 to 10 do
        begin
          zAux := (Cubo[h][i].z * COS( alfa )) + (Cubo[h][i].x * SIN( alfa ));
          xAux := -(Cubo[h][i].z * SIN( alfa )) + (Cubo[h][i].x * COS( alfa ));
          Cubo[h][i].z := zAux;
          Cubo[h][i].x := xAux;
        end;
    end;
  for h := 1 to nEdificio do
    begin
      for i := 1 to 10 do
        begin
          zAux := (Cubo2[h][i].z * COS( alfa )) + (Cubo2[h][i].x * SIN( alfa ));
          xAux := -(Cubo2[h][i].z * SIN( alfa )) + (Cubo2[h][i].x * COS( alfa ));
          Cubo2[h][i].z := zAux;
          Cubo2[h][i].x := xAux;
        end;
    end;
  for h := 1 to nBomba do
    begin
      for i := 1 to 10 do
        begin
          zAux := (Cubo3[h][i].z * COS( alfa )) + (Cubo3[h][i].x * SIN( alfa ));
          xAux := -(Cubo3[h][i].z * SIN( alfa )) + (Cubo3[h][i].x * COS( alfa ));
          Cubo3[h][i].z := zAux;
          Cubo3[h][i].x := xAux;
        end;
    end;
  for h := 1 to nDistribuidor do
    begin
      for i := 1 to 10 do
        begin
          zAux := (Cubo4[h][i].z * COS( alfa )) + (Cubo4[h][i].x * SIN( alfa ));
          xAux := -(Cubo4[h][i].z * SIN( alfa )) + (Cubo4[h][i].x * COS( alfa ));
          Cubo4[h][i].z := zAux;
          Cubo4[h][i].x := xAux;
        end;
    end;
  for h := 1 to nLlave do
    begin
      for i := 1 to 10 do
        begin
          zAux := (Cubo5[h][i].z * COS( alfa )) + (Cubo5[h][i].x * SIN( alfa ));
          xAux := -(Cubo5[h][i].z * SIN( alfa )) + (Cubo5[h][i].x * COS( alfa ));
          Cubo5[h][i].z := zAux;
          Cubo5[h][i].x := xAux;
        end;
    end;
  for h := 1 to nTubo do
    begin
      for i := 1 to 2 do
        begin
          zAux := (tubo3D[h][i].z * COS( alfa )) + (tubo3D[h][i].x * SIN( alfa ));
          xAux := -(tubo3D[h][i].z * SIN( alfa )) + (tubo3D[h][i].x * COS( alfa ));
          tubo3D[h][i].z := zAux;
          tubo3D[h][i].x := xAux;
        end;
    end;
  for h := 1 to nManguera do
    begin
      for i := 1 to 2 do
        begin
          zAux := (manguera3D[h][i].z * COS( alfa )) + (manguera3D[h][i].x * SIN( alfa ));
          xAux := -(manguera3D[h][i].z * SIN( alfa )) + (manguera3D[h][i].x * COS( alfa ));
          manguera3D[h][i].z := zAux;
          manguera3D[h][i].x := xAux;
        end;
    end;
  Button10Click(Sender);
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  alfa: Real;
  i: Integer;
  h: Integer;
begin
  // Aplica la Rotación Rz a todos los puntos del Cubo.
  // El ángulo esta determinado por alfa
  alfa := (15*Pi) / 180.0; // Grados a radianes
  for h := 1 to nCasa do
    begin
      for i := 1 to 10 do
        begin
          xAux := (Cubo[h][i].x * COS( -alfa )) + (Cubo[h][i].y * SIN( -alfa ));
          yAux := -(Cubo[h][i].x * SIN( -alfa )) + (Cubo[h][i].y * COS( -alfa ));
          Cubo[h][i].x := xAux;
          Cubo[h][i].y := yAux;
        end;
    end;
  for h := 1 to nEdificio do
    begin
      for i := 1 to 10 do
        begin
          xAux := (Cubo2[h][i].x * COS( -alfa )) + (Cubo2[h][i].y * SIN( -alfa ));
          yAux := -(Cubo2[h][i].x * SIN( -alfa )) + (Cubo2[h][i].y * COS( -alfa ));
          Cubo2[h][i].x := xAux;
          Cubo2[h][i].y := yAux;
        end;
    end;
  for h := 1 to nBomba do
    begin
      for i := 1 to 10 do
        begin
          xAux := (Cubo3[h][i].x * COS( -alfa )) + (Cubo3[h][i].y * SIN( -alfa ));
          yAux := -(Cubo3[h][i].x * SIN( -alfa )) + (Cubo3[h][i].y * COS( -alfa ));
          Cubo3[h][i].x := xAux;
          Cubo3[h][i].y := yAux;
        end;
    end;
  for h := 1 to nDistribuidor do
    begin
      for i := 1 to 10 do
        begin
          xAux := (Cubo4[h][i].x * COS( -alfa )) + (Cubo4[h][i].y * SIN( -alfa ));
          yAux := -(Cubo4[h][i].x * SIN( -alfa )) + (Cubo4[h][i].y * COS( -alfa ));
          Cubo4[h][i].x := xAux;
          Cubo4[h][i].y := yAux;
        end;
    end;
  for h := 1 to nLlave do
    begin
      for i := 1 to 10 do
        begin
          xAux := (Cubo5[h][i].x * COS( -alfa )) + (Cubo5[h][i].y * SIN( -alfa ));
          yAux := -(Cubo5[h][i].x * SIN( -alfa )) + (Cubo5[h][i].y * COS( -alfa ));
          Cubo5[h][i].x := xAux;
          Cubo5[h][i].y := yAux;
        end;
    end;
  for h := 1 to nTubo do
    begin
      for i := 1 to 2 do
        begin
          xAux := (tubo3D[h][i].x * COS( -alfa )) + (tubo3D[h][i].y * SIN( -alfa ));
          yAux := -(tubo3D[h][i].x * SIN( -alfa )) + (tubo3D[h][i].y * COS( -alfa ));
          tubo3D[h][i].x := xAux;
          tubo3D[h][i].y := yAux;
        end;
    end;
  for h := 1 to nManguera do
    begin
      for i := 1 to 2 do
        begin
          xAux := (manguera3D[h][i].x * COS( -alfa )) + (manguera3D[h][i].y * SIN( -alfa ));
          yAux := -(manguera3D[h][i].x * SIN( -alfa )) + (manguera3D[h][i].y * COS( -alfa ));
          manguera3D[h][i].x := xAux;
          manguera3D[h][i].y := yAux;
        end;
    end;
  Button10Click(Sender);
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  alfa: Real;
  i: Integer;
  h: Integer;
begin
  // Aplica la Rotación Rz a todos los puntos del Cubo.
  // El ángulo esta determinado por alfa
  alfa := (15*Pi) / 180.0; // Grados a radianes
  for h := 1 to nCasa do
    begin
      for i := 1 to 10 do
        begin
          xAux := (Cubo[h][i].x * COS( alfa )) + (Cubo[h][i].y * SIN( alfa ));
          yAux := -(Cubo[h][i].x * SIN( alfa )) + (Cubo[h][i].y * COS( alfa ));
          Cubo[h][i].x := xAux;
          Cubo[h][i].y := yAux;
        end;
    end;
  for h := 1 to nEdificio do
    begin
      for i := 1 to 10 do
        begin
          xAux := (Cubo2[h][i].x * COS( alfa )) + (Cubo2[h][i].y * SIN( alfa ));
          yAux := -(Cubo2[h][i].x * SIN( alfa )) + (Cubo2[h][i].y * COS( alfa ));
          Cubo2[h][i].x := xAux;
          Cubo2[h][i].y := yAux;
        end;
    end;
  for h := 1 to nBomba do
    begin
      for i := 1 to 10 do
        begin
          xAux := (Cubo3[h][i].x * COS( alfa )) + (Cubo3[h][i].y * SIN( alfa ));
          yAux := -(Cubo3[h][i].x * SIN( alfa )) + (Cubo3[h][i].y * COS( alfa ));
          Cubo3[h][i].x := xAux;
          Cubo3[h][i].y := yAux;
        end;
    end;
  for h := 1 to nDistribuidor do
    begin
      for i := 1 to 10 do
        begin
          xAux := (Cubo4[h][i].x * COS( alfa )) + (Cubo4[h][i].y * SIN( alfa ));
          yAux := -(Cubo4[h][i].x * SIN( alfa )) + (Cubo4[h][i].y * COS( alfa ));
          Cubo4[h][i].x := xAux;
          Cubo4[h][i].y := yAux;
        end;
    end;
  for h := 1 to nLlave do
    begin
      for i := 1 to 10 do
        begin
          xAux := (Cubo5[h][i].x * COS( alfa )) + (Cubo5[h][i].y * SIN( alfa ));
          yAux := -(Cubo5[h][i].x * SIN( alfa )) + (Cubo5[h][i].y * COS( alfa ));
          Cubo5[h][i].x := xAux;
          Cubo5[h][i].y := yAux;
        end;
    end;
  for h := 1 to nTubo do
    begin
      for i := 1 to 2 do
        begin
          xAux := (tubo3D[h][i].x * COS( alfa )) + (tubo3D[h][i].y * SIN( alfa ));
          yAux := -(tubo3D[h][i].x * SIN( alfa )) + (tubo3D[h][i].y * COS( alfa ));
          tubo3D[h][i].x := xAux;
          tubo3D[h][i].y := yAux;
        end;
    end;
  for h := 1 to nManguera do
    begin
      for i := 1 to 2 do
        begin
          xAux := (manguera3D[h][i].x * COS( alfa )) + (manguera3D[h][i].y * SIN( alfa ));
          yAux := -(manguera3D[h][i].x * SIN( alfa )) + (manguera3D[h][i].y * COS( alfa ));
          manguera3D[h][i].x := xAux;
          manguera3D[h][i].y := yAux;
        end;
    end;
  Button10Click(Sender);
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  ojoAObjeto:=ojoAObjeto*1.10;
  Button10Click(Sender);
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  ojoAObjeto:=ojoAObjeto/1.10;
  Button10Click(Sender);
end;

procedure TForm1.Button9Click(Sender: TObject);
var fp:textFile;
  i,j,distancia : Integer;
begin
  minX:=2000;
  minY:=2000;
  maxX:=-1;
  maxy:=-1;
  if openTextFileDialog1.Execute() then
    begin
      assignFile(fp, openTextFileDialog1.FileName);
      reset(fp);  //lectura
      readLn(fp,nTubo);
      readLn(fp,nManguera);
      readLn(fp,nCasa);
      readLn(fp,nEdificio);
      readLn(fp,nDistribuidor);
      readLn(fp,nBomba);
      readLn(fp,nMedidor);
      readLn(fp,nLlave);

      for i := 1 to nTubo do
        begin
          readLn(fp,tubo[i].x1, tubo[i].y1, tubo[i].x2, tubo[i].y2);
          if tubo[i].x1<minX then
            begin
              minX:=tubo[i].x1;
            end;
          if tubo[i].y1<minY then
            begin
              minY:=tubo[i].y1;
            end;
          if tubo[i].x1>maxX then
            begin
              maxX:=tubo[i].x1;
            end;
          if tubo[i].y1>maxY then
            begin
              maxY:=tubo[i].y1;
            end;
            //busqueda en las x y y 2
          if tubo[i].x2<minX then
            begin
              minX:=tubo[i].x2;
            end;
          if tubo[i].y2<minY then
            begin
              minY:=tubo[i].y2;
            end;
          if tubo[i].x2>maxX then
            begin
              maxX:=tubo[i].x2;
            end;
          if tubo[i].y2>maxY then
            begin
              maxY:=tubo[i].y2;
            end;
        end;
      for i := 1 to nManguera do
        begin
          readLn(fp,manguera[i].x1, manguera[i].y1, manguera[i].x2, manguera[i].y2);
          if manguera[i].x1<minX then
            begin
              minX:=manguera[i].x1;
            end;
          if manguera[i].y1<minY then
            begin
              minY:=manguera[i].y1;
            end;
          if manguera[i].x1>maxX then
            begin
              maxX:=manguera[i].x1;
            end;
          if manguera[i].y1>maxY then
            begin
              maxY:=manguera[i].y1;
            end;
            //busqueda en las x y y 2
          if manguera[i].x2<minX then
            begin
              minX:=manguera[i].x2;
            end;
          if manguera[i].y2<minY then
            begin
              minY:=manguera[i].y2;
            end;
          if manguera[i].x2>maxX then
            begin
              maxX:=manguera[i].x2;
            end;
          if manguera[i].y2>maxY then
            begin
              maxY:=manguera[i].y2;
            end;
        end;


      for i := 1 to nCasa do
        begin
          readLn(fp,casa[i].x1, casa[i].y1, casa[i].angulo);
          if casa[i].x1<minX then
            begin
              minX:=casa[i].x1;
            end;
          if casa[i].y1<minY then
            begin
              minY:=casa[i].y1;
            end;
          if casa[i].x1>maxX then
            begin
              maxX:=casa[i].x1;
            end;
          if casa[i].y1>maxY then
            begin
              maxY:=casa[i].y1;
            end;
        end;
      for i := 1 to nEdificio do
        begin
          readLn(fp,edificio[i].x1, edificio[i].y1, edificio[i].angulo);
          if edificio[i].x1<minX then
            begin
              minX:=edificio[i].x1;
            end;
          if edificio[i].y1<minY then
            begin
              minY:=edificio[i].y1;
            end;
          if edificio[i].x1>maxX then
            begin
              maxX:=edificio[i].x1;
            end;
          if edificio[i].y1>maxY then
            begin
              maxY:=edificio[i].y1;
            end;
        end;
      for i := 1 to nDistribuidor do
        begin
          readLn(fp,distribuidorA[i].x1, distribuidorA[i].y1, distribuidorA[i].angulo);
          if distribuidorA[i].x1<minX then
            begin
              minX:=distribuidorA[i].x1;
            end;
          if distribuidorA[i].y1<minY then
            begin
              minY:=distribuidorA[i].y1;
            end;
          if distribuidorA[i].x1>maxX then
            begin
              maxX:=distribuidorA[i].x1;
            end;
          if distribuidorA[i].y1>maxY then
            begin
              maxY:=distribuidorA[i].y1;
            end;
        end;
      for i := 1 to nBomba do
        begin
          readLn(fp,bombaA[i].x1, bombaA[i].y1, bombaA[i].angulo);
          if bombaA[i].x1<minX then
            begin
              minX:=bombaA[i].x1;
            end;
          if bombaA[i].y1<minY then
            begin
              minY:=bombaA[i].y1;
            end;
          if bombaA[i].x1>maxX then
            begin
              maxX:=bombaA[i].x1;
            end;
          if bombaA[i].y1>maxY then
            begin
              maxY:=bombaA[i].y1;
            end;
        end;
      for i := 1 to nMedidor do
        begin
          readLn(fp,medidorA[i].x1, medidorA[i].y1, medidorA[i].angulo);
          if medidorA[i].x1<minX then
            begin
              minX:=medidorA[i].x1;
            end;
          if medidorA[i].y1<minY then
            begin
              minY:=medidorA[i].y1;
            end;
          if medidorA[i].x1>maxX then
            begin
              maxX:=medidorA[i].x1;
            end;
          if medidorA[i].y1>maxY then
            begin
              maxY:=medidorA[i].y1;
            end;
        end;
      for i := 1 to nLlave do
        begin
          readLn(fp,llaveA[i].x1, llaveA[i].y1, llaveA[i].angulo);
          if llaveA[i].x1<minX then
            begin
              minX:=llaveA[i].x1;
            end;
          if llaveA[i].y1<minY then
            begin
              minY:=llaveA[i].y1;
            end;
          if llaveA[i].x1>maxX then
            begin
              maxX:=llaveA[i].x1;
            end;
          if llaveA[i].y1>maxY then
            begin
              maxY:=llaveA[i].y1;
            end;
        end;

      closeFile(fp);

      centroRedX:=round(((maxX)-(minX))/2);
      centroRedY:=round(((maxY)-(minY))/2);


      //transformacion de escala
      for i := 1 to nCasa do
        begin
          for j := 1 to 10 do
            begin
              // Piso del Cubo, note que Cubo[1] = Cubo[5]
              Cubo[i][1].x := +TamFig+casa[i].x1-centroRedX; Cubo[i][1].y := +TamFig+casa[i].y1-centroRedY; Cubo[i][1].z := -100;
              Cubo[i][2].x := +TamFig+casa[i].x1-centroRedX; Cubo[i][2].y := -TamFig+casa[i].y1-centroRedY; Cubo[i][2].z := -100;
              Cubo[i][3].x := -TamFig+casa[i].x1-centroRedX; Cubo[i][3].y := -TamFig+casa[i].y1-centroRedY; Cubo[i][3].z := -100;
              Cubo[i][4].x := -TamFig+casa[i].x1-centroRedX; Cubo[i][4].y := +TamFig+casa[i].y1-centroRedY; Cubo[i][4].z := -100;
              Cubo[i][5].x := +TamFig+casa[i].x1-centroRedX; Cubo[i][5].y := +TamFig+casa[i].y1-centroRedY; Cubo[i][5].z := -100;
              // techo del Cubo, note que Cubo[6] = Cubo[10]
              Cubo[i][6].x := +TamFig+casa[i].x1-centroRedX; Cubo[i][6].y := +TamFig+casa[i].y1-centroRedY; Cubo[i][6].z := 0;
              Cubo[i][7].x := +TamFig+casa[i].x1-centroRedX; Cubo[i][7].y := -TamFig+casa[i].y1-centroRedY; Cubo[i][7].z := 0;
              Cubo[i][8].x := -TamFig+casa[i].x1-centroRedX; Cubo[i][8].y := -TamFig+casa[i].y1-centroRedY; Cubo[i][8].z := 0;
              Cubo[i][9].x := -TamFig+casa[i].x1-centroRedX; Cubo[i][9].y := +TamFig+casa[i].y1-centroRedY; Cubo[i][9].z := 0;
              Cubo[i][10].x := +TamFig+casa[i].x1-centroRedX; Cubo[i][10].y := +TamFig+casa[i].y1-centroRedY; Cubo[i][10].z := 0;
            end;
        end;

      //transformacion de escala
      for i := 1 to nEdificio do
        begin
          for j := 1 to 10 do
            begin
              // Piso del Cubo, note que Cubo[1] = Cubo[5]
              Cubo2[i][1].x := +TamFig+edificio[i].x1-centroRedX; Cubo2[i][1].y := +TamFig+edificio[i].y1-centroRedY; Cubo2[i][1].z := -200;
              Cubo2[i][2].x := +TamFig+edificio[i].x1-centroRedX; Cubo2[i][2].y := -TamFig+edificio[i].y1-centroRedY; Cubo2[i][2].z := -200;
              Cubo2[i][3].x := -TamFig+edificio[i].x1-centroRedX; Cubo2[i][3].y := -TamFig+edificio[i].y1-centroRedY; Cubo2[i][3].z := -200;
              Cubo2[i][4].x := -TamFig+edificio[i].x1-centroRedX; Cubo2[i][4].y := +TamFig+edificio[i].y1-centroRedY; Cubo2[i][4].z := -200;
              Cubo2[i][5].x := +TamFig+edificio[i].x1-centroRedX; Cubo2[i][5].y := +TamFig+edificio[i].y1-centroRedY; Cubo2[i][5].z := -200;
              // techo del Cubo, note que Cubo[6] = Cubo[10]
              Cubo2[i][6].x := +TamFig+edificio[i].x1-centroRedX; Cubo2[i][6].y := +TamFig+edificio[i].y1-centroRedY; Cubo2[i][6].z := 0;
              Cubo2[i][7].x := +TamFig+edificio[i].x1-centroRedX; Cubo2[i][7].y := -TamFig+edificio[i].y1-centroRedY; Cubo2[i][7].z := 0;
              Cubo2[i][8].x := -TamFig+edificio[i].x1-centroRedX; Cubo2[i][8].y := -TamFig+edificio[i].y1-centroRedY; Cubo2[i][8].z := 0;
              Cubo2[i][9].x := -TamFig+edificio[i].x1-centroRedX; Cubo2[i][9].y := +TamFig+edificio[i].y1-centroRedY; Cubo2[i][9].z := 0;
              Cubo2[i][10].x := +TamFig+edificio[i].x1-centroRedX; Cubo2[i][10].y := +TamFig+edificio[i].y1-centroRedY; Cubo2[i][10].z := 0;
            end;
        end;
      //transformacion de escala
      for i := 1 to nBomba do
        begin
          for j := 1 to 10 do
            begin
              // Piso del Cubo, note que Cubo[1] = Cubo[5]
              Cubo3[i][1].x := +TamFig+bombaA[i].x1-centroRedX; Cubo3[i][1].y := +TamFig+bombaA[i].y1-centroRedY; Cubo3[i][1].z := -40;
              Cubo3[i][2].x := +TamFig+bombaA[i].x1-centroRedX; Cubo3[i][2].y := -TamFig+bombaA[i].y1-centroRedY; Cubo3[i][2].z := -40;
              Cubo3[i][3].x := -TamFig+bombaA[i].x1-centroRedX; Cubo3[i][3].y := -TamFig+bombaA[i].y1-centroRedY; Cubo3[i][3].z := -40;
              Cubo3[i][4].x := -TamFig+bombaA[i].x1-centroRedX; Cubo3[i][4].y := +TamFig+bombaA[i].y1-centroRedY; Cubo3[i][4].z := -40;
              Cubo3[i][5].x := +TamFig+bombaA[i].x1-centroRedX; Cubo3[i][5].y := +TamFig+bombaA[i].y1-centroRedY; Cubo3[i][5].z := -40;
              // techo del Cubo, note que Cubo[6] = Cubo[10]
              Cubo3[i][6].x := +TamFig+bombaA[i].x1-centroRedX; Cubo3[i][6].y := +TamFig+bombaA[i].y1-centroRedY; Cubo3[i][6].z := 0;
              Cubo3[i][7].x := +TamFig+bombaA[i].x1-centroRedX; Cubo3[i][7].y := -TamFig+bombaA[i].y1-centroRedY; Cubo3[i][7].z := 0;
              Cubo3[i][8].x := -TamFig+bombaA[i].x1-centroRedX; Cubo3[i][8].y := -TamFig+bombaA[i].y1-centroRedY; Cubo3[i][8].z := 0;
              Cubo3[i][9].x := -TamFig+bombaA[i].x1-centroRedX; Cubo3[i][9].y := +TamFig+bombaA[i].y1-centroRedY; Cubo3[i][9].z := 0;
              Cubo3[i][10].x := +TamFig+bombaA[i].x1-centroRedX; Cubo3[i][10].y := +TamFig+bombaA[i].y1-centroRedY; Cubo3[i][10].z := 0;
            end;
        end;
      for i := 1 to nDistribuidor do
        begin
          for j := 1 to 10 do
            begin
              // Piso del Cubo, note que Cubo[1] = Cubo[5]
              cubo4[i][1].x := +TamFig+distribuidorA[i].x1-centroRedX; cubo4[i][1].y := +TamFig+distribuidorA[i].y1-centroRedY; cubo4[i][1].z := -20;
              cubo4[i][2].x := +TamFig+distribuidorA[i].x1-centroRedX; cubo4[i][2].y := -TamFig+distribuidorA[i].y1-centroRedY; cubo4[i][2].z := -20;
              cubo4[i][3].x := -TamFig+distribuidorA[i].x1-centroRedX; cubo4[i][3].y := -TamFig+distribuidorA[i].y1-centroRedY; cubo4[i][3].z := -20;
              cubo4[i][4].x := -TamFig+distribuidorA[i].x1-centroRedX; cubo4[i][4].y := +TamFig+distribuidorA[i].y1-centroRedY; cubo4[i][4].z := -20;
              cubo4[i][5].x := +TamFig+distribuidorA[i].x1-centroRedX; cubo4[i][5].y := +TamFig+distribuidorA[i].y1-centroRedY; cubo4[i][5].z := -20;
              // techo del Cubo, note que Cubo[6] = Cubo[10]
              cubo4[i][6].x := +TamFig+distribuidorA[i].x1-centroRedX; cubo4[i][6].y := +TamFig+distribuidorA[i].y1-centroRedY; cubo4[i][6].z := 0;
              cubo4[i][7].x := +TamFig+distribuidorA[i].x1-centroRedX; cubo4[i][7].y := -TamFig+distribuidorA[i].y1-centroRedY; cubo4[i][7].z := 0;
              cubo4[i][8].x := -TamFig+distribuidorA[i].x1-centroRedX; cubo4[i][8].y := -TamFig+distribuidorA[i].y1-centroRedY; cubo4[i][8].z := 0;
              cubo4[i][9].x := -TamFig+distribuidorA[i].x1-centroRedX; cubo4[i][9].y := +TamFig+distribuidorA[i].y1-centroRedY; cubo4[i][9].z := 0;
              cubo4[i][10].x := +TamFig+distribuidorA[i].x1-centroRedX; cubo4[i][10].y := +TamFig+distribuidorA[i].y1-centroRedY; cubo4[i][10].z := 0;
            end;
        end;

      for i := 1 to nLlave do
        begin
          for j := 1 to 10 do
            begin
              // Piso del Cubo, note que Cubo[1] = Cubo[5]
              cubo5[i][1].x := +TamFig+llaveA[i].x1-centroRedX; cubo5[i][1].y := +TamFig+llaveA[i].y1-centroRedY; cubo5[i][1].z := -10;
              cubo5[i][2].x := +TamFig+llaveA[i].x1-centroRedX; cubo5[i][2].y := -TamFig+llaveA[i].y1-centroRedY; cubo5[i][2].z := -10;
              cubo5[i][3].x := -TamFig+llaveA[i].x1-centroRedX; cubo5[i][3].y := -TamFig+llaveA[i].y1-centroRedY; cubo5[i][3].z := -10;
              cubo5[i][4].x := -TamFig+llaveA[i].x1-centroRedX; cubo5[i][4].y := +TamFig+llaveA[i].y1-centroRedY; cubo5[i][4].z := -10;
              cubo5[i][5].x := +TamFig+llaveA[i].x1-centroRedX; cubo5[i][5].y := +TamFig+llaveA[i].y1-centroRedY; cubo5[i][5].z := -10;
              // techo del Cubo, note que Cubo[6] = Cubo[10]
              cubo5[i][6].x := +TamFig+llaveA[i].x1-centroRedX; cubo5[i][6].y := +TamFig+llaveA[i].y1-centroRedY; cubo5[i][6].z := 0;
              cubo5[i][7].x := +TamFig+llaveA[i].x1-centroRedX; cubo5[i][7].y := -TamFig+llaveA[i].y1-centroRedY; cubo5[i][7].z := 0;
              cubo5[i][8].x := -TamFig+llaveA[i].x1-centroRedX; cubo5[i][8].y := -TamFig+llaveA[i].y1-centroRedY; cubo5[i][8].z := 0;
              cubo5[i][9].x := -TamFig+llaveA[i].x1-centroRedX; cubo5[i][9].y := +TamFig+llaveA[i].y1-centroRedY; cubo5[i][9].z := 0;
              cubo5[i][10].x := +TamFig+llaveA[i].x1-centroRedX; cubo5[i][10].y := +TamFig+llaveA[i].y1-centroRedY; cubo5[i][10].z := 0;
            end;
        end;

      for i := 1 to nTubo do
        begin
          for j := 1 to 2 do
            begin
              // Piso del Cubo, note que Cubo[1] = Cubo[5]
              tubo3D[i][1].x := tubo[i].x1-centroRedX; tubo3D[i][1].y := tubo[i].y1-centroRedY; tubo3D[i][1].z := 0;
              tubo3D[i][2].x := tubo[i].x2-centroRedX; tubo3D[i][2].y := tubo[i].y2-centroRedY; tubo3D[i][2].z := 0;
            end;
        end;
      for i := 1 to nManguera do
        begin
          for j := 1 to 2 do
            begin
              // Piso del Cubo, note que Cubo[1] = Cubo[5]
              manguera3D[i][1].x := manguera[i].x1-centroRedX; manguera3D[i][1].y := manguera[i].y1-centroRedY; manguera3D[i][1].z := 0;
              manguera3D[i][2].x := manguera[i].x2-centroRedX; manguera3D[i][2].y := manguera[i].y2-centroRedY; manguera3D[i][2].z := 0;
            end;
        end;


      Button10Click(Sender);
    end;


end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
begin

  image1.Canvas.Rectangle(0,0,600,600);



  //variables de proyeccion perspectiva
  ojoAObjeto:=100*10;
  D:=80*4;


end;

end.
