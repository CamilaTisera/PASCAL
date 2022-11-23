program OrdenarPorSeleccion;
const
  dimf=10;
type
  vector=array[1..dimf] of integer;

procedure CargarVector (var v:vector;  var diml:integer);
  var
    num:integer;
 begin
     diml:=0;
     readln(num);
    while(diml < dimf) do begin
       diml:=diml + 1 ;
       v[diml]:=num;
       readln(num)
    end;
end;

procedure OrdenarVectorSeleccion (var v:vector; diml:integer);
var
   num:integer;
   j,i,p:integer;
begin
    for i:=1 to diml-1 do  begin
        p:=i;
        writeln(p);
        for j:= i+1 to diml do
            if v[j] < v[p] then
            p:=j;
            writeln(p);
            num:=v[p];
            v[p]:=v[i];
            v[i]:=num;
       end;
  end;   
 

procedure ImprimirVectorSeleccion (v:vector; diml:integer);
var
   i:integer;
begin
     for i:=1 to diml do begin
         writeln(v[I]);
     end;
end;

//Programa Principal

var
   v:vector;
   diml:integer;
begin
    CargarVector(v,diml);
    OrdenarVectorSeleccion(v,diml);
    ImprimirVectorSeleccion(v, diml);
end.
