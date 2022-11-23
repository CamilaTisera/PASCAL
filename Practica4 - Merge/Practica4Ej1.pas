{1.	 Una biblioteca nos ha encargado procesar la información de los préstamos realizados durante el año 2021. 
De cada préstamo se conoce el ISBN del libro, el número de socio, día y mes del préstamo y cantidad de días prestados. Implementar un programa con:
a.	Un módulo que lea préstamos y retorne en una estructura adecuada la información de los préstamos organizada por mes. 
Para cada mes, los préstamos deben quedar ordenados por ISBN. La lectura de los préstamos finaliza con ISBN -1.
b.	Un módulo recursivo que reciba la estructura generada en a. y muestre, para cada mes, ISBN y numero de socio.
c.	Un módulo que reciba la estructura generada en a. y retorne una nueva estructura con todos los préstamos ordenados por ISBN.
d.	Un módulo recursivo que reciba la estructura generada en c. y muestre todos los ISBN y número de socio correspondiente.
e.	Un módulo que reciba la estructura generada en a. y retorne una nueva estructura ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces que se prestó durante el año 2021.
f.	Un módulo recursivo que reciba la estructura generada en e. y muestre su contenido.
}

program Merge;
const
   dimf=7;
type

  meses=1..dimf;
  
  prestamo=record
    isbn:integer;
    num:integer;
    dia:integer;
    mes:integer;
    cant:integer;
  end;
  
  lista=^nodo;
  
  nodo=record
    dato:prestamo;
    sig:lista;
  end;
  
   lista2=^nodo2;
  
  nodo2=record
    dato:prestamo;
    sig:lista2;
  end;
  
  vector=array[meses] of lista;
  
  
  procedure InicializarVectorDeLista (var v:vector);
  var
    i:integer;
  begin
    for i:=1 to dimf do 
      v[i]:=nil;
  end;
  
  procedure leerDatos (var p:prestamo);
  begin
    writeln('Ingrese isbn');
    readln(p.isbn);
    if(p.isbn<>-1) then begin
    writeln('Ingrese num');
    readln(p.num);
    writeln('Ingrese dia');
    readln(p.dia);
    writeln('Ingrese mes');
    readln(p.mes);
    writeln('Ingrese cant');
    readln(p.cant);
    end;
  end;

  Procedure InsertarOrdenadoEnLista(var L: lista; p: prestamo);
var 
     ant, nue, act: lista;
begin
     new (nue);
     nue^.dato := p;
     act := L;
     while (act<>NIL) and (act^.dato.isbn < p.isbn) do begin  {ord de menor a mayor}
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
  p:prestamo;
begin
    InicializarVectorDeLista(v);
   leerDatos(p);
   while(p.isbn <> -1 ) do begin
       InsertarOrdenadoEnLista(v[p.mes], p);
       leerDatos(p);
   end;
end;

//b.	Un módulo recursivo que reciba la estructura generada en a. y muestre, para cada mes, ISBN y numero de socio.

procedure ImprimirVectorLista (v:vector);

procedure Imprimir (l:lista);
begin
       if(l <> nil) then  begin
        writeln('El isbn es: ',l^.dato.isbn);
        writeln('El numero de socio es: ' , l^.dato.num);
         Imprimir (l^.sig);
      end;
end;

var 
  i:integer;
begin
    for i:=1 to dimf do begin
      writeln('Mes: ', i);
       Imprimir(v[i])
     end;
end;

//c.	Un módulo que reciba la estructura generada en a. y retorne una nueva estructura con todos los préstamos ordenados por ISBN.

Procedure AgregarAtras (var l, ult: lista; p:prestamo);
var
 nue:lista;
begin
 new (nue);
 nue^.dato:= p;
 nue^.sig := nil;
 if l= nil then 
 l:= nue
   else 
           ult^.sig:= nue;
 ult:= nue;

end;
Procedure BuscarMinimo(var v:vector;var min:prestamo);
var
   pos, i:integer;
Begin
   pos:=0;
   min.isbn:=999;
   for i:= 1 to dimf do begin
       if(v[i]<>nil) then begin
            if(v[i]^.dato.isbn < min.isbn) then begin
                 min:=v[i]^.dato;
                 pos:=i;
            end;
        end;
    end;

    if(min.isbn<>999) then begin
        v[pos]:=v[pos]^.sig;
    end;
End;

Procedure Merge(var l: lista; v: vector);
Var
   min:prestamo; 
   ult:lista;
Begin
   ult:=nil;
   BuscarMinimo(v,min);
   while(min.isbn<>999) do begin
        AgregarAtras(l,ult,min);
        BuscarMinimo(v,min);
   end;
End;


//d.	Un módulo recursivo que reciba la estructura generada en c. y muestre todos los ISBN y número de socio correspondiente.

procedure imprimirEnOrdenInverso(l:lista);
begin
   if(L<>nil)then begin
        imprimirEnOrdenInverso(L^.sig);
        writeln('El isbn es: ',L^.dato.isbn);
        writeln('El numero de socio es:',L^.dato.num);
        end;
end;

//e.	Un módulo que reciba la estructura generada en a. y retorne una nueva estructura ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces que se prestó durante el año 2021.

Procedure AgregarAtras2 (var l, ult: lista2; p:prestamo);
var
 nue:lista2;
begin
 new (nue);
 nue^.dato:= p;
 nue^.sig := nil;
 if l= nil then 
 l:= nue
   else 
           ult^.sig:= nue;
 ult:= nue;

end;

procedure MergeAcumulador(var l: lista2; v:vector);
var
    act:integer;
    total:integer;
    ult:lista2;
    p:prestamo; //viejo
    p2:prestamo; //nuevo
begin
   ult:=nil;
   BuscarMinimo(v,p);
   while (p.isbn <> 999)do begin
        total:=0;
        act:= p.isbn; //voy preguntando por isbn
        while (p.isbn <> 999) and  (act = p.isbn) do begin
            total:= total + p.cant;
            BuscarMinimo(v, p);
        end;
       p2.cant:=total;
       p2.isbn:=act;
       AgregarAtras2(l, ult,p2);
   end;
end;

//f.	Un módulo recursivo que reciba la estructura generada en e. y muestre su contenido.

procedure imprimirLista(l:lista2);
begin
   if(l<>nil)then begin
        imprimirLista(l^.sig);
        writeln('El isbn es: ',l^.dato.isbn);
        writeln('Cantidad:',l^.dato.cant);
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
  l:lista;
  l2:lista2;
begin
   l:=nil;
   l2:=nil;
   cargarVectorLista(v);
   if (Vacio(v) = dimf) then
     writeln('El vector de lista esta vacio')
   else begin
   writeln('Imprimir vector de lista');
   ImprimirVectorLista(v);
   writeln;
   Merge(l,v);
   writeln('Imprimir lista con Merge');
   imprimirEnOrdenInverso(l);
   MergeAcumulador(l2,v);
   writeln;
   writeln('Imprimir lista con Merge acumulador');
   imprimirLista(l2);
   end;
end.
