{2.	Un cine posee la lista de películas que proyectará durante el mes de octubre. 
De cada película se conoce: código de película, código de género (1: acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélica, 7: documental y 8: terror) y puntaje promedio otorgado por las críticas. 
Implementar un programa que contenga:
a.	Un módulo que lea los datos de películas y los almacene ordenados por código de película y agrupados por código de género, en una estructura de datos adecuada.
 La lectura finaliza cuando se lee el código de película -1. 
b.	Un módulo que reciba la estructura generada en el punto a y retorne una estructura de datos donde estén todas las películas almacenadas ordenadas por código de película.}

program Cine;
const
  dimf=8;
type

  generos=1..dimf;
  
  pelicula=record
    cod:integer;
    genero: generos;
    puntaje:real;
  end;
  
  lista=^nodo;
  
  nodo=record
    dato:pelicula;
    sig:lista;
  end;
  
  vector=array[generos] of lista;
  
   procedure InicializarVectorDeLista (var v:vector);
  var
    i:integer;
  begin
    for i:=1 to dimf do 
      v[i]:=nil;
  end;
  
  procedure leerDatos (var p:pelicula);
  begin
    writeln('Ingrese codigo');
    readln(p.cod);
    if(p.cod<>-1) then begin
    writeln('Ingrese genero');
    readln(p.genero);
    writeln('Ingrese puntaje');
    readln(p.puntaje);
    end;
  end;

  Procedure InsertarOrdenadoEnLista(var L: lista; p: pelicula);
var 
     ant, nue, act: lista;
begin
     new (nue);
     nue^.dato := p;
     act := L;
     while (act<>NIL) and (act^.dato.cod < p.cod) do begin  {ord de menor a mayor}
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
  p:pelicula;
begin
    InicializarVectorDeLista(v);
   leerDatos(p);
   while(p.cod <> -1 ) do begin
       InsertarOrdenadoEnLista(v[p.genero], p);
       leerDatos(p);
   end;
end;
  
  procedure ImprimirVectorLista (v:vector);

procedure Imprimir (l:lista);
begin
       if(l <> nil) then  begin
        writeln('El cod es: ',l^.dato.cod);
        writeln('El puntaje es: ' , l^.dato.puntaje:2:2);
         Imprimir (l^.sig);
      end;
end;

var 
  i:integer;
begin
    for i:=1 to dimf do begin
      writeln('Genero: ', i);
       Imprimir(v[i])
     end;
end;

  Procedure AgregarAtras (var l, ult: lista; p:pelicula);
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

Procedure BuscarMinimo(var v:vector;var min:pelicula);
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

Procedure Merge(var l: lista; v: vector);
Var
   min:pelicula; 
   ult:lista;
Begin
   ult:=nil;
   BuscarMinimo(v,min);
   while(min.cod<>999) do begin
        AgregarAtras(l,ult,min);
        BuscarMinimo(v,min);
   end;
End;

procedure imprimirLista(l:lista);
begin
   if(l<>nil)then begin
        imprimirLista(l^.sig);
        writeln('El isbn es: ',l^.dato.cod);
        writeln('Genero:',l^.dato.genero);
        writeln('Cantidad:',l^.dato.puntaje:2:2);
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
 begin
  l:=nil;
  cargarVectorLista(v);
  if (Vacio(v) = dimf) then
     writeln('El vector de lista esta vacio')
   else begin
  writeln('Imprimir vector de lista');
  writeln;
  ImprimirVectorLista(v);
  Merge(l,v);
  writeln;
  writeln('Imprimir Merge');
  imprimirLista(l);
  end;
 end.
