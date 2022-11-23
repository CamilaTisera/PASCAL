{3- Un supermercado requiere el procesamiento de sus productos. De cada producto se conoce código, rubro (1..10), stock y precio unitario. Se pide:
a)	Generar una estructura adecuada que permita agrupar los productos por rubro. A su vez, para cada rubro, se requiere que la búsqueda de un producto por código sea lo más eficiente posible. 
La lectura finaliza con el código de producto igual a -1..
b)	Implementar un módulo que reciba la estructura generada en a), un rubro y un código de producto y retorne si dicho código existe o no para ese rubro.
c)	Implementar un módulo que reciba la estructura generada en a), y retorne, para cada rubro, el código y stock del producto con mayor código.
d)	Implementar un módulo que reciba la estructura generada en a), dos códigos y retorne, para cada rubro, la cantidad de productos con códigos entre los dos valores ingresados.
}

program Supermercado;
const
  dimf=10;
 type
   rubros=1..dimf;
   
   producto=record
     cod:integer;
     rubro:rubros;
     stock:integer;
     precio:real;
   end;
   
   abb=^nodo;
   
   nodo=record
     dato:producto;
     HI:abb;
     HD:abb;
   end;
   
   vector=array[rubros] of abb;
   
 {a)	Generar una estructura adecuada que permita agrupar los productos por rubro. A su vez, para cada rubro, se requiere que la búsqueda de un producto por código sea lo más eficiente posible. 
La lectura finaliza con el código de producto igual a -1.}

procedure cargarVectorArbol (var v:vector);

procedure InicializarVector (var v:vector);
var
i:integer;
begin
  for i:=1 to dimf do
    v[i]:=nil
end;

procedure leerDatos (var p:producto);
begin
writeln('Ingrese codigo de producto');
readln(p.cod);
if(p.cod<>-1) then begin
writeln('Ingrese rubro');
readln(p.rubro);
writeln('Ingrese stock');
readln(p.stock);
writeln('Ingrese precio');
readln(p.precio);
end;
end;

procedure Insertar (var a:abb; p:producto);
begin
if(a=nil) then begin
new(a);
a^.dato:=p;
a^.HI:=nil;
a^.HD:=nil;
end
else
if(a^.dato.cod > p.cod) then
Insertar(a^.HI, p)
else
Insertar(a^.HD, p);
end;

var
p:producto;
begin
InicializarVector(v);
leerDatos(p);
while(p.cod<>-1) do begin
Insertar(v[p.rubro],p);
leerDatos(p);
end;
end;
 
 function Validar (v:vector; var cant:integer):integer;
 var
 i:integer;
 begin
 for i:=1 to dimf do begin
 if(v[i] = nil) then
 cant:=cant + 1;
 Validar:=cant;
 end;
 end;
 
 {b)	Implementar un módulo que reciba la estructura generada en a), un rubro y un código de producto y retorne si dicho código existe o no para ese rubro.}
 
 procedure BuscarArbol (a:abb; rubro,codigo:integer);
 begin
    if(a^.dato.cod < codigo) then 
           BuscarArbol(a^.HI,rubro,codigo)
       else
           BuscarArbol(a^.HD,rubro,codigo)
 end;
 
 procedure Buscar (v:vector; rubro, codigo:integer);
 begin
  if(v[rubro] = nil) then
     writeln('El arbol de ese rubro esta vacio')
   else
    if(v[rubro]^.dato.cod <> codigo) then
     writeln('El codigo para ese rubro no existe')
    else
     if(v[rubro]^.dato.cod = codigo) then
            writeln('El codigo existe para ese rubro')
     else 
       BuscarArbol(v[rubro], rubro, codigo);
 end;
 
 {c)	Implementar un módulo que reciba la estructura generada en a), y retorne, para cada rubro, el código y stock del producto con mayor código.}
 
procedure buscarMax (a:abb; var stockMax, codMax:integer);
 begin
     if(a = nil) then
        writeln('El arbol esta vacio')
     else
     if (a^.HD<>nil) then
                buscarMax (a^.HD, stockMax, codMax)
     else
        if (a^.dato.cod > codMax) then begin
                 codMax:=a^.dato.cod;
                 stockMax:=a^.dato.stock;
                 writeln('El codigo maximo es: ', codMax , ' y el stock maximo es: ', stockMax)
      end;
end;   

procedure Maximo (v:vector);
var
  i, stockMax,codMax :integer;
begin
  for i:=1 to dimf do begin
      codMax:=-1;
      writeln('Para el rubro: ' , i );
       buscarMax(v[i],stockMax, codMax);        
       writeln;
    end;
end;
 
{d)	Implementar un módulo que reciba la estructura generada en a), dos códigos y retorne, para cada rubro, la cantidad de productos con códigos entre los dos valores ingresados.}

 procedure Rango (a:abb; cod1, cod2: integer; var cant :integer);
 begin
     if(a<>nil)then begin
        if(a^.dato.cod>=cod1) and (a^.dato.cod<=cod2) then begin
            cant:=cant + 1;
             Rango(a^.HI,cod1,cod2, cant);
             Rango(a^.HD,cod1,cod2, cant);
        end
        else
          if(a^.dato.cod< cod1) then
              Rango(a^.HD,cod1,cod2, cant)
          else
            Rango(a^.HI,cod1,cod2, cant);
  end
 end;
 
 procedure BuscarRango (v:vector; cod1, cod2:integer);
 var
  i, cant:integer;
 begin
   for i:=1 to dimf do begin
      cant:=0;
      writeln('Para el rubro: ' , i );
       Rango(v[i],cod1, cod2, cant); 
       writeln('La cantidad es: ', cant);
       writeln;
    end;
 end;

 var
 v:vector;
 cant, rubro, codigo, codigo1:integer;
 begin
 cargarVectorArbol(v);
 cant:=0;
 if(Validar(v,cant) = dimf) then
   writeln('El vector de arbol esta vacio')
  else begin
   writeln;
   writeln('Ingrese un rubro');
   readln(rubro);
    writeln('Ingrese un codigo');
   readln(codigo);
   writeln;
    Buscar(v, rubro,codigo);
    writeln;
    Maximo(v);
   writeln;
    writeln('Ingrese un codigo');
   readln(codigo);
    writeln('Ingrese un codigo');
   readln(codigo1);
   writeln;
   BuscarRango(v,codigo,codigo1);
  end; 
 end.
