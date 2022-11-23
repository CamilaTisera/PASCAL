{5.- Implementar un módulo que realice una búsqueda dicotómica en un vector, utilizando el siguiente encabezado:
   	Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice); 

Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra en el vector.}

program BusquedaDicotomica;
const
  dimf=20;
 type
  vector=array[1..dimf] of integer;
  
procedure cargarVector (var v:vector; var diml:integer);
var
  num:integer;
begin
  writeln('Ingrese un numero');
  readln(num);
   while(num<>0) and (diml <= dimf) do begin
        diml:=diml+1;
        v[diml]:=num;
         writeln('Ingrese un numero');
          readln(num);
     end;
 end;
 
 procedure OrdenacionPorInsercion (var v :vector; diml: integer); //por insercion
var
    i:integer;
    j:integer;
    actual:integer;
begin
    for i := 2 to diml do begin 
        actual:=v[i];  
        j:=i-1;     
     while (j>0) and (v[j] > actual) do begin    
       v[j+1]:=v[j];
       j:=j-1;
     end;
     v[j+1]:=actual;
   end;              
end;
 
 procedure BusquedaDicotomica (v: vector; var pos, num, inicial, fin: integer);
var
    medio: integer;
begin
    if (inicial>fin) then
        pos:=0
    else
    begin
        medio:=(fin+inicial) div 2;
        if (v[medio] = num) then
            pos:=medio
        else begin
            if (v[medio] > num) then begin
                fin:=medio-1;
                BusquedaDicotomica(v,pos,num,inicial,fin)
                end
            else begin
            inicial:=medio+1;
                BusquedaDicotomica(v,pos,num,inicial,fin);
            end;
        end;         
    end;
end;

procedure ImprimirPos(pos:integer; v:vector);
begin
  if (pos<>0) then
    writeln('El numero se encuentra en: ', pos)
  else
    writeln('El numero no existe');
end;
        
var
   v:vector;
   diml, num, ini,fin, pos:integer;
begin
  diml:=0;
  cargarVector(v,diml);
   if (dimL = 0) then 
		writeln ('--- Vector sin elementos, luego de la eliminacion ---')
   else begin
		writeln;
        OrdenacionPorInsercion(v,diml);
    end;
  ini:=1;
  fin:=diml;
  writeln('Ingrese numero a buscar');
  readln(num);
  BusquedaDicotomica(v,pos,num,ini,fin);
  ImprimirPos(pos,v);
  end.
