{3.	Implementar un programa que procese la información de las ventas de productos de una librería que tiene 4 sucursales. 
De cada venta se lee fecha de venta, código del producto vendido, código de sucursal y cantidad vendida. El ingreso de las ventas finaliza cuando se lee el código de sucursal 0. Implementar un programa que:
a.	Almacene las ventas ordenadas por código de producto y agrupados por sucursal, en una estructura de datos adecuada.
b.	Contenga un módulo que reciba la estructura generada en el punto a y retorne una estructura donde esté acumulada la cantidad total vendida para cada código de producto.}

program Sucur;
const
  dimf=4;
type 
  sucursales=1..dimf;
  
  venta=record
  fecha:integer;
  cod:integer;
  suc:integer;
  cant:integer;
  end;
  
  venta2=record
   cod:integer;
   tot:integer;
  end;
  
  lista=^nodo;
  
  nodo=record
    dato:venta;
    sig:lista;
  end;
  
    lista2=^nodo2;
  
  nodo2=record
    dato:venta2;
    sig:lista2;
  end;
  
  vector=array[sucursales] of lista;
  
  procedure InicializarVectorDeLista (var v:vector);
  var
    i:integer;
  begin
    for i:=1 to dimf do 
      v[i]:=nil;
  end;
  
  procedure leerDatos (var v:venta);
  begin
    writeln('Ingrese sucursal');
    readln(v.suc);
    if(v.suc<>0) then begin
    writeln('Ingrese fecha');
    readln(v.fecha);
    writeln('Ingrese codigo');
    readln(v.cod);
    writeln('Ingrese cantidad');
    readln(v.cant);
    end;
  end;

  Procedure InsertarOrdenadoEnLista(var L: lista; v: venta);
var 
     ant, nue, act: lista;
begin
     new (nue);
     nue^.dato := v;
     act := L;
     while (act<>NIL) and (act^.dato.cod < v.cod) do begin  {ord de menor a mayor}
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
  vt:venta;
begin
    InicializarVectorDeLista(v);
   leerDatos(vt);
   while(vt.suc <> 0 ) do begin
       InsertarOrdenadoEnLista(v[vt.suc], vt);
       leerDatos(vt);
   end;
end;
  
  procedure ImprimirVectorLista (v:vector);

procedure Imprimir (l:lista);
begin
       if(l <> nil) then  begin
        writeln('El cod es: ',l^.dato.cod);
        writeln('El Fecha es: ' , l^.dato.fecha);
        writeln('El Cantidad es: ' , l^.dato.cant);
         Imprimir (l^.sig);
      end;
end;

var 
  i:integer;
begin
    for i:=1 to dimf do begin
      writeln('Sucursal: ', i);
       Imprimir(v[i])
     end;
end;

Procedure AgregarAtras2 (var l, ult: lista2; v:venta2);
var
 nue:lista2;
begin
 new (nue);
 nue^.dato:= v;
 nue^.sig := nil;
 if l= nil then 
 l:= nue
   else 
           ult^.sig:= nue;
 ult:= nue;

end;

Procedure BuscarMinimo(var v:vector;var min:venta);
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
    ult:lista2;
    vt:venta; //viejo
    vt2:venta2; //nuevo
begin
   ult:=nil;
   BuscarMinimo(v,vt);
   while (vt.cod <> 999)do begin
        total:=0;
        act:= vt.cod; //voy preguntando por cod
        while (vt.cod <> 999) and  (act = vt.cod) do begin
            total:= total + vt.cant;
            BuscarMinimo(v, vt);
        end;
       vt2.tot:=total;
       vt2.cod:=act;
       AgregarAtras2(l, ult,vt2);
   end;
end;

procedure imprimirLista(l:lista2);
begin
   if(l<>nil)then begin
        imprimirLista(l^.sig);
        writeln('El cod es: ',l^.dato.cod);
        writeln('Cantidad:',l^.dato.tot);
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
