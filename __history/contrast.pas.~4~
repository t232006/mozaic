unit contrast;

interface
uses Math, graphics, windows;
type TRGBColor = record Red, Green, Blue : Byte; end;

THSBColor = record Hue, Saturnation, Brightness : Double;
end;
function ContrastColor(AColor: TColor; tolerance:real): TColor;



implementation

function ContrastColor(AColor: TColor; tolerance:real): TColor;


  function HSVtoRGB(h: integer; s,v: double):TColor;
var
  Hi: integer;
  f,p,q,t,r,g,b: double;
begin
  Hi:=(h div 60) mod 6;
  f:=h/60-(h div 60);
  p:=v*(1-s);
  q:=v*(1-f*s);
  t:=v*(1-(1-f)*s);
  case hi of
  0:
   begin
    r:=v;
    g:=t;
    b:=p;
   end;
  1:
   begin
    r:=q;
    g:=v;
    b:=p;
   end;
  2:
   begin
    r:=p;
    g:=v;
    b:=t;
   end;
  3:
   begin
    r:=p;
    g:=q;
    b:=v;
   end;
  4:
   begin
    r:=t;
    g:=p;
    b:=v;
   end;
  5:
   begin
    r:=v;
    g:=p;
    b:=q;
   end;
  end;
  result:=RGB(round(r*255),round(g*255),round(b*255));
end;

  function RGBToHSB(rgb : TRGBColor) : THSBColor;
  var minRGB, maxRGB, delta : Double; h , s , b : Double ;
  begin
  H := 0.0 ;
  minRGB := Min(Min(rgb.Red, rgb.Green), rgb.Blue) ;
  maxRGB := Max(Max(rgb.Red, rgb.Green), rgb.Blue) ;
  delta := ( maxRGB - minRGB ) ;

  b := maxRGB ;

  if (maxRGB <> 0.0) then
  s := 255.0 * Delta / maxRGB
  else s := 0.0;

  if (s <> 0.0) then
  begin
  if rgb.Red = maxRGB then
  h := (rgb.Green - rgb.Blue) / Delta
  else if rgb.Green = minRGB then
  h := 2.0 + (rgb.Blue - rgb.Red) / Delta
  else if rgb.Blue = maxRGB then
  h := 4.0 + (rgb.Red - rgb.Green) / Delta
  end
  else h := -1.0; h := h * 60 ;

  if h < 0.0 then h := h + 360.0;

  with result do
  begin
  Hue := h; Saturnation := s / 255;
  Brightness := b / 255;
  end;
end;
var rgb:Trgbcolor;  hsb:Thsbcolor;
begin
  rgb.Red:=getRvalue(AColor);
  rgb.Green:=getGValue(AColor);
  rgb.Blue:=getBvalue(AColor);
  hsb:=rgbtohsb(rgb);
  if (hsb.Saturnation<tolerance/100) or (hsb.Brightness<tolerance/100) then
  begin
  hsb.Brightness:=1;
  hsb.Saturnation:=0;

  if {(1-hsb.Saturnation>tolerance/100) or} (1-hsb.Brightness<tolerance/100) then
    begin
    hsb.Brightness:=0;
    hsb.Saturnation:=1;
    end
  end
  else
  hsb.Hue:=hsb.Hue-180; if hsb.Hue<0 then hsb.Hue:=hsb.Hue+360;
  result:=hsvtorgb(round(hsb.Hue), hsb.Saturnation, hsb.Brightness);

end;

end.
