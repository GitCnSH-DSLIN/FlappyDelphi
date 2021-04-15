unit Objects;

interface

uses
  Classes, SysUtils, Graphics, Vcl.Dialogs, Math;

type
  TBitList = array [0 .. 10] of TBitmap;

  TBasic = class
  private
    x: Integer;
    y: Integer;
  public
    constructor Create(x0, y0: Integer); overload;
    procedure setX(x0: Integer);
    procedure setY(y0: Integer);
    function getX: Integer;
    function getY: Integer;
  end;

  TStatics = class(TBasic)
  private
    bitmap: TBitmap;
  public
    constructor Create(x0, y0: Integer; bitmap0: TBitmap);
    procedure setBitmap(bitmap0: TBitmap);
    function getBitmap: TBitmap;
  end;

  TAnimated = class(TBasic)
  private
    maxFrame: Integer;
    current: Integer;
    bitmap: TBitList;
  public
    constructor Create(x0, y0: Integer; bitmap0: TBitList; maxFrame0: Integer);
    procedure nextFrame;
    procedure setBitmap(bitmap0: TBitList);
    function getBitmap: TBitmap;

  end;

  TTube = class
  private
    x0: Integer;
    x1: Integer;
    y0: Integer;
    y1: Integer;
    bitmap: TBitList;
  public
    constructor Create(x, y: Integer; bitmap0: TBitList);
    function getBitmap(curr: Integer): TBitmap;
    function getXTop: Integer;
    function getYTop: Integer;
    function getXBottom: Integer;
    function getYBottom: Integer;
    procedure move;
    procedure setX(x: Integer);
    procedure setY;
  end;

  TPlayer = class(TAnimated)
  private
    gravity: Integer;
    isFalling: boolean;
  public
    faild: boolean;
    constructor Create(x0, y0: Integer; bitmap0: TBitList; maxFrame: Integer);
    procedure move;
    procedure jump;
    procedure falling;
  end;

implementation

{ TBasic }

constructor TBasic.Create(x0, y0: Integer);
begin
  x := x0;
  y := y0;
end;

function TBasic.getX: Integer;
begin
  result := x;
end;

function TBasic.getY: Integer;
begin
  result := y;
end;

procedure TBasic.setX(x0: Integer);
begin
  x := x0;
end;

procedure TBasic.setY(y0: Integer);
begin
  y := y0;
end;

{ TStatics }

constructor TStatics.Create(x0, y0: Integer; bitmap0: TBitmap);
begin
  x := x0;
  y := y0;
  bitmap := bitmap0;
end;

function TStatics.getBitmap: TBitmap;
begin
  result := bitmap;
end;

procedure TStatics.setBitmap(bitmap0: TBitmap);
begin
  bitmap := bitmap0;
end;

{ TAnimated }

constructor TAnimated.Create(x0, y0: Integer; bitmap0: TBitList;
  maxFrame0: Integer);
begin
  x := x0;
  y := y0;
  bitmap := bitmap0;
  maxFrame := maxFrame0;
  current := 0;
end;

function TAnimated.getBitmap: TBitmap;
begin
  result := bitmap[current];
end;

procedure TAnimated.nextFrame;
begin
  if current >= maxFrame then
    current := 0
  else
    current := current + 1;
end;

procedure TAnimated.setBitmap(bitmap0: TBitList);
begin
  bitmap := bitmap0;
end;

{ TPlayer }

constructor TPlayer.Create(x0, y0: Integer; bitmap0: TBitList;
  maxFrame: Integer);
begin
  inherited;
  gravity := 5;
  isFalling := True;
  faild := False;
end;

procedure TPlayer.falling;
begin
  if (y + 24) >= 400 then
  begin
    y := (400 - 24);
    faild := True;
  end
  else
    faild := False;
end;

procedure TPlayer.jump;
begin
  gravity := -8;
end;

procedure TPlayer.move;
begin

  if gravity < 5 then
    gravity := gravity + 1;
  y := y + gravity;

end;

{ TTube }

constructor TTube.Create(x, y: Integer; bitmap0: TBitList);
begin
  x1 := x;
  y1 := y;
  y0 := y1 - 420;
  x0 := x;
  bitmap := bitmap0;
end;

function TTube.getBitmap(curr: Integer): TBitmap;
// Top = 0, Bottom = 1
begin
  if curr = 0 then
    result := bitmap[0];
  if curr = 1 then
    result := bitmap[1];
end;

function TTube.getXBottom: Integer;
begin
  result := x1;
end;

function TTube.getYBottom: Integer;
begin
  result := y1;
end;

function TTube.getXTop: Integer;
begin
  result := x0;
end;

function TTube.getYTop: Integer;
begin
  result := y0;
end;

procedure TTube.move;
var
  i: Integer;
begin

  if x0 = 288 then
  begin
    Randomize;
    i := RandomRange(150, 300);
    y0 := i - 420;
    y1 := i;
  end;

  if x0 <= -52 then
    x0 := 288
  else
    x0 := x0 - 6;
  x1 := x0;
end;

procedure TTube.setX(x: Integer);
begin
  x0 := x;
end;

procedure TTube.setY;
var
  i: Integer;
begin
  Randomize;
  i := RandomRange(150, 300);
  y0 := i - 420;
  y1 := i;
end;

end.
