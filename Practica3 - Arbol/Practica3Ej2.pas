{2.	Escribir un programa que:
a. Implemente un módulo que lea información de ventas de un comercio. De cada venta se lee código de producto, fecha y cantidad de unidades vendidas. 
La lectura finaliza con el código de producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de producto.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por código de producto. Cada nodo del árbol debe contener el código de producto y la cantidad total vendida.
               Nota: El módulo debe retornar los dos árboles.
b. Implemente un módulo que reciba el árbol generado en i. y un código de producto y retorne la cantidad total de unidades vendidas de ese producto.
c. Implemente un módulo que reciba el árbol generado en ii. y un código de producto y retorne la cantidad total de unidades vendidas de ese producto.}

program Comercio;
type
 
  venta=record
     cod:integer;
     fecha:integer;
     cant:integer;
  end;
  
  abb= ^nodo;
  
  nodo=record
    dato:venta;
    HI:abb;
    HD:abb;
  end;
  
    abb1= ^nodo1;
  
  nodo1=record
    dato:venta;
    HI:abb1;
    HD:abb1;
  end;
  
  procedure  cargarArbol (var a:abb);
  
  procedure leerDatos (var v:venta);
  begin
     writeln('Ingrese codigo');
     readln(v.cod);
     if(v.cod <> 0) then begin
         writeln('Ingrese fecha');
		readln(v.fecha);
		writeln('Ingrese cant');
		readln(v.cant);
     end;
  end;
  
  procedure InsertarArbol (var a:abb; v:venta);
  begin
      if(a=nil) then begin
        new(a);
        a^.dato:=v;
        a^.HI:=nil;
         a^.HD:=nil;
      end
      else
       if(a^.dato.cod >= v.cod) then
          InsertarArbol (a^.HI,v)
        else 
         if(a^.dato.cod <= v.cod) then
          InsertarArbol (a^.HD, v)
  end;
  
  var
     v:venta;
  begin
     leerDatos(v);
     while(v.cod <> 0) do begin
        InsertarArbol(a, v);
         leerDatos(v);
  end;
end;

procedure Imprimir (a:abb);
begin
   if(a <> nil) then begin
       Imprimir(a^.HI);
        Imprimir(a^.HD);
       writeln('Codigo: ',a^.dato.cod);
       writeln('Cantidad: ',a^.dato.cant);
       writeln('Fecha: ', a^.dato.fecha);
     end;
end;

  procedure  cargarNuevoArbol (a:abb; var a1:abb1 );
  
  procedure InsertarArbolNuevo (var a1:abb1; v:venta);
  begin
      if(a1=nil) then begin
        new(a1);
        a1^.dato:=v;
        a1^.HI:=nil;
         a1^.HD:=nil;
      end
      else
          if(a1^.dato.cod >v.cod) then
              InsertarArbolNuevo (a1^.HI,v)
        else 
           if( a1^.dato.cod < v.cod) then
               InsertarArbolNuevo (a1^.HD,v)
         else
                 a1^.dato.cant:=a1^.dato.cant + v.cant;
  end;

  begin
        if (a <> nil) then begin
                 InsertarArbolNuevo(a1, a^.dato);              
                cargarNuevoArbol(a^.HI, a1);
               cargarNuevoArbol(a^.HD, a1);
         end;
 end;

procedure ImprimirNuevo (a1:abb1);
begin
   if(a1 <> nil) then begin
       ImprimirNuevo(a1^.HI);
        ImprimirNuevo(a1^.HD);
       writeln('Codigo: ',a1^.dato.cod);
       writeln('Cantidad total: ',a1^.dato.cant);
     end;
end;

function Buscar (a:abb; valor:integer) : integer; //	Que pasa con los codigos repetidos
 begin
     if (a=nil) then 
             Buscar:=0
     else
      if(valor = a^.dato.cod) then
         Buscar:=a^.dato.cant
      else
        if (a^.dato.cod > valor)  then
             Buscar:= Buscar(a^.HI, valor)
         else
               Buscar:= Buscar(a^.HD, valor)              
end;   

function BuscarA (a:abb1; valor:integer) : integer;
 begin
     if (a=nil) then 
             BuscarA:=0
     else
      if(valor = a^.dato.cod) then
         BuscarA:=a^.dato.cant
      else
        if (a^.dato.cod > valor)  then
             BuscarA:= BuscarA(a^.HI, valor)
         else
               BuscarA:= BuscarA(a^.HD, valor)              
end;   

var
  a:abb;
  a1:abb1;
  valor:integer;
begin
    a:=nil;
    a1:=nil;
   cargarArbol(a);
   if (a=nil) then
      writeln('El arbol esta vacio')
    else begin
       writeln('Primer arbol');
       Imprimir(a);
       cargarNuevoArbol(a,a1);
       writeln;
       writeln;
       writeln('Segundo arbol');
       ImprimirNuevo(a1);
       writeln('Ingrese un valor');
       readln(valor);
       writeln('La cantidad de unidades vendidas del codigo: ' ,valor ,' es ', Buscar(a,valor));
        writeln('Ingrese un valor');
       readln(valor);
       writeln('La cantidad de unidades vendidas del codigo: ' ,valor ,' es ', BuscarA(a1,valor));
    end;
end.
