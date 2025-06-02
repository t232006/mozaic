unit auxilaryClasses;

interface
uses windows, sysutils, graphics, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, Forms,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait;
type
TQueryMode=(shortDist, all);
TCell = class

    number: byte;
    amount: word;
    pressed: boolean;
    {Similair: TColor;
    SimName: string;}
    private
    Fcolor: TColor;
    FSimName: string;
    FConn: TfdConnection;
    FSimilar: TColor;
    FStandart: string;
    FSimHex: string;
    FSimStand: string;
    FStandNum: string;
    Fquery: TfdQuery;
    FQueryMode: TQueryMode;
    function GetHex:string;
    procedure SetColor(const Value: TColor);
    procedure SetStandart(const Value: string);
    procedure SetMode(const Value: TQueryMode);
    public
    property Query: TfdQuery read FQuery;
    property QueryMode:TQueryMode write SetMode;
    property Standart:string read FStandart write SetStandart;
    property Color:TColor read FColor write SetColor;
    property HexColor:string read GetHex;
    property Similar:TColor read FSimilar;
    property SimName: string read FSimName;
    property SimHex: string read FSimHex;
    property SimStand: string read FSimStand;
    property SimStandartNumber: string read FStandNum;

    constructor Create;
  end;
implementation


{ TCell }
constructor TCell.Create;
begin
  Fconn:=TFDConnection.Create(Application);
  Fconn.Params.Clear;
  Fconn.Params.Add('Database='+ ExtractFilePath(ParamStr(0)) + 'listofColorsExt.db');
  FConn.Params.Add('DriverID=SQLite');
  Fconn.Connected:=true;
  fquery:=tfdquery.Create(application);
  fquery.Connection:=fconn;
  standart:='Classic';
end;

function TCell.GetHex: string;
begin
   result:= copy(IntToHex(colortorgb(rgb(getbvalue(color),getgvalue(color),getrvalue(color)))),3,6); //to swap r<->b for true hex representation
end;

procedure TCell.SetColor(const Value: TColor);
var r,g,b: integer; s:string;
begin
  FColor := Value;
  r:=GetRValue(FColor);
  g:=GetGValue(FColor);
  b:=GetBValue(FColor);
  with FQuery do
  begin
    s:='where standart='''+standart+''' ';
    SQL.Text:=Format('update colors set s=(%d-r)*(%d-r)+(%d-g)*(%d-g)+(%d-b)*(%d-b)',[r,r,g,g,b,b]);
    SQL.Add(s);
    ExecSQL;
    QueryMode:=ShortDist;
    FSimilar:=RGB(fields[4].AsInteger,fields[5].AsInteger,fields[6].AsInteger);
    FSimName:=fields[3].AsString;
    FSimStand:=fields[0].AsString;
    FSimhex:=fields[1].AsString;
    FStandNum:=fields[2].AsString;
  end;
end;

procedure TCell.SetMode(const Value: TQueryMode);
var s:string;
begin
with FQuery do
  begin
  s:='where standart='''+standart+''' ';
  SQL.Clear;
  if value=ShortDist then
      SQL.Add('select * from colors '+s+ 'and s=(select min(s) from colors ')
  else
      SQL.Add('select * from colors '+s);
  SQL.Add(s);
  SQL.add(')');
  Open;
  end;

end;

procedure TCell.SetStandart(const Value: string);
begin
  FStandart := Value;
  SetColor(Fcolor);
end;

end.
