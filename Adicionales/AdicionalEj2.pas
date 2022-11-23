{ Una agencia dedicada a la venta de autos ha organizado su stock y, dispone en papel de la información de los autos en venta.
Implementar un programa que:
a)	Genere un árbol binario de búsqueda ordenado por patente identificatoria del auto en venta. Cada nodo del árbol debe contener patente, año de fabricación (2010..2018), la marca y el modelo.
b)	Invoque a un módulo que reciba el árbol generado en a) y una marca y retorne la cantidad de autos de dicha marca que posee la agencia. Mostrar el resultado. 
c)	Invoque a un módulo que reciba el árbol generado en a) y retorne una estructura con la información de los autos agrupados por año de fabricación.
d)	Contenga un módulo que reciba el árbol generado en a) y una patente y devuelva el año de fabricación del auto con dicha patente. Mostrar el resultado. 
}

program Agencia;
type
  rangoAnio=2010..2018;
  
  auto=record
    patente:integer;
    anio:rangoAnio;
    marca:string[20];
    modelo:integer;
  end;

abb=^nodo;

nodo=record
  dato:auto;
  HI:abb;
  HD:abb;
end;

lista=^nodo2;

nodo2=record
 dato:auto;
 sig:lista;
end;

vector=array[rangoAnio] of lista;


//a)	Genere un árbol binario de búsqueda ordenado por patente identificatoria del auto en venta. Cada nodo del árbol debe contener patente, año de fabricación (2010..2018), la marca y el modelo.

procedure leerDatos (var a:auto);
begin 
  writeln('Patente');
  readln(a.patente);
  if(a.patente <> 0) then begin
   writeln('Marca');
  readln(a.marca);
  writeln('Año');
  readln(a.anio);
  writeln('Modelo');
  readln(a.modelo);
  end;
  end;

procedure Insertar (var a:abb; au:auto);
begin
   if(a=nil) then begin
      new(a);
      a^.dato:=au;
      a^.HI:=nil;
      a^.HD:=nil;
   end
  else
   if(a^.dato.patente > au.patente) then
      Insertar(a^.HI, au)
   else
      Insertar(a^.HD, au);
end;

procedure cargarArbol (var a:abb);
var
 au:auto;
begin
  leerDatos(au);
  while (au.patente <> 0) do  begin
      Insertar(a,au);
      leerDatos(au);
    end;
end;

//b)	Invoque a un módulo que reciba el árbol generado en a) y una marca y retorne la cantidad de autos de dicha marca que posee la agencia. Mostrar el resultado. 

procedure Buscar (a:abb; marca:string; var cant:integer);
begin
   if(a<>nil) then begin
     if(a^.dato.marca = marca) then
       cant:=cant + 1;
       Buscar(a^.HI, marca, cant);
       Buscar(a^.HD, marca, cant);
   end;
end;

//c)	Invoque a un módulo que reciba el árbol generado en a) y retorne una estructura con la información de los autos agrupados por año de fabricación.

procedure Inicializar (var v:vector);
var
  i:integer;
 begin
   for i:=2010 to 2018 do
    v[i]:=nil;
 end;
 
Procedure AgregarAdelante(var L:lista; a:auto);
Var nue:Lista;
Begin
    New(nue);
    nue^.dato:=a;
    nue^.sig:=L;
    L:=nue;
End;

procedure Generar (a:abb; var v:vector);
begin
  if (a <> nil) then begin
      AgregarAdelante(v[a^.dato.anio], a^.dato);
  Generar(a^.HI,v);
  Generar(a^.HD,v);
  end;
end;

procedure ImprimirVectorLista (v:vector);

procedure Imprimir (l:lista);
begin
       if(l <> nil) then  begin
        writeln('La patente es: ',l^.dato.patente);
        writeln('La marca es: ' , l^.dato.marca);
         Imprimir (l^.sig);
      end;
end;

var 
  i:integer;
begin
    for i:=2010 to 2018 do begin
      writeln('Año: ', i);
       Imprimir(v[i])
     end;
end;

//d)	Contenga un módulo que reciba el árbol generado en a) y una patente y devuelva el año de fabricación del auto con dicha patente. Mostrar el resultado. 

function BuscarPatente (a:abb; patente:integer):integer;
begin
  if(a = nil) then
    BuscarPatente:=0
  else
    if(a^.dato.patente = patente) then
      BuscarPatente:=a^.dato.anio
    else
       if (a^.dato.patente < patente) then
         BuscarPatente(a^.HI, patente)
       else
          BuscarPatente(a^.HD, patente)
end;

var
 a:abb;
 marca:string;
 cant, patente:integer;
 v:vector;
begin
 a:=nil;
 cant:=0;
 cargarArbol(a);
 if (a=nil) then
   writeln('El arbol esta vacio')
 else begin
 writeln('Ingrese una marca');
 readln(marca);
 Buscar(a,marca, cant);
 writeln('La cantidad de autos de la: ', marca, ' es '  , cant);
 Inicializar(v);
 Generar(a,v);
 ImprimirVectorLista(v);
 writeln('Ingrese patente a buscar');
 readln(patente);
 writeln('El año del auto de dicha patenta es: ',BuscarPatente(a,patente));
 end;
end.
