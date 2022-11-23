{4.- Un teatro tiene funciones los 7 días de la semana. Para cada día se tiene una lista con las entradas vendidas. 
Se desea procesar la información de una semana. Se pide:
a)	Generar 7 listas con las entradas vendidas para cada día. De cada entrada se lee día (de 1 a 7), código de la obra, asiento, monto. La lectura finaliza con el código de obra igual a 0.
 Las listas deben estar ordenadas por código de obra de forma ascendente.
b)	Generar una nueva lista que totalice la cantidad de entradas vendidas por obra. Esta lista debe estar ordenada por código de obra de forma ascendente.
c)	Realice un módulo recursivo que informe el contenido de la lista generada en b)
}


program Teatro;
const
  dimf=7;
 type
 
 dias=1..dimf;
 
 entrada=record
 dia:dias;
 cod:integer;
 asiento:integer;
 monto:real;
 end;
 
 entrada2=record
 cod:integer;
 tot:integer;
 end;
 
 lista=^nodo;
 
 nodo=record
 dato:entrada;
 sig:lista;
 end;
 
  lista2=^nodo2;
 
 nodo2=record
 dato:entrada2;
 sig:lista2;
 end;
 
 vector=array[dias] of lista;
 
 {a)	Generar 7 listas con las entradas vendidas para cada día. De cada entrada se lee día (de 1 a 7), código de la obra, asiento, monto. La lectura finaliza con el código de obra igual a 0.
 Las listas deben estar ordenadas por código de obra de forma ascendente.}
 
 procedure cargarVectorLista (var v:vector);
 
 procedure InicializarVector (var v:vector);
 var
 i:integer;
 begin
 for i:=1 to dimf do
 v[i]:=nil;
 end;
 
 procedure leerDatos (var e:entrada);
 begin
 writeln('Ingrese codigo');
 readln(e.cod);
 if(e.cod <> 0) then begin
 writeln('Ingrese dia');
 readln(e.dia);
 writeln('Ingrese asiento');
 readln(e.asiento);
 writeln('Ingrese monto');
 readln(e.monto);
 end;
 end;
 
 procedure InsertarOrdenado (var l:lista; e:entrada);
 var
 ant,nue,act:lista;
 begin
 new(nue);
 nue^.dato:=e;
 act:=l;
 while(act <> nil) and (act^.dato.cod < e.cod) do begin
 ant:=act;
 act:=act^.sig;
 end;
 if(act=l)then
 l:=nue
 else
 ant^.sig:=nue;
 nue^.sig:=act;
 end;
 
 var
 e:entrada;
 begin
 InicializarVector(v);
 leerDatos(e);
 while(e.cod<>0) do begin
 InsertarOrdenado(v[e.dia], e);
 leerDatos(e);
 end;
 end;
 
 function Validar (v:vector; var cant:integer):integer;
 var
 i:integer;
 begin
 cant:=0;
 for i:=1 to dimf do begin
   if(v[i] = nil) then
     cant:=cant + 1;
 end;
 Validar:=cant;
 end;
 
{ b)	Generar una nueva lista que totalice la cantidad de entradas vendidas por obra. Esta lista debe estar ordenada por código de obra de forma ascendente.}

procedure AgregarAtras (var l,ult:lista2; e:entrada2);
var
nue:lista2;
begin
new(nue);
nue^.dato:=e;
if(l<>nil) then
ult^.sig:=nue
else
l:=nue;
ult:=nue;
end;

procedure BuscarMinimo (var v:vector; var e:entrada);
var
pos,i:integer;
begin
 pos:=0;
 e.cod:=9999;
 for i:=1 to dimf do begin
 if(v[i]<>nil) then begin
 if(v[i]^.dato.cod < e.cod) then begin
 e:=v[i]^.dato;
 pos:=i
 end;
 end;
 end;
 if(e.cod<>9999) then
 v[pos]:= v[pos]^.sig;

end;

procedure Merge (var l:lista2; v:vector);
var
 act, tot:integer;
 ult:lista2;
e:entrada;
e2:entrada2;
begin
BuscarMinimo(v,e);
while(e.cod <> 9999) do begin
  tot:=0;
  act:=e.cod;
  while (e.cod <> 9999) and (e.cod = act) do begin
  tot:=tot + 1;
  BuscarMinimo(v,e);
  end;
  e2.cod:=act;
  e2.tot:=tot;
  AgregarAtras(l,ult,e2);
end;
end;

{c)	Realice un módulo recursivo que informe el contenido de la lista generada en b)}

procedure Imprimir (l:lista2);
begin
if(l<>nil) then begin
writeln('El codigo es: ' ,l^.dato.cod);
writeln('La cantidad es: ' ,l^.dato.tot);
Imprimir(l^.sig);
end;
end;


 var
 v:vector;
 cant:integer;
 l:lista2;
 begin
 l:=nil;
 cargarVectorLista(v);
 if(Validar(v,cant) = dimf) then
   writeln('El vector de lista esta vacio')
 else begin
 Merge(l,v);
 writeln;
 Imprimir(l);
 end;
 end.
