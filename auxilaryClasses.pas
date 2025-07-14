unit auxilaryClasses;

interface
uses windows, sysutils, graphics, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, Forms,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait,
  classes, engineThread, System.Generics.Collections;
type
//TMap = array of array of TColor;
TState = (sMany, sOne);
TmapSaver = class
  class procedure saver(filename:string; MainMap, OriginMap:Tmap);
  class procedure opener(filename:string; var MainMap, OriginMap:Tmap);
end;

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
    Fquery: TfdQuery;
    FSimilar: TColor;
    FStandart: string;
    FSimHex: string;
    FSimStand: string;
    FStandNum: string;
    FState: TState;
    FSimChanged: boolean;
    //FChanged: Boolean;
    function GetHex:string;
    procedure SetColor(const Value: TColor);
    procedure SetStandart(const Value: string);
    procedure SetState(const Value: TState);

    public
    //procedure ResetSim;
    procedure SetSimilar(SimColor: Tcolor; SimName, SimStand, SimHex, StandNum:string);
    property Standart:string read FStandart write SetStandart;
    property Color:TColor read FColor write SetColor;
    property HexColor:string read GetHex;
    property Similar:TColor read FSimilar;
    property SimName: string read FSimName;
    property SimHex: string read FSimHex;
    property SimStand: string read FSimStand;
    property SimStandartNumber: string read FStandNum;
    property State: TState write SetState;
    property Query: TFdQuery read FQuery;
    constructor Create;
  end;
TUnCell=record
  MasterColor: Tcolor;
  Similar: Tcolor;
  SimName: string;
  SimHex: String;
  SimStandartNumber: string;
end;

TPalette=class
  private
  FArPalette:TArray<TCell>;
  //FUndo: array[0..0] of TArray<TCell>;
  //FArPalLen: byte;
  FUndo: TStack<TUnCell>; //position, oldColor
  protected
  function SeekNumberByColor(color: Tcolor):byte;
  public
  selector: byte;
  constructor Create;
  procedure SetPalette(arpallete:TArray<TPair<TColor,word>> ); //color, amount
  procedure SaveUndo(pos: byte);
  procedure LoadFromUndo;
  function ArPalLen: byte;
  property ArPalette:TArray<tCell> read FArPalette;
end;



procedure CopyMap(const From: TMap; var WhereTo: TMap);

implementation

procedure CopyMap(const From: TMap; var WhereTo: TMap);
begin
for var i := low(From) to high(From)  do
    WhereTo[i]:=copy(From[i],0,length(From[0]))
end;

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
  fsimChanged:=false;
  //fchanged:=false;

end;

function TCell.GetHex: string;
begin
   result:= copy(IntToHex(colortorgb(rgb(getbvalue(color),getgvalue(color),getrvalue(color)))),3,6); //to swap r<->b for true hex representation
end;

{procedure TCell.ResetSim;
begin
  FSimChanged:=false;
  SetColor(Fcolor);
end;}

procedure TCell.SetColor(const Value: TColor);
//var   s:string;
begin
  FColor := Value;

  with FQuery do
  begin
    //SQL.Text:= Format('update colors set s=',[r,r,g,g,b,b]);
    //SQL.Add(s);
    //ExecSQL;
    SetState(sOne);
    if FSimChanged=false then
      FSimilar:=RGB(fieldbyname('r').AsInteger,fieldbyname('g').AsInteger,fieldbyname('b').AsInteger);
    FSimName:=fieldbyname('name').AsString;
    FSimStand:=fieldbyname('standart').AsString;
    FSimhex:=fieldbyname('hex').AsString;
    FStandNum:=fieldbyname('standartnumber').AsString;
    //active:=false;
  end;
end;

procedure TCell.SetSimilar(SimColor: Tcolor; SimName, SimStand, SimHex,
  StandNum: string);
begin
  FSimilar:=SimColor;
  FSimName:=SimName;
  FSimStand:=SimStand;
  FSimHex:=SimHex;
  FStandNum:=StandNum;
  FSimChanged:=true;
end;

procedure TCell.SetStandart(const Value: string);
begin
  FStandart := Value;
  FSimChanged:=false;
  SetColor(Fcolor);
end;

procedure TCell.SetState(const Value: TState);
var s,ss:string;
    r,g,b: integer;
begin
  FState:=value;
  r:=GetRValue(FColor);
  g:=GetGValue(FColor);
  b:=GetBValue(FColor);
  s:=' where standart='''+standart+'''';
  with FQuery.sql do
  begin
    //close;
    Clear;
    Add('with dist as');
    ss:=Format('(select *, (%d-r)*(%d-r)+(%d-g)*(%d-g)+(%d-b)*(%d-b) as s from colors',[r,r,g,g,b,b]);
    Add(ss+s +')');

    if value=sMany then //list of colors remoted from you and ordered
    Add('select s , name,r,g,b, hex,standart,standartnumber from dist order by s')
    else  //the nearest=similair initially
    Add('select min(s)as ms , name,r,g,b, hex,standart,standartnumber from dist');

  end;
    FQuery.Open;

end;

{ TmapSaver }

class procedure TmapSaver.opener(filename: string; var MainMap,
  OriginMap: Tmap);
var filestream: TFileStream;
    buf, m,n:integer;
begin
      filestream:=TFileStream.Create(FileName,fmOpenRead);
      filestream.ReadBuffer(buf,4);  m:=buf;
      filestream.ReadBuffer(buf,4);  n:=buf;
      setlength(MainMap,m,n); setLength(OriginMap,m,n);
      for var i := 0 to m-1 do
      for var j := 0 to n-1 do
      begin
       filestream.ReadBuffer(MainMap[i,j],sizeof(TColor));
       filestream.ReadBuffer(OriginMap[i,j],sizeof(TColor));
      end;
      filestream.Free;
end;

class procedure TmapSaver.saver(filename: string; MainMap, OriginMap: Tmap);
var //memstream: TMemoryStream;
    filestream: TfileStream;
    m,n:integer;
begin
      filestream:=TFileStream.Create(FileName+'.moz',fmcreate);
      m:=length(MainMap); n:=length(mainMap[0]);
      filestream.Write(m,sizeof(integer));
      filestream.Write(n,sizeof(integer));
      for var i := 0 to m-1 do
      for var j := 0 to n-1 do
      begin
       filestream.Write(MainMap[i,j],sizeof(TColor));
       filestream.Write(OriginMap[i,j],sizeof(TColor));
      end;
      filestream.Free;


end;

{ TPalette }

function TPalette.ArPalLen: byte;
begin
  result:=length(FArPalette);
end;

constructor TPalette.Create;
begin
   FUndo:=TStack<TUnCell>.create;
end;

procedure TPalette.LoadFromUndo;
var foo: TUncell;
begin
  //FArpalette:=copy(FUndo[0],0,length(FUndo[0]));
  if not(fundo.IsEmpty) then
  
  foo:=FUndo.Pop;
  FArpalette[seeknumberbycolor(foo.MasterColor)].SetSimilar(foo.Similar, foo.SimName, farpalette[0].Standart, foo.SimHex, foo.SimStandartNumber);
end;

procedure TPalette.SaveUndo(pos: byte);
var foo: TUnCell;
begin
  //Fundo[0]:=copy(FArpalette,0,length(farpalette));
  foo.MasterColor:=farpalette[pos].Color;
  foo.Similar:=FArpalette[pos].Similar;
  foo.SimName:=FArpalette[pos].SimName;
  foo.SimHex:=FArpalette[pos].SimHex;
  foo.SimStandartNumber:=FArpalette[pos].SimStandartNumber;
  FUndo.Push(foo);
end;

function TPalette.SeekNumberByColor(color: Tcolor): byte;
begin
  for var i := Low(farpalette) to High(farpalette) do
    if FArPalette[i].Color=color then
    begin
      result:=i; break;
    end;
end;

procedure TPalette.SetPalette(arpallete:TArray<TPair<TColor,word>> );
var buf: TCell; m:byte;
begin
     if selector=0 then
      begin
        setlength(FArPalette,length(arpallete));
        for var i := Low(arpallete) to High(arpallete) do
         begin
           FArPalette[i]:=tcell.Create;
           FArPalette[i].color:=arpallete[i].Key;
           FArPalette[i].number:=i;
           FArPalette[i].amount:=arpallete[i].Value;
           //if selector.ItemIndex<>0 then mycell.Standart:=selector.Text;
           FArPalette[i].pressed:=false;
           //dg.Objects[(i div RCOUNT), (i mod RCOUNT)]:=FArPalette[i];
           //mycell.Destroy;
         end;
         //arrlength:=length(arpallete);
      end

      else
      begin
       for var k := Low(arpallete) to High(arpallete) do
         begin
              for m := k to High(FArPalette) do
                //c:=dg.Objects[i,j] as TCell;
                if FArPalette[m].Similar=arpallete[k].Key then
                begin
                  buf:=FArPalette[m];
                  FArPalette[m]:=FArPalette[k];
                  FArPalette[k]:=buf;
                  FArPalette[k].number:=k; FArPalette[m].number:=m;
                  break //continue
                end;

         end;
       for m := high(arpallete)+1 to High(FArPalette) do
             FArPalette[m]:=nil;
       setlength(FArPalette,length(arpallete));
       //Resize;
      end;

end;

end.
