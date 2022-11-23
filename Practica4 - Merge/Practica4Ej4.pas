{4.	Un teatro tiene funciones los 7 días de la semana. Para cada día se tiene una lista con las entradas vendidas. Se desea procesar la información de una semana. Implementar un programa que:
a.	Genere 7 listas con las entradas vendidas para cada día. De cada entrada se lee día (de 1 a 7), código de la obra, asiento y monto. La lectura finaliza con el código de obra igual a 0. 
Las listas deben estar ordenadas por código de obra de forma ascendente. 
b.	Genere una nueva lista que totalice la cantidad de entradas vendidas por obra. Esta lista debe estar ordenada por código de obra de forma ascendente.}

program Teatro;
const
  dimf=7;
  type
    dias=1..dimf;
    
    entrada=record
       dia:dias;
       cod:integer;
       monto:real;
       asiento:integer;
    end;
    
    entrada2=record
      cod:integer;
      cant:integer;
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
    
   procedure InicializarVectorDeLista (var v:vector);
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
  if(e.cod<>0) then begin
   writeln('Ingrese dia');
  readln(e.dia);
   writeln('Ingrese monto');
  readln(e.monto);
   writeln('Ingrese asiento');
  readln(e.asiento);
  end;
  end;
 

  Procedure InsertarOrdenadoEnLista(var L: lista; e: entrada);
var 
     ant, nue, act: lista;
begin
     new (nue);
     nue^.dato := e;
     act := L;
     while (act<>NIL) and (act^.dato.cod < e.cod) do begin  {ord de menor a mayor}
           ant := act;
           act := act^.sig ;
           end;
     if (act = L) then   
            L:= nue
     else 
            ant^.sig := nue;
     nue^.sig := act ;
end;

 procedure cargarVectorLista (var v:vector);
var
  e:entrada;
begin
    InicializarVectorDeLista(v);
   leerDatos(e);
   while(e.cod <> 0 ) do begin
       InsertarOrdenadoEnLista(v[e.dia], e);
       leerDatos(e);
   end;
end;

 procedure ImprimirVectorLista (v:vector);

procedure Imprimir (l:lista);
begin
       if(l <> nil) then  begin
        writeln('El cod es: ',l^.dato.cod);
        writeln('El monto es: ' , l^.dato.monto:2:2);
        writeln('El asiento es: ' , l^.dato.asiento);
         Imprimir (l^.sig);
      end;
end;

var 
  i:integer;
begin
    for i:=1 to dimf do begin
      writeln('Dia: ', i);
       Imprimir(v[i])
     end;
end;

Procedure AgregarAtras (var l, ult: lista2; e:entrada2);
var
 nue:lista2;
begin
 new (nue);
 nue^.dato:=e ;
 nue^.sig := nil;
 if l= nil then 
 l:= nue
   else 
           ult^.sig:= nue;
 ult:= nue;

end;



Procedure BuscarMinimo(var v:vector;var min:entrada);
var
   pos, i:integer;
Begin
   pos:=0;
   min.cod:=999;
   for i:= 1 to dimf do begin
       if(v[i]<>nil) then begin
            if(v[i]^.dato.cod < min.cod) then begin
                 min:=v[i]^.dato;
                 pos:=i;
            end;
        end;
    end;

    if(min.cod<>999) then begin
        v[pos]:=v[pos]^.sig;
    end;
End;

procedure MergeAcumulador(var l: lista2; v:vector);
var
    act:integer;
    total:integer;
    e:entrada; //viejo
    e2:entrada2; //nuevo
    ult:lista2;
begin
   BuscarMinimo(v,e);
   while (e.cod <> 999)do begin
        total:=0;
        act:= e.cod; //voy preguntando por cod
        while (e.cod <> 999) and  (act = e.cod) do begin
            total:= total + 1;
            BuscarMinimo(v, e);
        end;
       e2.cant:=total;
       e2.cod:=act;
       AgregarAtras(l,ult,e2);
   end;
end;

procedure imprimirLista(l:lista2);
begin
   if(l<>nil)then begin
        writeln('El cod es: ',l^.dato.cod);
        writeln('Cantidad:',l^.dato.cant);
         imprimirLista(l^.sig);
        end;
end;

function Vacio (v:vector):integer;
var
  i, cant:integer;
begin
  cant:=0;
   for i:= 1 to dimf do begin
     if (v[i] = nil) then
         cant:=cant + 1;
   end;
      Vacio:=cant;
end;

  var
   v:vector;
   l:lista2;
 begin
  l:=nil;
  cargarVectorLista(v);
    if (Vacio(v) = dimf) then
     writeln('El vector de lista esta vacio')
   else begin
  writeln('Imprimir vector de lista');
  writeln;
  ImprimirVectorLista(v);
  writeln;
  writeln('Imprimir Merge acumulador');
  MergeAcumulador(l,v);
  imprimirLista(l);
  end;
 end.
