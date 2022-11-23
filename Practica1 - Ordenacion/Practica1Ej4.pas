{4.- Una librería requiere el procesamiento de la información de sus productos. De cada producto se conoce el código del producto, código de rubro (del 1 al 8) y precio. 
Implementar un programa modularizado que:
a. Lea los datos de los productos y los almacene ordenados por código de producto y agrupados por rubro, en una estructura de datos adecuada.
 El ingreso de los productos finaliza cuando se lee el precio 0.
b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.
c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3. Considerar que puede haber más o menos de 30 productos del rubro 3. 
Si la cantidad de productos del rubro 3 es mayor a 30, almacenar los primeros 30 que están en la lista e ignore el resto. 
d. Ordene, por precio, los elementos del vector generado en b) utilizando alguno de los dos métodos vistos en la teoría. 
e. Muestre los precios del vector ordenado.}
//Arreglar

program vectorLib;
const
  dimf=30;
type

 rubros=1..8;
 
  producto=record
     codP:integer;
     precio:real;
     rubro:rubros;
  end;
  
  lista=^nodo;
  
  nodo=record
    datos:producto;
    sig:lista;
  end;
  
  vector = array [rubros] of lista;
  vecR=array [1..dimf] of producto;
  
{a. Lea los datos de los productos y los almacene ordenados por código de producto y agrupados por rubro, en una estructura de datos adecuada.
 El ingreso de los productos finaliza cuando se lee el precio 0.}
 
procedure CargarVectorLista (var v:vector; var l:lista);
   
   procedure InicializarVector(var v:vector);  
  var
    i:integer;
  begin
   for i:=1 to 8 do
     v[i]:=nil;
  end;     

   procedure leerDatos (var p:producto);
   begin
     write('precio');
      read(p.precio);
     if (p.precio <> 0) then begin
     write('Codigo de producto');
     read(p.codP);
     write('Rubro');
     read(p.rubro);
    end;
  end;
  
Procedure InsertarOrdenadoEnLista(var L: lista; p: producto);
var 
     ant, nue, act: lista;
begin
     new (nue);
     nue^.datos := p;
     act := L;
     while (act<>NIL) and (act^.datos.codP < p.codP) do begin  {ord de menor a mayor}
           ant := act;
           act := act^.sig ;
           end;
     if (act = L) then   
            L:= nue
     else 
            ant^.sig := nue;
     nue^.sig := act ;
end;

var
   p:producto;
begin
    InicializarVector(v);
    leerDatos(p);
     while(p.precio<>0) do begin
           InsertarOrdenadoEnLista(v[p.rubro], p);
            leerDatos(p);
       end;
end;

//Inciso B

procedure ImprimirVectorDeListas(v:vector); 
var
i:integer;
begin
  for i:=1 to 8 do begin
      writeln('Lista',i);
      while(v[i]<>nil)do begin
           writeln(' ', v[i]^.datos.codP);
           v[i]:=v[i]^.sig;
      end;
  end;
end;    

//Inciso C

 procedure cargarVector (v:vector; var vr:vecR; var diml:integer);
 begin
        while (v[3]<> nil) and (diml<dimf) do begin
            diml:=diml+1;
            vr[diml].codP:=v[3]^.datos.codP;
             vr[diml].precio:=v[3]^.datos.precio;
             v[3]:=v[3]^.sig;
          end;
   end;
   
  procedure ImprimirVector(v:vecR; diml:integer);
var
   i:integer;
begin
     for i:=1 to diml do begin
         writeln(v[I].codP);
         writeln(v[I].precio:2:2);
     end;
end;     

//Inciso D

procedure OrdenarVectorPorInsercion (var v:vecR; diml:integer);
var
   p:producto;
   j,i:integer;
begin
    for i:=2 to diml-1 do  begin
        p:=v[i];
        j:=i-1;
       while (j>0) and (v[j].precio > p.precio) do begin
            v[j+1].precio:=v[j].precio;
            v[j+1].codP:=v[j].codP;
            j:= j - 1
       end;
       v[j+1]:=p;
  end;   
 end;

var
  v:vector;
  l:lista;
  vr:vecR;
  diml:integer;
begin
  diml:=0;
  CargarVectorLista(v,l);
  writeln('Imprimir vector de lista');
  ImprimirVectorDeListas(v);
  cargarVector(v, vr,diml);
  write('Imprimir vector');
  ImprimirVector(vr,diml);
  OrdenarVectorPorInsercion(vr,diml);
  write('Imprimir vector ordenado');
   ImprimirVector(vr,diml);
end.
