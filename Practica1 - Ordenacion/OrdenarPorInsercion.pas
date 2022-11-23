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

procedure OrdenarVectorPorInsercion (var v:vector; diml:integer);
var
   num:integer;
   j,i:integer;
begin
    for i:=2 to diml-1 do  begin
        num:=v[i];
        j:=i-1;
       while (j>0) and (v[j] > num) do begin
            v[j+1]:=v[j];
            j:= j - 1
       end;
       v[j+1]:=num;
  end;   
 end;

procedure ImprimirVectorInsercion (v:vector; diml:integer);
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
    OrdenarVectorPorInsercion(v,diml);
    ImprimirVectorInsercion(v, diml);
end.
