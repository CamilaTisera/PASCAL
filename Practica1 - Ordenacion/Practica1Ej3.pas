{3.- Netflix ha publicado la lista de películas que estarán disponibles durante el mes de diciembre de 2022. 
De cada película se conoce: código de película, código de género (1: acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélica, 7: documental y 8: terror) y puntaje promedio otorgado por las críticas. 
Implementar un programa modularizado que:
a. Lea los datos de películas y los almacene por orden de llegada y agrupados por código de género, en una estructura de datos adecuada. La lectura finaliza cuando se lee el código de la película -1. 
b. Una vez almacenada la información, genere un vector que guarde, para cada género, el código de película con mayor puntaje obtenido entre todas las críticas.
c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos métodos vistos en la teoría. 
d. Luego de ordenar el vector, muestre el código de película con mayor puntaje y el código de película con menor puntaje.
}


program VectorDeLista;
const
  dimf=8;
type
  genero=1..dimf;
  
  pelicula=record
     codP:integer;
     puntaje:real;
     gen:genero;
   end;
   
   lista=^nodo;
   
   nodo=record
     datos:pelicula;
     sig:lista;
  end;
  
  puntero=record
     pri:lista;
     ult:lista;
   end;
  
  vector = array[genero] of puntero;
  vecMax= array[genero] of pelicula;
  
{a. Lea los datos de películas y los almacene por orden de llegada y agrupados por código de género, en una estructura de datos adecuada. La lectura finaliza cuando se lee el código de la película -1. }

procedure CargarVectorLista (var v:vector; var l:lista);
   
   procedure InicializarVector(var v:vector);  
  var
    i:integer;
  begin
   for i:=1 to dimf do begin
      v[i].pri:=nil;
      v[i].ult:=nil;
      end;
  end;     

   procedure leerDatos (var p:pelicula);
   begin
     write('Codigo de pelicula');
     read(p.codP);
     if (p.codP <> -1) then begin
       write('Puntaje');
       read(p.puntaje);
       write('Genero');
       read(p.gen);
    end;
  end;
  
procedure AgregarAtras (var L, ult: lista; elem: pelicula);
 var 
     nue : lista;
  begin
       new (nue);
       nue^.datos:= elem;
       nue^.sig := NIL;
       
      if ( L<> Nil) then
            ult^.sig := nue
       else
             L:= nue;
       ult := nue;
       end;
       
var
   p:pelicula;
begin
    InicializarVector(v);
    leerDatos(p);
    while(p.codP<>-1) do begin
       AgregarAtras(v[p.gen].pri, v[p.gen].ult,p);
       leerDatos(p);
         end;
     end;

procedure ImprimirVectorDeListas(v:vector); 
var
i:integer;
begin
  for i:=1 to dimf do begin
      writeln('Lista',i);
      while(v[i].pri<>nil)do begin
           writeln(' ', v[i].pri^.datos.codP);
           writeln(' ', v[i].pri^.datos.puntaje:2:2);
           v[i].pri:=v[i].pri^.sig;
      end;
  end;
end;    

//b. Una vez almacenada la información, genere un vector que guarde, para cada género, el código de película con mayor puntaje obtenido entre todas las críticas.

procedure Maximo (var v:vecMax; vl:vector);
var
    i, codM:integer;
    max:real;
 begin
     for i:=1 to dimf do begin
     max:=-1;
     while (vl[i].pri <> nil) do begin
       if (vl[i].pri^.datos.puntaje > max) then begin
          max:= vl[i].pri^.datos.puntaje;
          codM:=vl[i].pri^.datos.codP;
       end;
       vl[i].pri:= vl[i].pri^.sig;
       end;
            v[i].codP:=codM; 
            v[i].puntaje:=max; 
  end;
  end;
  
 procedure ImprimirVector(v:vecMax);
var
   i:integer;
begin
     for i:=1 to dimf do begin
         writeln(v[I].codP);
         writeln(v[I].puntaje:2:2);
     end;
end;     

//Inciso C

procedure OrdenarVectorPorInsercion (var v:vecMax);
var
   p:pelicula;
   j,i:integer;
begin
    for i:=2 to dimf-1 do  begin
        p:=v[i];
        j:=i-1;
       while (j>0) and (v[j].puntaje < p.puntaje) do begin
            v[j+1].codP:=v[j].codP;
            v[j+1].puntaje:=v[j].puntaje;
            j:= j - 1
       end;
       v[j+1]:=p;
  end;   
 end;

var
  v:vector;
  l:lista;
  vm:vecMax;
begin
  CargarVectorLista(v,l);
   write('Vector de lista');
  ImprimirVectorDeListas(v);
  Maximo(vm,v);
  write('Vector Maximo');
  ImprimirVector(vm);
  OrdenarVectorPorInsercion(vm);
  write('Vector Maximo Ordenado');
  ImprimirVector(vm);
  writeln('El codigo de pelicula con mayor puntaje:', vm[1].codP);
  writeln('El codigo de pelicula con menor puntaje:', vm[8].codP);
end.
